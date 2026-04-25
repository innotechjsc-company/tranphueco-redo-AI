import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/primary_button.dart';

final _stepProvider = StateProvider.autoDispose<int>((ref) => 1);
final _phoneProvider = StateProvider.autoDispose<String>((ref) => '');
final _otpProvider = StateProvider.autoDispose<String>((ref) => '');
final _pwdProvider = StateProvider.autoDispose<String>((ref) => '');
final _nameProvider = StateProvider.autoDispose<String>((ref) => '');
final _doneProvider = StateProvider.autoDispose<bool>((ref) => false);

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  static const _steps = [
    {'label': 'Số điện thoại', 'sub': 'Xác minh thiết bị'},
    {'label': 'Mã OTP', 'sub': 'Bảo mật 6 chữ số'},
    {'label': 'Mật khẩu', 'sub': 'Bảo vệ tài khoản'},
    {'label': 'Hồ sơ', 'sub': 'Hoàn tất'},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final step = ref.watch(_stepProvider);
    final done = ref.watch(_doneProvider);

    ref.listen<bool>(_doneProvider, (_, isDone) {
      if (isDone) {
        Future.delayed(const Duration(milliseconds: 1600), () {
          if (context.mounted) context.go('/login');
        });
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      if (step == 1) {
                        context.pop();
                      } else {
                        ref.read(_stepProvider.notifier).state = step - 1;
                      }
                    },
                  ),
                  Expanded(
                    child: Text('Đăng ký tài khoản', style: AppTextStyles.h3),
                  ),
                ],
              ),
            ),
            // Stepper
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: List.generate(4, (i) {
                  final active = i + 1 <= step;
                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: active ? AppColors.brandRed : AppColors.muted,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: [
                  Text(
                    'Bước $step/4: ${_steps[step - 1]['label']}',
                    style: AppTextStyles.bodySm,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                child:
                    done ? _buildDone(context) : _buildStep(context, ref, step),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, WidgetRef ref, int step) {
    switch (step) {
      case 1:
        return _StepPhone(ref: ref);
      case 2:
        return _StepOtp(ref: ref);
      case 3:
        return _StepPassword(ref: ref);
      case 4:
        return _StepProfile(ref: ref);
      default:
        return const SizedBox();
    }
  }

  Widget _buildDone(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 64),
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: AppColors.brandRed,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 40),
        ),
        const SizedBox(height: 24),
        Text('Đăng ký thành công!', style: AppTextStyles.h2),
        const SizedBox(height: 8),
        Text(
          'Đang chuyển đến trang đăng nhập...',
          style: AppTextStyles.body.copyWith(color: AppColors.mutedForeground),
        ),
      ],
    );
  }
}

class _StepPhone extends StatelessWidget {
  final WidgetRef ref;
  const _StepPhone({required this.ref});

  @override
  Widget build(BuildContext context) {
    final phone = ref.watch(_phoneProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Số điện thoại', style: AppTextStyles.h4),
        const SizedBox(height: 8),
        TextField(
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            hintText: '0901 234 567',
            prefixIcon: Icon(Icons.phone_outlined),
          ),
          onChanged: (v) => ref.read(_phoneProvider.notifier).state = v,
        ),
        const SizedBox(height: 24),
        PrimaryButton(
          label: 'Tiếp tục',
          enabled: phone.length >= 10,
          onPressed: () => ref.read(_stepProvider.notifier).state = 2,
        ),
      ],
    );
  }
}

class _StepOtp extends StatelessWidget {
  final WidgetRef ref;
  const _StepOtp({required this.ref});

  @override
  Widget build(BuildContext context) {
    final otp = ref.watch(_otpProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nhập mã OTP', style: AppTextStyles.h4),
        const SizedBox(height: 4),
        Text('Mã xác nhận đã gửi đến số điện thoại của bạn',
            style: AppTextStyles.bodySm),
        const SizedBox(height: 16),
        TextField(
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(6),
          ],
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 24, letterSpacing: 12, fontWeight: FontWeight.bold),
          decoration: const InputDecoration(hintText: '••••••'),
          onChanged: (v) => ref.read(_otpProvider.notifier).state = v,
        ),
        const SizedBox(height: 24),
        PrimaryButton(
          label: 'Xác nhận',
          enabled: otp.length == 6,
          onPressed: () => ref.read(_stepProvider.notifier).state = 3,
        ),
      ],
    );
  }
}

class _StepPassword extends StatelessWidget {
  final WidgetRef ref;
  const _StepPassword({required this.ref});

  @override
  Widget build(BuildContext context) {
    final pwd = ref.watch(_pwdProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tạo mật khẩu', style: AppTextStyles.h4),
        const SizedBox(height: 8),
        TextField(
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Tối thiểu 6 ký tự',
            prefixIcon: Icon(Icons.lock_outline),
          ),
          onChanged: (v) => ref.read(_pwdProvider.notifier).state = v,
        ),
        const SizedBox(height: 24),
        PrimaryButton(
          label: 'Tiếp tục',
          enabled: pwd.length >= 6,
          onPressed: () => ref.read(_stepProvider.notifier).state = 4,
        ),
      ],
    );
  }
}

class _StepProfile extends StatelessWidget {
  final WidgetRef ref;
  const _StepProfile({required this.ref});

  @override
  Widget build(BuildContext context) {
    final name = ref.watch(_nameProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Thông tin cá nhân', style: AppTextStyles.h4),
        const SizedBox(height: 8),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Họ và tên',
            prefixIcon: Icon(Icons.person_outline),
          ),
          onChanged: (v) => ref.read(_nameProvider.notifier).state = v,
        ),
        const SizedBox(height: 24),
        PrimaryButton(
          label: 'Hoàn tất đăng ký',
          enabled: name.length >= 2,
          onPressed: () => ref.read(_doneProvider.notifier).state = true,
        ),
      ],
    );
  }
}
