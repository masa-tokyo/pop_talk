import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pop_talk/domain/model/talk_item.dart';

enum PlayerButtonState {
  playing,
  paused,
  loading,
}

class PlayerNotifier extends ChangeNotifier {
  PlayerButtonState playerButtonState = PlayerButtonState.paused;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  int currentIndex = 0;

  AudioPlayer? _audioPlayer;

  Future<void> reset() async {
    await _audioPlayer?.dispose();
    _audioPlayer = null;
    playerButtonState = PlayerButtonState.paused;
    position = Duration.zero;
    duration = Duration.zero;
    notifyListeners();
  }

  Future<void> initPlayer({
    List<TalkItem>? talks,
    String? path,
  }) async {
    assert(talks != null || path != null);
    await reset();
    final currentPlayer = _audioPlayer = AudioPlayer();
    if (talks != null) {
      await currentPlayer.setAudioSource(
        ConcatenatingAudioSource(
          useLazyPreparation: true,
          children: talks.map((talk) {
            return AudioSource.uri(talk.uri);
          }).toList(),
        ),
        initialPosition: Duration.zero,
        preload: false,
      );
    } else {
      await currentPlayer.setFilePath(path!);
    }

    currentPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;

      // プレイヤーステータスの変更
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        playerButtonState = PlayerButtonState.loading;
      } else {
        playerButtonState =
            isPlaying ? PlayerButtonState.playing : PlayerButtonState.paused;
      }

      // 挙動の変更
      if (isPlaying && processingState == ProcessingState.completed) {
        if (currentPlayer.hasNext) {
          currentPlayer
            ..seekToNext()
            ..play();
        } else {
          currentPlayer
            ..seek(Duration.zero)
            ..pause();
        }
      }
      notifyListeners();
    });

    currentPlayer.currentIndexStream.listen((event) {
      if (event != null) {
        currentIndex = event;
      }
      notifyListeners();
    });

    currentPlayer.positionStream.listen((event) {
      position = event;
      notifyListeners();
    });

    currentPlayer.durationStream.listen((event) {
      duration = event ?? Duration.zero;
      notifyListeners();
    });
  }

  Future<void> play() async {
    await _audioPlayer!.play();
  }

  Future<void> pause() async {
    await _audioPlayer!.pause();
  }

  Future<void> seek(int newPosition) async {
    position = Duration(seconds: newPosition);
    notifyListeners();

    await _audioPlayer!.seek(Duration(seconds: newPosition));
  }

  bool hasPrevious() {
    return _audioPlayer != null && _audioPlayer!.hasPrevious;
  }

  Future<void> seekToPrevious() async {
    if (_audioPlayer == null || !_audioPlayer!.hasPrevious) {
      return;
    }
    await _audioPlayer!.seekToPrevious();
  }

  bool hasNext() {
    return _audioPlayer != null && _audioPlayer!.hasNext;
  }

  Future<void> seekToNext() async {
    if (_audioPlayer == null || !_audioPlayer!.hasNext) {
      return;
    }
    await _audioPlayer!.seekToNext();
  }
}

final playerProvider = ChangeNotifierProvider<PlayerNotifier>((ref) {
  return PlayerNotifier();
});
