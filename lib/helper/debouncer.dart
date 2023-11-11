import 'dart:async';
import 'package:grocery_app/helper/custom_timer.dart';

class Debouncer {
  final int milliseconds;
  CustomTimer _timer;

  Debouncer({required this.milliseconds})
      : _timer = CustomTimer(Duration.zero, () async {});

  run(Future<void> Function() action) {
    _timer.cancel();
    _timer = CustomTimer(Duration(milliseconds: milliseconds), action);
  }

  Future<void> skip() async {
    await _timer.skip();
  }

  bool get isActive => _timer.isActive;
}
