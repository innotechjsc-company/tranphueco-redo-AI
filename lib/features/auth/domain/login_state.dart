class LoginState {
  final String phone;
  final String password;
  final bool showPassword;
  final bool rememberMe;
  final bool submitting;
  const LoginState({
    this.phone = '0901234567',
    this.password = '123456',
    this.showPassword = false,
    this.rememberMe = true,
    this.submitting = false,
  });

  LoginState copyWith({
    String? phone,
    String? password,
    bool? showPassword,
    bool? rememberMe,
    bool? submitting,
  }) =>
      LoginState(
        phone: phone ?? this.phone,
        password: password ?? this.password,
        showPassword: showPassword ?? this.showPassword,
        rememberMe: rememberMe ?? this.rememberMe,
        submitting: submitting ?? this.submitting,
      );
}
