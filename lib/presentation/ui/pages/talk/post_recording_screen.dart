import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:logger/logger.dart' show Level;
import 'package:path_provider/path_provider.dart';
import 'package:pop_talk/domain/model/talk_topic.dart';
import 'package:pop_talk/presentation/notifier/my_talk.dart';
import 'package:pop_talk/presentation/notifier/player.dart';
import 'package:pop_talk/presentation/notifier/recording.dart';
import 'package:pop_talk/presentation/ui/pages/register.dart';
import 'package:pop_talk/presentation/ui/templates/talk/after_recording_page.dart';
import 'package:pop_talk/presentation/ui/templates/talk/before_recording_page.dart';
import 'package:pop_talk/presentation/ui/templates/talk/during_recording_page.dart';
import 'package:pop_talk/presentation/ui/templates/talk/talk_edit_page.dart';
import 'package:uuid/uuid.dart';

enum ScreenState {
  beforeRecording,
  duringRecording,
  afterRecording,
  edit,
}

class PostRecordingScreen extends StatefulWidget {
  const PostRecordingScreen(
      {required this.talkTopicId, required this.talkTopic});
  final String talkTopicId;
  final TalkTopic talkTopic;

  @override
  _PostRecordingScreenState createState() => _PostRecordingScreenState();
}

class _PostRecordingScreenState extends State<PostRecordingScreen> {
  ScreenState _screenState = ScreenState.beforeRecording;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final FlutterSoundRecorder _flutterSoundRecorder = FlutterSoundRecorder(
    logLevel: Level.error,
  );
  StreamSubscription? _recorderSubscription;

  String _path = '';
  bool _isRecorderInitiated = false;
  Duration _duration = Duration();
  bool _isSaveFile = false;

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

    if (!_isSaveFile) {
      final outputFile = File(_path);
      if (outputFile.existsSync()) {
        outputFile.delete();
      }
    }

    if (_recorderSubscription != null) {
      _recorderSubscription!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          onRecordingButtonPressed: _onRecordingButtonPressed,
          talkTopicName: widget.talkTopic.name,
        );
        break;
      case ScreenState.duringRecording:
        page = DuringRecordingPage(
          onStopButtonPressed: _onStopButtonPressed,
          stream: _flutterSoundRecorder.onProgress!,
          talkTopicName: widget.talkTopic.name,
        );
        break;
      case ScreenState.afterRecording:
        page = AfterRecordingPage(
          onAgainButtonPressed: _onAgainButtonPressed,
          onEditButtonPressed: _onEditButtonPressed,
          talkTopic: widget.talkTopic,
          path: _path,
        );
        break;
      case ScreenState.edit:
        page = TalkEditPage(
          titleController: _titleController,
          descriptionController: _descriptionController,
          onPostButtonPressed: _onPostButtonPressed,
          onDraftSaveButtonPressed: _onDraftSaveButtonPressed,
          talkTopicName: widget.talkTopic.name,
        );
        break;
    }
    return page;
  }

  Future<void> _onRecordingButtonPressed() async {
    setState(() {
      _screenState = ScreenState.duringRecording;
    });
    await _startRecording();
  }

  Future<void> _onStopButtonPressed() async {
    await _stopRecording();
    setState(() {
      _screenState = ScreenState.afterRecording;
      context
          .read(playerProvider)
          .initPlayer(AudioPlayType.single, uri: Uri.file(_path));
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

  Future<void> _onPostButtonPressed() async {
    final recordingNotifier =
        context.read<RecordingNotifier>(recordingProvider);

    if (recordingNotifier.authedUser.isAnonymous) {
      await showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return RegisterPage(isMember: false, modalSetState: setState);
            });
          });
    } else {
      await recordingNotifier.postRecording(
          title: _titleController.text,
          description: _descriptionController.text,
          path: _path,
          duration: _duration,
          talkTopicId: widget.talkTopicId);

      Navigator.pop(context);
    }
  }

  Future<void> _onDraftSaveButtonPressed() async {
    final recordingNotifier =
        context.read<RecordingNotifier>(recordingProvider);
    await recordingNotifier.saveDraft(
      title: _titleController.text,
      description: _descriptionController.text,
      path: _path,
      duration: _duration,
      talkTopicId: widget.talkTopicId,
    );

    _isSaveFile = true;
    Navigator.pop(context);
  }

  //-----------------------------------------------------------Recording Methods
  Future<void> _openTheRecorder() async {
    //todo permission

    final docDir = await getApplicationDocumentsDirectory();
    final fileName = const Uuid().v1();
    _path = '${docDir.path}/$fileName.aac';

    await _flutterSoundRecorder.openAudioSession();
  }

  Future<void> _setSubscriptionDuration() async {
    await _flutterSoundRecorder
        .setSubscriptionDuration(const Duration(milliseconds: 1));
  }

  Future<void> _startRecording() async {
    assert(_isRecorderInitiated);
    await _flutterSoundRecorder.startRecorder(
      toFile: _path,
      codec: Codec.aacADTS,
    );
  }

  Future<void> _stopRecording() async {
    await _flutterSoundRecorder.stopRecorder();
  }
}
