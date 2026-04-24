import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';

class PhoneField extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  const PhoneField({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: '0901234567',
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.2)),
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
    );
  }
}
