import 'package:flutter/material.dart';
import 'dart:async';

class CountdownTimerProvider with ChangeNotifier {
  static const int initialMinutes = 15;
  int _seconds = initialMinutes * 60;
  Timer? _timer;
  bool _isPaused = true;

  int get seconds => _seconds;
  bool get isPaused => _isPaused;

  CountdownTimerProvider() {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused && _seconds > 0) {
        _seconds--;
        notifyListeners();
      } else if (_seconds == 0) {
        _timer?.cancel();
      }
    });
  }

  void pauseTimer() {
    _isPaused = true;
    notifyListeners();
  }

  void resumeTimer() {
    _isPaused = false;
    notifyListeners();
  }

  void increaseTimer() {
    _seconds += 15 * 60;
    notifyListeners();
  }

  void decreaseTimer() {
    if (_seconds > 15 * 60) {
      _seconds -= 15 * 60;
    } else {
      _seconds = 0;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
