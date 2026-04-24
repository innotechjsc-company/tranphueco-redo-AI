import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 80,
          child: Opacity(
            opacity: 0.2,
            child: SvgPicture.asset(
              'assets/images/footer.svg',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => context.go('/register'),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                    children: [
                      TextSpan(text: 'Chưa có tài khoản? '),
                      TextSpan(
                        text: 'Đăng ký ngay',
                        style: TextStyle(
                          color: AppColors.brandGold,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '© 2026 Trần Phú ECOTP · v1.0.0',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 10,
                  color: AppColors.mutedForeground,
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ],
    );
  }
}
