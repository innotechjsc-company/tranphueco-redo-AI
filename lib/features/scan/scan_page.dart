import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_gradients.dart';
import '../../shared/widgets/logo.dart';

class ScanPage extends ConsumerWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(LucideIcons.chevronLeft, color: Colors.white, size: 28),
                    onPressed: () => context.pop(),
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'QUÉT MÃ',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white),
                        ),
                        Text(
                          'Hướng camera vào mã QR',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Logo(size: 32),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Mode Toggle (QR / Barcode)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _scanModeTab('QR Code', LucideIcons.qrCode, true),
                  ),
                  Expanded(
                    child: _scanModeTab('Barcode', LucideIcons.scan, false),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Viewfinder - Chuẩn demo
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Camera placeholder overlay
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withValues(alpha: 0.05), width: 1),
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    height: 280,
                    child: CustomPaint(painter: const _ScanCorners()),
                  ),
                  // Scan line (static for now, can be animated)
                  Container(
                    width: 240,
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.brandRed.withValues(alpha: 0),
                          AppColors.brandRed,
                          AppColors.brandRed.withValues(alpha: 0),
                        ],
                      ),
                    ),
                  ),
                  // QR ghost icon in center
                  const Icon(LucideIcons.qrCode, color: Colors.white10, size: 80),
                ],
              ),
            ),

            const Spacer(),

            // Bottom Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Đặt mã trong khung hình để xác thực sản phẩm chính hãng và tích điểm tự động.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.6), height: 1.5),
              ),
            ),

            const SizedBox(height: 40),

            // Mock Success Button
            TextButton(
              onPressed: () => context.push('/scan/result'),
              child: Text(
                'Mô phỏng quét thành công',
                style: TextStyle(color: AppColors.brandRed.withValues(alpha: 0.5), fontSize: 12),
              ),
            ),
            
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _scanModeTab(String label, IconData icon, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        gradient: active ? AppGradients.red : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: active ? Colors.white : Colors.white30),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: active ? FontWeight.w900 : FontWeight.w700,
              color: active ? Colors.white : Colors.white30,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScanCorners extends CustomPainter {
  const _ScanCorners();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.brandRed
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    const length = 40.0;
    const radius = 24.0;

    // Top Left
    canvas.drawPath(
      Path()
        ..moveTo(0, length)
        ..lineTo(0, radius)
        ..arcToPoint(const Offset(radius, 0), radius: const Radius.circular(radius))
        ..lineTo(length, 0),
      paint,
    );

    // Top Right
    canvas.drawPath(
      Path()
        ..moveTo(size.width - length, 0)
        ..lineTo(size.width - radius, 0)
        ..arcToPoint(Offset(size.width, radius), radius: const Radius.circular(radius))
        ..lineTo(size.width, length),
      paint,
    );

    // Bottom Right
    canvas.drawPath(
      Path()
        ..moveTo(size.width, size.height - length)
        ..lineTo(size.width, size.height - radius)
        ..arcToPoint(Offset(size.width - radius, size.height), radius: const Radius.circular(radius))
        ..lineTo(size.width - length, size.height),
      paint,
    );

    // Bottom Left
    canvas.drawPath(
      Path()
        ..moveTo(length, size.height)
        ..lineTo(radius, size.height)
        ..arcToPoint(Offset(0, size.height - radius), radius: const Radius.circular(radius))
        ..lineTo(0, size.height - length),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
