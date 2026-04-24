import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_gradients.dart';
import '../widgets/step_card.dart';

class StepPhone extends StatelessWidget {
  final String phone;
  final ValueChanged<String> onPhoneChanged;
  final VoidCallback onNext;
  const StepPhone({
    super.key,
    required this.phone,
    required this.onPhoneChanged,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StepCard(
          icon: Icons.phone_outlined,
          title: 'Số điện thoại',
          desc: 'Xác minh thiết bị của bạn',
          children: [
            TextField(
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: onPhoneChanged,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: '0901 234 567',
                hintStyle:
                    TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                prefixIcon: Icon(Icons.phone_outlined,
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
            const SizedBox(height: 16),
            Opacity(
              opacity: phone.length >= 9 ? 1 : 0.5,
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: phone.length >= 9 ? onNext : null,
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: AppGradients.red,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x59E11D2E),
                          blurRadius: 24,
                          offset: Offset(0, 12),
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
        const SizedBox(height: 24),
        GestureDetector(
          onTap: () => context.go('/login'),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 14, color: Colors.white70),
              children: [
                TextSpan(text: 'Đã có tài khoản? '),
                TextSpan(
                  text: 'Đăng nhập',
                  style: TextStyle(
                    color: AppColors.brandGold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
