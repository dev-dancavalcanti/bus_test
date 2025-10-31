import 'package:bus_teste/viewmodels/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show Ticker;

class TickerViewModel extends ChangeNotifier {
  final UserViewModel viewmodel;
  TickerViewModel(this.viewmodel);

  Ticker? _ticker;
  int _lastExecutedSecond = -1;
  bool _isTickerPaused = false;
  int _currentCountdown = 5;

  bool get isTickerPaused => _isTickerPaused;
  int get currentCountdown => _currentCountdown;

  void initializeTicker(TickerProvider tickerProvider) {
    _ticker = tickerProvider.createTicker((elapsed) {
      if (_isTickerPaused) return;

      final currentSecond = elapsed.inSeconds;

      final remainder = currentSecond % 5;
      final newCountdown = remainder == 0 ? 5 : 5 - remainder;

      if (_currentCountdown != newCountdown) {
        _currentCountdown = newCountdown;
        notifyListeners();
      }

      if (remainder == 0 &&
          currentSecond > 0 &&
          _lastExecutedSecond != currentSecond &&
          !viewmodel.userCommand.value.isRunning) {
        _lastExecutedSecond = currentSecond;
        viewmodel.userCommand.execute();
      }
    });

    _resetState();
    _ticker?.start();
  }

  void _resetState() {
    _lastExecutedSecond = -1;
    _currentCountdown = 5;
    notifyListeners();
  }

  void toggleTicker() {
    _isTickerPaused = !_isTickerPaused;

    if (_isTickerPaused) {
      _ticker?.stop();
    } else {
      _resetState();
      _ticker?.start();
    }

    notifyListeners();
  }

  void stopTicker() {
    _ticker?.stop();
  }

  void pauseForNavigation() {
    if (!_isTickerPaused) {
      _isTickerPaused = true;
      _ticker?.stop();
      notifyListeners();
    }
  }

  void startTicker() {
    if (_isTickerPaused) {
      _isTickerPaused = false;
      _resetState();
      _ticker?.start();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _ticker?.dispose();
    super.dispose();
  }
}
