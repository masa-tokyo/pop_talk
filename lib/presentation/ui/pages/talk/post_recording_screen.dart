import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pop_talk/presentation/notifier/recording.dart';
import 'package:pop_talk/presentation/ui/templates/talk/after_recording_page.dart';
import 'package:pop_talk/presentation/ui/templates/talk/before_recording_page.dart';
import 'package:pop_talk/presentation/ui/templates/talk/during_recording_page.dart';
import 'package:pop_talk/presentation/ui/templates/talk/talk_edit_page.dart';

enum ScreenState {
  beforeRecording,
  duringRecording,
  afterRecording,
  edit,
}

class PostRecordingScreen extends StatefulWidget {
  const PostRecordingScreen({required this.talkTopicId});
  final String talkTopicId;

  @override
  _PostRecordingScreenState createState() => _PostRecordingScreenState();
}

class _PostRecordingScreenState extends State<PostRecordingScreen> {
  ScreenState _screenState = ScreenState.beforeRecording;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final FlutterSoundRecorder _flutterSoundRecorder = FlutterSoundRecorder();
  StreamSubscription? _recorderSubscription;

  String _path = '';
  bool _isRecorderInitiated = false;
  Duration _duration = Duration();

  @override
  void initState() {
    super.initState();

    _openTheRecorder().then((value) {
      _isRecorderInitiated = true;
      _setSubscriptionDuration();
      _flutterSoundRecorder.onProgress!.listen((event) {
        _duration = event.duration;
      });
    });
  }

  @override
  void dispose() {
    _stopRecording();
    _flutterSoundRecorder.closeAudioSession();

    final outputFile = File(_path);
    if (outputFile.existsSync()) {
      outputFile.delete();
    }

    if (_recorderSubscription != null) {
      _recorderSubscription!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //todo single child scroll view for when keyboard pops up

    return Scaffold(
      body: Stack(alignment: AlignmentDirectional.topStart, children: [
        _page(context),
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close,
                size: 28,
              )),
        ),
      ]),
    );
  }

  Widget _page(BuildContext context) {
    Widget page;

    switch (_screenState) {
      case ScreenState.beforeRecording:
        page = BeforeRecordingPage(
            onRecordingButtonPressed: _onRecordingButtonPressed);
        break;
      case ScreenState.duringRecording:
        page = DuringRecordingPage(
            onStopButtonPressed: _onStopButtonPressed,
            stream: _flutterSoundRecorder.onProgress!,);
        break;
      case ScreenState.afterRecording:
        page = AfterRecordingPage(
            onAgainButtonPressed: _onAgainButtonPressed,
            onEditButtonPressed: _onEditButtonPressed,);
        break;
      case ScreenState.edit:
        page = TalkEditPage(
            titleController: _titleController,
            descriptionController: _descriptionController,
            onPostButtonPressed: _onPostButtonPressed,
            onDraftSaveButtonPressed: _draftSaveButtonPressed,);
        break;
    }
    return page;
  }

  Future<void> _onRecordingButtonPressed() async{
      setState(() {
        _screenState = ScreenState.duringRecording;
      });
      await _startRecording();

  }

  Future<void> _onStopButtonPressed() async{
    await _stopRecording();
    setState(() {
      _screenState = ScreenState.afterRecording;
    });
  }

  void _onAgainButtonPressed() {
    //delete the recording
    final outputFile = File(_path);
    if (outputFile.existsSync()) {
      outputFile.delete();
    }
    setState(() {
      _screenState = ScreenState.beforeRecording;
    });
  }

  void _onEditButtonPressed() {
    setState(() {
      _screenState = ScreenState.edit;
    });
  }

  Future<void> _onPostButtonPressed() async{
    final recordingNotifier
                      = context.read<RecordingNotifier>(recordingProvider);
    await recordingNotifier.postRecording(
      title: _titleController.text,
      description: _descriptionController.text,
      path: _path,
      duration: _duration,
      talkTopicId: widget.talkTopicId
    );

    Navigator.pop(context);
  }

  void _draftSaveButtonPressed() {
    Navigator.pop(context);

  }


  //-----------------------------------------------------------Recording Methods
  Future<void> _openTheRecorder() async {
    //upgraded the minimum SDK version of Android(23) to encode AAC ADTS
    //todo [check] upgrade minimum OS version of iOS(10.0)?

    //todo permission

    final temDir = await getTemporaryDirectory();
    _path = '${temDir.path}/flutter_sound_example.aac';
    final outputFile = File(_path);
    if (outputFile.existsSync()) {
      await outputFile.delete();
    }
    await _flutterSoundRecorder.openAudioSession();
  }

  Future<void> _setSubscriptionDuration() async {
    //todo [check] can be less than 1 second?
    await _flutterSoundRecorder
        .setSubscriptionDuration(const Duration(seconds: 1));
  }

  Future<void> _startRecording() async {
    if (!_isRecorderInitiated) return; //todo [check] maybe assert?
    await _flutterSoundRecorder.startRecorder(
      toFile: _path,
      codec: Codec.aacADTS,
    );
  }

  Future<void> _stopRecording() async {
    await _flutterSoundRecorder.stopRecorder();
  }

}
