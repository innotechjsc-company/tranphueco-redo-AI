import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../shared/widgets/logo.dart';
class _Sparkle extends StatelessWidget {
  final double top;
  final double? right;
  final double? left;
  final double size;
  final double opacity;
  const _Sparkle({
    required this.top,
    this.right,
    this.left,
    required this.size,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      left: left,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.brandGold.withValues(alpha: opacity),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class LoginHeroHeader extends StatefulWidget {
  const LoginHeroHeader({super.key});

  @override
  State<LoginHeroHeader> createState() => _LoginHeroHeaderState();
}

class _LoginHeroHeaderState extends State<LoginHeroHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.4, end: 1.0).animate(_pulse);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/Trang chủ.png', fit: BoxFit.cover),
          ),
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xB30B1B3D),
                    Color(0x990B1B3D),
                    AppColors.background,
                  ],
                ),
              ),
            ),
          ),
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.background,
                    Colors.transparent,
                    Color(0x660B1B3D),
                  ],
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _opacity,
            builder: (_, __) => Opacity(
              opacity: _opacity.value,
              child: const _Sparkle(top: 64, right: 48, size: 6, opacity: 1.0),
            ),
          ),
          const _Sparkle(top: 112, right: 96, size: 4, opacity: 0.7),
          AnimatedBuilder(
            animation: _opacity,
            builder: (_, __) => Opacity(
              opacity: _opacity.value * 0.6,
              child: const _Sparkle(top: 160, left: 40, size: 4, opacity: 1.0),
            ),
          ),
          const _LogoBlock(),
        ],
      ),
    );
  }
}

class _LogoBlock extends StatelessWidget {
  const _LogoBlock();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              width: 108,
              height: 108,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: 0.7,
                    child: ImageFiltered(
                      imageFilter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        width: 108,
                        height: 108,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppGradients.gold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 104,
                    height: 104,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppGradients.gold,
                    ),
                  ),
                  Container(
                    width: 96,
                    height: 96,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 25),
                          blurRadius: 50,
                          color: Color(0x40000000),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: OverflowBox(
                        maxWidth: 192,
                        maxHeight: 192,
                        child: Image.asset(
                          'assets/images/logo.png', // Fallback to logo.png in case brand/logo doesn't exist
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Logo(size: 96),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 20),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Chào mừng ',
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: 'trở lại',
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: [AppColors.brandGoldLight, AppColors.brandGold],
                      ).createShader(const Rect.fromLTWH(0, 0, 120, 40)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'DẪN ĐẦU TƯƠNG LAI · ECOTP',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.brandGold.withValues(alpha: 0.8),
              letterSpacing: 2.5,
            ),
          ),
          ],
        ),
      ),
    );
  }
}
