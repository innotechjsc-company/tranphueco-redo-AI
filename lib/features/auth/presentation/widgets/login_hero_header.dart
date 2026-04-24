import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
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
            child:
                Image.asset('assets/images/Trang chủ.png', fit: BoxFit.cover),
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
    return Positioned(
      bottom: 50,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.brandGold.withValues(alpha: 0.4),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Logo(size: 80),
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
    );
  }
}
