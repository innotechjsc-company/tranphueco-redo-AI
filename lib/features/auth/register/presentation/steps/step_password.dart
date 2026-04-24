import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../widgets/step_card.dart';

class PasswordStrength extends StatelessWidget {
  final String password;
  const PasswordStrength({super.key, required this.password});

  int _score(String v) {
    var s = 0;
    if (v.length >= 6) s++;
    if (RegExp(r'[A-Za-z]').hasMatch(v) && RegExp(r'\d').hasMatch(v)) s++;
    if (v.length >= 10) s++;
    return s;
  }

  static const _labels = ['Yếu', 'Trung bình', 'Mạnh', 'Rất mạnh'];
  static const _colors = [
    AppColors.muted,
    AppColors.brandRed,
    AppColors.brandOrange,
    AppColors.brandGold,
  ];

  @override
  Widget build(BuildContext context) {
    final score = _score(password).clamp(0, 3);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(4, (i) {
            return Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
                decoration: BoxDecoration(
                  color: i <= score ? _colors[score] : AppColors.muted,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 4),
        if (password.isNotEmpty)
          Text(
            _labels[score],
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: _colors[score],
            ),
          ),
      ],
    );
  }
}

class BiometricToggle extends StatelessWidget {
  final bool enabled;
  final VoidCallback onToggle;
  const BiometricToggle(
      {super.key, required this.enabled, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: enabled
                ? AppColors.brandGold.withValues(alpha: 0.5)
                : AppColors.border,
          ),
          gradient: enabled
              ? LinearGradient(
                  colors: [
                    AppColors.brandGold.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                )
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: enabled
                    ? AppColors.brandGold.withValues(alpha: 0.2)
                    : AppColors.muted,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.fingerprint,
                color:
                    enabled ? AppColors.brandGold : AppColors.mutedForeground,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Đăng nhập sinh trắc học',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Dùng vân tay hoặc Face ID',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: enabled,
              onChanged: (_) => onToggle(),
              activeThumbColor: AppColors.brandRed,
            ),
          ],
        ),
      ),
    );
  }
}

class StepPassword extends StatelessWidget {
  final String password;
  final bool biometric;
  final ValueChanged<String> onPasswordChanged;
  final VoidCallback onBiometricToggle;
  final VoidCallback onNext;
  const StepPassword({
    super.key,
    required this.password,
    required this.biometric,
    required this.onPasswordChanged,
    required this.onBiometricToggle,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final isValid = password.length >= 6;
    return Column(
      children: [
        StepCard(
          icon: Icons.lock_outline,
          title: 'Mật khẩu',
          desc: 'Bảo vệ tài khoản của bạn',
          children: [
            TextField(
              obscureText: true,
              onChanged: onPasswordChanged,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: 'Tối thiểu 6 ký tự',
                hintStyle:
                    TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                prefixIcon: Icon(Icons.lock_outline,
                    size: 20, color: Colors.white.withValues(alpha: 0.5)),
                filled: true,
                fillColor: AppColors.secondary,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            PasswordStrength(password: password),
            const SizedBox(height: 16),
            BiometricToggle(enabled: biometric, onToggle: onBiometricToggle),
            const SizedBox(height: 16),
            Opacity(
              opacity: isValid ? 1 : 0.5,
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: isValid ? onNext : null,
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.brandRed, AppColors.brandRedDark],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.brandRed.withValues(alpha: 0.35),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Tiếp tục',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
