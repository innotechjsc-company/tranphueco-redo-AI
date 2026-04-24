import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_gradients.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock/mock_providers.dart';
import '../../shared/widgets/logo.dart';
import '../../shared/widgets/glass_card.dart';

class SpinPage extends ConsumerStatefulWidget {
  const SpinPage({super.key});

  @override
  ConsumerState<SpinPage> createState() => _SpinPageState();
}

class _SpinPageState extends ConsumerState<SpinPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  double _angle = 0;
  bool _spinning = false;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _spin() {
    if (_spinning) return;
    setState(() => _spinning = true);

    final random = Random();
    final targetAngle = 2 * pi * 8 + random.nextDouble() * 2 * pi;

    _ctrl.reset();
    final anim =
        Tween<double>(begin: _angle, end: _angle + targetAngle).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCirc),
    );
    anim.addListener(() => setState(() => _angle = anim.value));
    _ctrl.forward().then((_) {
      setState(() => _spinning = false);
      _showResult();
    });
  }

  void _showResult() {
    // Logic hiển thị kết quả chuẩn demo
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Chúc mừng! Bạn nhận được 1.000 điểm'),
        backgroundColor: AppColors.brandRed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(LucideIcons.chevronLeft,
                        color: Colors.white, size: 28),
                    onPressed: () => context.pop(),
                  ),
                  const Text(
                    'VÒNG QUAY MAY MẮN',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Logo(size: 32),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 14, color: Colors.white),
                children: [
                  TextSpan(text: 'Bạn còn '),
                  TextSpan(
                    text: '1 lượt quay',
                    style: TextStyle(
                        color: AppColors.brandGold,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' miễn phí hôm nay'),
                ],
              ),
            ),
            const Spacer(),

            // Wheel UI
            SizedBox(
              width: 320,
              height: 320,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Shadow / Glow
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.brandGold.withValues(alpha: 0.15),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  // Rotating Wheel
                  Transform.rotate(
                    angle: _angle,
                    child: CustomPaint(
                      size: const Size(300, 300),
                      painter: _DemoWheelPainter(),
                    ),
                  ),
                  // Center Button "QUAY"
                  GestureDetector(
                    onTap: _spin,
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.brandRed,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              blurRadius: 10),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'QUAY',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  // Top Pointer
                  const Positioned(
                    top: -5,
                    child: Icon(Icons.arrow_drop_down_rounded,
                        size: 60, color: Colors.white),
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Rules Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GlassCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(LucideIcons.sparkles,
                            color: AppColors.brandGold, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'THỂ LỆ',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _ruleItem('Mỗi ngày 1 lượt quay miễn phí.'),
                    _ruleItem('Lượt thêm có thể đổi bằng điểm tích lũy.'),
                    _ruleItem('Quà tặng được cộng trực tiếp vào ví.'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _ruleItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ',
              style: TextStyle(
                  color: AppColors.brandGold, fontWeight: FontWeight.bold)),
          Expanded(
              child: Text(text,
                  style: const TextStyle(color: Colors.white70, fontSize: 12))),
        ],
      ),
    );
  }
}

class _DemoWheelPainter extends CustomPainter {
  final List<Color> colors = [
    const Color(0xFFD22A2D), // Red
    const Color(0xFFF5E1A4), // Beige
    const Color(0xFF161828), // Black
    const Color(0xFFE8CC6A), // Gold
    const Color(0xFFD22A2D),
    const Color(0xFFF5E1A4),
    const Color(0xFF161828),
    const Color(0xFFE8CC6A),
  ];

  final List<String> labels = [
    '100đ',
    '50đ',
    'Voucher 50K',
    '200đ',
    'Chúc mừng',
    '1.000đ',
    'Quay lại',
    '500đ'
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const sliceAngle = 2 * pi / 8;

    for (int i = 0; i < 8; i++) {
      final paint = Paint()..color = colors[i];
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2 + sliceAngle * i,
        sliceAngle,
        true,
        paint,
      );

      // Label
      final labelAngle = -pi / 2 + sliceAngle * i + sliceAngle / 2;
      final labelRadius = radius * 0.7;
      final labelOffset = Offset(
        center.dx + labelRadius * cos(labelAngle),
        center.dy + labelRadius * sin(labelAngle),
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(
            color: (colors[i] == const Color(0xFFF5E1A4) ||
                    colors[i] == const Color(0xFFE8CC6A))
                ? const Color(0xFF161828)
                : Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w900,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      canvas.save();
      canvas.translate(labelOffset.dx, labelOffset.dy);
      canvas.rotate(labelAngle + pi / 2);
      textPainter.paint(
          canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
      canvas.restore();
    }

    // Outer line
    canvas.drawCircle(
        center,
        radius,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.1)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
