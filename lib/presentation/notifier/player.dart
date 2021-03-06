import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/infrastructure/tracking.dart';

enum PlayerButtonState {
  playing,
  paused,
  loading,
}

enum AudioPlayType {
  single,
  playlist,
}

class PlayerNotifier extends ChangeNotifier {
  AudioPlayType? playType;
  AudioPlayer? _audioPlayer;
  List<TalkItem>? playList;
  PlayerButtonState playerButtonState = PlayerButtonState.paused;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  TalkItem? get currentTalk {
    if (_audioPlayer == null ||
        playType != AudioPlayType.playlist ||
        playList == null ||
        playList!.isEmpty) {
      return null;
    }
    return playList![_audioPlayer!.currentIndex ?? 0];
  }

  Future<void> reset() async {
    await _audioPlayer?.dispose();
    _audioPlayer = null;
    playList = null;
    playType = null;
    playerButtonState = PlayerButtonState.paused;
    position = Duration.zero;
    duration = Duration.zero;
    notifyListeners();
  }

  Future<void> initPlayer(
    AudioPlayType playType, {
    List<TalkItem>? talks,
    Uri? uri,
  }) async {
    await reset();
    final currentPlayer = _audioPlayer = AudioPlayer();
    this.playType = playType;
    if (playType == AudioPlayType.playlist) {
      playList = talks;
      await currentPlayer.setAudioSource(
        ConcatenatingAudioSource(
          useLazyPreparation: true,
          children: talks!.map((talk) {
            return AudioSource.uri(talk.uri);
          }).toList(),
        ),
        initialPosition: Duration.zero,
        preload: false,
      );
    } else {
      await currentPlayer.setAudioSource(
        ConcatenatingAudioSource(
            useLazyPreparation: true, children: [AudioSource.uri(uri!)]),
      );
    }

    currentPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;

      // ???????????????????????????????????????
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        playerButtonState = PlayerButtonState.loading;
      } else {
        playerButtonState =
            isPlaying ? PlayerButtonState.playing : PlayerButtonState.paused;
      }

      // ???????????????
      if (isPlaying && processingState == ProcessingState.completed) {
        if (currentPlayer.hasNext) {
          currentPlayer
            ..seekToNext()
            ..play();
          _trackPlayEvent();
        } else {
          currentPlayer
            ..seek(Duration.zero)
            ..pause();
        }
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
    _trackPlayEvent();
    notifyListeners();
  }

  void _trackPlayEvent() {
    if (currentTalk == null) {
      return;
    }
    Tracking().logEvent(
      eventType: EventType.playTalk,
      eventParams: <String, dynamic>{
        'talkId': currentTalk!.id,
      },
    );
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
    notifyListeners();
  }

  bool hasNext() {
    return _audioPlayer != null && _audioPlayer!.hasNext;
  }

  Future<void> seekToNext() async {
    if (_audioPlayer == null || !_audioPlayer!.hasNext) {
      return;
    }
    await _audioPlayer!.seekToNext();
    notifyListeners();
  }

  bool hasPlayer() {
    return _audioPlayer != null;
  }
}

final playerProvider = ChangeNotifierProvider<PlayerNotifier>((ref) {
  return PlayerNotifier();
});

final playerFamilyProvider =
    ChangeNotifierProvider.family<PlayerNotifier, String>(
  (ref, category) {
    final notifier = PlayerNotifier();
    return notifier;
  },
);
