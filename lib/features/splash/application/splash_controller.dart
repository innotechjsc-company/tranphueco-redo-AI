import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashState {
  final double progress;
  final bool completed;
  const SplashState({this.progress = 0, this.completed = false});

  SplashState copyWith({double? progress, bool? completed}) => SplashState(
        progress: progress ?? this.progress,
        completed: completed ?? this.completed,
      );
}

class SplashController extends StateNotifier<SplashState> {
  SplashController() : super(const SplashState()) {
    _start();
  }

  static const _duration = Duration(milliseconds: 2400);
  static const _tick = Duration(milliseconds: 30);
  Timer? _timer;
  late final DateTime _startedAt;

  void _start() {
    _startedAt = DateTime.now();
    _timer = Timer.periodic(_tick, (t) {
      final elapsed = DateTime.now().difference(_startedAt).inMilliseconds;
      final p = (elapsed / _duration.inMilliseconds).clamp(0.0, 1.0);
      state = state.copyWith(progress: p);
      if (p >= 1.0) {
        t.cancel();
        state = state.copyWith(completed: true);
      }
    });
  }

  void skip() {
    _timer?.cancel();
    state = state.copyWith(progress: 1.0, completed: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final splashControllerProvider =
    StateNotifierProvider.autoDispose<SplashController, SplashState>(
  (ref) => SplashController(),
);
