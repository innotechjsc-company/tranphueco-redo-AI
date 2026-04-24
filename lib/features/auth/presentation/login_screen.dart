import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../application/login_controller.dart';
import 'widgets/login_hero_header.dart';
import 'widgets/login_form_card.dart';
import 'widgets/login_footer.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key, this.prefillPhone, this.prefillPwd});
  final String? prefillPhone;
  final String? prefillPwd;

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(loginControllerProvider.notifier)
          .hydrate(phone: widget.prefillPhone, pwd: widget.prefillPwd);
    });
  }

  Future<void> _onSubmit() async {
    await ref.read(loginControllerProvider.notifier).submit();
    if (!mounted) return;
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const LoginHeroHeader(),
            Padding(
              padding: const EdgeInsets.only(top: 320),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: LoginFormCard(onSubmit: _onSubmit),
                  ),
                  const LoginFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
