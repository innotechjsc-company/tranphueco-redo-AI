import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/theme/app_colors.dart';
import '../widgets/step_card.dart';

class OtpInput extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;
  const OtpInput({super.key, required this.value, required this.onChanged});

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String v) {
    if (v.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    final all = _controllers.map((c) => c.text).join();
    widget.onChanged(all);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (i) {
        return Container(
          width: 48,
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.value.length > i
                  ? AppColors.brandRed
                  : AppColors.border,
            ),
          ),
          child: TextField(
            controller: _controllers[i],
            focusNode: _focusNodes[i],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
            ),
            onChanged: (v) => _onChanged(i, v),
          ),
        );
      }),
    );
  }
}

class StepOtp extends StatelessWidget {
  final String otp;
  final ValueChanged<String> onOtpChanged;
  final VoidCallback onNext;
  const StepOtp({
    super.key,
    required this.otp,
    required this.onOtpChanged,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final isComplete = otp.length == 6;
    return Column(
      children: [
        StepCard(
          icon: Icons.shield_outlined,
          title: 'Mã OTP',
          desc: 'Bảo mật 6 chữ số',
          children: [
            Center(
              child: OtpInput(value: otp, onChanged: onOtpChanged),
            ),
            const SizedBox(height: 12),
            if (isComplete)
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: AppColors.brandRed, size: 14),
                  SizedBox(width: 4),
                  Text(
                    'ĐANG XÁC THỰC...',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.brandRed,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              )
            else
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Gửi lại mã sau 00:45',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.mutedForeground,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    '[GỬI LẠI]',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.brandGold,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            Opacity(
              opacity: isComplete ? 1 : 0.5,
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: isComplete ? onNext : null,
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
                        'Xác nhận',
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
