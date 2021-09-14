import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

enum PlayerButtonState {
  playing, paused, loading,
}

enum AudioPlayType {
  url, file, playlist,
}
class PlayerNotifier extends ChangeNotifier {

  PlayerButtonState playerButtonState = PlayerButtonState.paused;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  int currentIndex = 0;

  late AudioPlayer _audioPlayer;

  Future<void> initPlayer(
  {required AudioPlayType playType,
  String? path,
  List<String>? urls}
      ) async {

    switch (playType) {
      case AudioPlayType.url:
      // TODO(any): マイトークのプレビュー画面の投稿再生に使用
        _audioPlayer = AudioPlayer();

        break;
      case AudioPlayType.file:
        _audioPlayer = AudioPlayer();
        await _audioPlayer.setFilePath(path!);
        break;
      case AudioPlayType.playlist:
        _audioPlayer = AudioPlayer();
        await _audioPlayer.setAudioSource(
        ConcatenatingAudioSource(
            useLazyPreparation: true,
            children: _convertToAudioSources(urls)),
        initialIndex: 0,
        initialPosition: Duration.zero,
      );
        break;
    }


    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;

      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering){
        print('loading');
        playerButtonState = PlayerButtonState.loading;
      } else if (!isPlaying){
        playerButtonState = PlayerButtonState.paused;
      } else if (processingState != ProcessingState.completed){
        playerButtonState = PlayerButtonState.playing;
      } else {
        //completed

        if(playType == AudioPlayType.playlist){
          if (currentIndex < urls!.length - 1){
            _audioPlayer
              ..seekToNext()
              ..play();
          } else {
            // the last track
            _audioPlayer
                ..seek(Duration.zero)
                ..pause();
          }

        } else {
          // AudioPlayType is file or url
          _audioPlayer
              ..seek(Duration.zero)
              ..pause();
        }
      }
      notifyListeners();
    });

    _audioPlayer.currentIndexStream.listen((event) {
      currentIndex = event!;
      notifyListeners();
    });

    _audioPlayer.positionStream.listen((event) {
      position = event;
      notifyListeners();
    });

    _audioPlayer.durationStream.listen((event) {
      duration = event ?? Duration.zero;
      notifyListeners();
    });
  }

  List<AudioSource> _convertToAudioSources(List<String>? urls) {
    final  audioSources = <AudioSource>[];
    urls!.forEach((element) {
      audioSources.add(AudioSource.uri(Uri.parse(element)));
    });
    return audioSources;

  }


  Future<void> play() async{
    await _audioPlayer.play();

  }

  Future<void> pause() async{

    await _audioPlayer.pause();



  }


  Future<void> seek(int newPosition) async{
    position = Duration(seconds: newPosition);
    notifyListeners();

    await _audioPlayer.seek(Duration(seconds: newPosition));

  }

  Future<void> seekToPrevious() async {
    await _audioPlayer.seekToPrevious();
  }

  Future<void> seekToNext() async{
    await _audioPlayer.seekToNext();

  }











}

final playerProvider = ChangeNotifierProvider<PlayerNotifier>((ref){

  return PlayerNotifier();
});