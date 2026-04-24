import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/register_state.dart';

final registerControllerProvider =
    StateNotifierProvider.autoDispose<RegisterController, RegisterState>(
  (ref) => RegisterController(),
);

class RegisterController extends StateNotifier<RegisterState> {
  RegisterController() : super(const RegisterState());

  void next() {
    if (state.step < 4) state = state.copyWith(step: state.step + 1);
  }

  void back() {
    if (state.step > 1) state = state.copyWith(step: state.step - 1);
  }

  void setPhone(String v) =>
      state = state.copyWith(phone: v.replaceAll(RegExp(r'[^0-9]'), ''));
  void setOtp(String v) => state = state.copyWith(otp: v);
  void setPassword(String v) => state = state.copyWith(password: v);
  void toggleBiometric() => state = state.copyWith(biometric: !state.biometric);
  void setName(String v) => state = state.copyWith(name: v);
  void finish() => state = state.copyWith(done: true);
}
