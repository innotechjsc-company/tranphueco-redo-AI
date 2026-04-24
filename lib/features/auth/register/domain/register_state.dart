class RegisterState {
  final int step;
  final String phone;
  final String otp;
  final String password;
  final bool biometric;
  final String name;
  final bool done;
  const RegisterState({
    this.step = 1,
    this.phone = '',
    this.otp = '',
    this.password = '',
    this.biometric = true,
    this.name = '',
    this.done = false,
  });

  RegisterState copyWith({
    int? step,
    String? phone,
    String? otp,
    String? password,
    bool? biometric,
    String? name,
    bool? done,
  }) =>
      RegisterState(
        step: step ?? this.step,
        phone: phone ?? this.phone,
        otp: otp ?? this.otp,
        password: password ?? this.password,
        biometric: biometric ?? this.biometric,
        name: name ?? this.name,
        done: done ?? this.done,
      );
}
