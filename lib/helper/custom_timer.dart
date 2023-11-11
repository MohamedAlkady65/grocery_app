import 'dart:async';

class CustomTimer {
  final Timer _timer;
  final Future<void> Function() _action;
  CustomTimer(Duration duration, this._action)
      : _timer = Timer(duration, _action);

  bool get isActive => _timer.isActive;

  void cancel() {
    _timer.cancel();
  }

  Future<void> skip() async {
    if (_timer.isActive) {
      _timer.cancel();
      await _action();
    }
  }
}
