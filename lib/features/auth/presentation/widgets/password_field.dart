import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class PasswordField extends StatelessWidget {
  final String value;
  final bool obscure;
  final ValueChanged<String> onChanged;
  final VoidCallback onToggle;
  const PasswordField({
    super.key,
    required this.value,
    required this.obscure,
    required this.onChanged,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      obscureText: obscure,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: 'Mật khẩu',
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.2)),
        prefixIcon: Icon(Icons.lock_outline,
            size: 20, color: Colors.white.withValues(alpha: 0.5)),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility,
              size: 20, color: Colors.white.withValues(alpha: 0.5)),
          onPressed: onToggle,
        ),
        filled: true,
        fillColor: AppColors.secondary,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
