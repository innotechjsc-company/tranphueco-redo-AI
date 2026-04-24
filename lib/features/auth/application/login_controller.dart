import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/login_state.dart';

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, LoginState>(
  (ref) => LoginController(),
);

class LoginController extends StateNotifier<LoginState> {
  LoginController() : super(const LoginState());

  void hydrate({String? phone, String? pwd}) {
    state = state.copyWith(
      phone: phone ?? state.phone,
      password: pwd ?? state.password,
    );
  }

  void setPhone(String v) => state = state.copyWith(phone: v);
  void setPassword(String v) => state = state.copyWith(password: v);
  void togglePassword() =>
      state = state.copyWith(showPassword: !state.showPassword);
  void toggleRemember() =>
      state = state.copyWith(rememberMe: !state.rememberMe);

  Future<void> submit() async {
    state = state.copyWith(submitting: true);
    await Future.delayed(const Duration(milliseconds: 350));
    state = state.copyWith(submitting: false);
  }
}
