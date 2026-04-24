import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/logo.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _currentPage = 0;

  static const _slides = [
    {
      'step': 'BƯỚC 01 - CHÍNH HÃNG',
      'title': 'Quét mã — xác thực\nsản phẩm Trần Phú',
      'desc':
          'Mỗi cuộn cáp Trần Phú đều mang mã xác thực riêng. Quét QR / Barcode trên bao bì để kiểm tra hàng chính hãng và nhận điểm ECOTP tức thì.',
      'image': 'assets/images/onboarding_1.png',
    },
    {
      'step': 'BƯỚC 02 - TÍCH ĐIỂM',
      'title': 'Tích lũy ECOTP\nĐổi ngàn quà tặng',
      'desc':
          'Điểm ECOTP dùng để đổi các phần quà giá trị: thẻ cào, thiết bị điện, gia dụng và nhiều ưu đãi đặc quyền dành riêng cho bạn.',
      'image': 'assets/images/onboarding_2.jpg',
    },
    {
      'step': 'BƯỚC 03 - KẾT NỐI',
      'title': 'Cộng đồng đối tác\nDẫn đầu tương lai',
      'desc':
          'Gia nhập cộng đồng đối tác tin cậy của Trần Phú. Nhận thông tin kỹ thuật, tin tức thị trường và hỗ trợ trực tuyến 24/7.',
      'image': 'assets/images/onboarding_3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Image with Gradient Overlay
          PageView.builder(
            controller: _controller,
            itemCount: _slides.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (_, i) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(_slides[i]['image']!, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.4),
                          Colors.black.withValues(alpha: 0.1),
                          AppColors.background.withValues(alpha: 0.8),
                          AppColors.background,
                        ],
                        stops: const [0.0, 0.4, 0.7, 0.9],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      const Logo(size: 32),
                      const SizedBox(width: 8),
                      const Text(
                        'ECOTP',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: AppColors.brandGold,
                            letterSpacing: 1),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => context.go('/login'),
                        child: const Text('Bỏ qua',
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Text Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _slides[_currentPage]['step']!,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: AppColors.brandGold,
                            letterSpacing: 1),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _slides[_currentPage]['title']!,
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _slides[_currentPage]['desc']!,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.7),
                            height: 1.5),
                      ),
                      const SizedBox(height: 24),
                      // Indicators
                      Row(
                        children: List.generate(3, (i) {
                          final active = i == _currentPage;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 6),
                            width: active ? 32 : 8,
                            height: 4,
                            decoration: BoxDecoration(
                              color:
                                  active ? AppColors.brandGold : Colors.white24,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 32),
                      // CTA Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_currentPage < 2) {
                              _controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOutCubic);
                            } else {
                              context.go('/login');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.brandRed,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(99)),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _currentPage < 2 ? 'Tiếp tục' : 'Bắt đầu ngay',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w900),
                              ),
                              const SizedBox(width: 8),
                              const Icon(LucideIcons.chevronRight, size: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Login Footer
                      Center(
                        child: GestureDetector(
                          onTap: () => context.go('/login'),
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                  fontSize: 13, color: Colors.white70),
                              children: [
                                TextSpan(text: 'Đã có tài khoản? '),
                                TextSpan(
                                    text: 'Đăng nhập',
                                    style: TextStyle(
                                        color: AppColors.brandGold,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
