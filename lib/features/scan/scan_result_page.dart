import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_gradients.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock/mock_providers.dart';
import '../../shared/widgets/brand_header.dart';
import '../../shared/widgets/glass_card.dart';

class ScanResultPage extends ConsumerWidget {
  const ScanResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(scannedProductProvider);

    return Container(
      decoration: const BoxDecoration(gradient: AppGradients.dark),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              const BrandHeader(title: 'Kết quả quét'),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                  child: Column(
                    children: [
                      // Success badge
                      Container(
                        width: 72,
                        height: 72,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2ECC71),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check,
                            color: Colors.white, size: 36),
                      ),
                      const SizedBox(height: 12),
                      Text('Quét thành công!',
                          style:
                              AppTextStyles.h2.copyWith(color: Colors.white)),
                      const SizedBox(height: 4),
                      Text('+${product.pointsOnScan} điểm',
                          style: AppTextStyles.h3
                              .copyWith(color: AppColors.brandGold)),
                      const SizedBox(height: 24),
                      // Product card
                      GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: product.image,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(product.name,
                                style: AppTextStyles.h3
                                    .copyWith(color: Colors.white)),
                            const SizedBox(height: 8),
                            _info('Mã sản phẩm', product.code),
                            _info('Danh mục', product.category),
                            _info('Nhà sản xuất', product.manufacturer),
                            _info('Xuất xứ', product.origin),
                            _info('Bảo hành', product.warranty),
                            const SizedBox(height: 12),
                            Text('Chứng nhận',
                                style: AppTextStyles.labelMd
                                    .copyWith(color: Colors.white70)),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: product.certifications
                                  .map((c) => Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: AppColors.brandGold
                                              .withValues(alpha: 0.15),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(c,
                                            style: const TextStyle(
                                                fontSize: 11,
                                                color: AppColors.brandGold)),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () => context.go('/home'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.brandRed,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(99)),
                          ),
                          child: const Text('Về trang chủ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(label,
                style: const TextStyle(fontSize: 12, color: Colors.white54)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
