import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/mobile_shell.dart';
import '../application/splash_controller.dart';
import 'widgets/splash_background.dart';
import 'widgets/splash_brand_top.dart';
import 'widgets/splash_logo_block.dart';
import 'widgets/splash_loader.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SplashState>(splashControllerProvider, (prev, next) {
      if (next.completed && (prev?.completed ?? false) == false) {
        context.go('/onboarding');
      }
    });

    final state = ref.watch(splashControllerProvider);

    return MobileShell(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => ref.read(splashControllerProvider.notifier).skip(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const SplashBackground(),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 56),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SplashBrandTop(),
                    const SplashLogoBlock(),
                    SplashLoader(progress: state.progress),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
