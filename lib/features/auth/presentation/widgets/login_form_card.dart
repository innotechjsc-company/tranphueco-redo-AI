import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../application/login_controller.dart';
import 'phone_field.dart';
import 'password_field.dart';
import 'remember_checkbox.dart';

class LoginFormCard extends ConsumerWidget {
  final Future<void> Function() onSubmit;
  const LoginFormCard({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(loginControllerProvider);
    final c = ref.read(loginControllerProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  gradient: AppGradients.gold,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(LucideIcons.shieldCheck,
                    color: AppColors.brandNavyDeep, size: 20),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ĐĂNG NHẬP',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: AppColors.mutedForeground,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    'Tài khoản thành viên',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          PhoneField(
            value: s.phone,
            onChanged: c.setPhone,
          ),
          const SizedBox(height: 16),
          PasswordField(
            value: s.password,
            obscure: !s.showPassword,
            onChanged: c.setPassword,
            onToggle: c.togglePassword,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RememberCheckbox(
                value: s.rememberMe,
                onTap: c.toggleRemember,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Quên mật khẩu?',
                  style: TextStyle(
                    color: AppColors.brandRed,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              style: FilledButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ).copyWith(
                backgroundColor:
                    WidgetStateProperty.resolveWith((_) => Colors.transparent),
              ),
              onPressed: s.submitting ? null : onSubmit,
              child: Ink(
                decoration: BoxDecoration(
                  gradient: AppGradients.red,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: AppShadows.brand,
                ),
                child: Center(
                  child: Text(
                    s.submitting ? 'Đang xử lý...' : 'Đăng nhập',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
