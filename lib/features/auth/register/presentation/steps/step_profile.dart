import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_gradients.dart';
import '../widgets/step_card.dart';

class StepProfile extends StatelessWidget {
  final String name;
  final ValueChanged<String> onNameChanged;
  final VoidCallback onFinish;
  const StepProfile({
    super.key,
    required this.name,
    required this.onNameChanged,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    final isValid = name.trim().length >= 2;
    return Column(
      children: [
        StepCard(
          icon: Icons.person_outline,
          title: 'Họ và tên',
          desc: 'Hoàn tất thông tin cá nhân',
          children: [
            TextField(
              onChanged: onNameChanged,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: 'Nguyễn Văn A',
                hintStyle:
                    TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                prefixIcon: Icon(Icons.person_outline,
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
            const SizedBox(height: 24),
            Opacity(
              opacity: isValid ? 1 : 0.5,
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: isValid ? onFinish : null,
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: AppGradients.red,
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
                        'Hoàn tất',
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
