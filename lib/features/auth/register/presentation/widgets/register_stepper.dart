import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_gradients.dart';

class RegisterStepper extends StatelessWidget {
  const RegisterStepper({super.key, required this.step});
  final int step;

  static const _labels = ['Số điện thoại', 'Mã OTP', 'Mật khẩu', 'Hồ sơ'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A0B1B3D),
                blurRadius: 30,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: List.generate(4, (i) {
              final id = i + 1;
              final completed = step > id;
              final active = step == id;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: 6,
                    decoration: BoxDecoration(
                      gradient: completed ? AppGradients.gold : null,
                      color: completed
                          ? null
                          : active
                              ? AppColors.brandRed
                              : AppColors.secondary,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _labels[step - 1].toUpperCase(),
          style: const TextStyle(
            fontSize: 10,
            letterSpacing: 1.5,
            color: AppColors.mutedForeground,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
