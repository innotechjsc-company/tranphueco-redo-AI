import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../application/register_controller.dart';
import '../domain/register_state.dart';
import 'widgets/register_header.dart';
import 'widgets/register_stepper.dart';
import 'steps/step_phone.dart';
import 'steps/step_otp.dart';
import 'steps/step_password.dart';
import 'steps/step_profile.dart';
import 'steps/step_done.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final s = ref.watch(registerControllerProvider);
    final c = ref.read(registerControllerProvider.notifier);

    ref.listen(registerControllerProvider.select((v) => v.otp), (prev, next) {
      if (s.step == 2 && next.length == 6) {
        Future.delayed(const Duration(milliseconds: 350), c.next);
      }
    });

    ref.listen(registerControllerProvider.select((v) => v.done), (_, isDone) {
      if (isDone) {
        Future.delayed(const Duration(milliseconds: 2500), () {
          if (!mounted) return;
          context.go('/login?phone=${s.phone}&pwd=${s.password}');
        });
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            RegisterHeader(
              step: s.step,
              onBack: () {
                if (s.step == 1) {
                  context.pop();
                } else {
                  c.back();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 204),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: RegisterStepper(step: s.step),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildBody(s, c),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(RegisterState s, RegisterController c) {
    if (s.done) return StepDone(name: s.name);
    switch (s.step) {
      case 1:
        return StepPhone(
          phone: s.phone,
          onPhoneChanged: c.setPhone,
          onNext: c.next,
        );
      case 2:
        return StepOtp(
          otp: s.otp,
          onOtpChanged: c.setOtp,
          onNext: c.next,
        );
      case 3:
        return StepPassword(
          password: s.password,
          biometric: s.biometric,
          onPasswordChanged: c.setPassword,
          onBiometricToggle: c.toggleBiometric,
          onNext: c.next,
        );
      case 4:
        return StepProfile(
          name: s.name,
          onNameChanged: c.setName,
          onFinish: c.finish,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
