import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GachaTimerNotifier with ChangeNotifier {
  GachaTimerNotifier() {
    _setTimer();
    _shouldChargeChecker = _createChecker();
  }

  static const maxRemainingCount = 3;

  static const chargeIntervalMinutes = 3;

  int remainingCount = maxRemainingCount;

  late DateTime nextChargeTime;

  late int remainSeconds;

  late final Timer _shouldChargeChecker;

  @override
  void dispose() {
    _shouldChargeChecker.cancel();
    super.dispose();
  }

  void play() {
    if (remainingCount == 0) {
      return;
    }
    remainingCount--;
    _setTimer(
      setNextChargeTime:
          (remainingCount == (maxRemainingCount - 1)) ? null : nextChargeTime,
    );
    notifyListeners();
  }

  void _setTimer({
    DateTime? setNextChargeTime,
  }) {
    nextChargeTime = setNextChargeTime ??
        DateTime.now().add(
          const Duration(minutes: chargeIntervalMinutes),
        );
    remainSeconds = nextChargeTime.difference(DateTime.now()).inSeconds;
    notifyListeners();
  }

  Timer _createChecker() {
    return Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      if (now.difference(nextChargeTime).inMilliseconds >= 0) {
        if (remainingCount < maxRemainingCount) {
          remainingCount++;
        }
        _setTimer();
      } else {
        _setTimer(setNextChargeTime: nextChargeTime);
      }
    });
  }
}

final gachaTimerProvider = ChangeNotifierProvider<GachaTimerNotifier>(
  (ref) => GachaTimerNotifier(),
);
