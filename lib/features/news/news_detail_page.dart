import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_gradients.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock/mock_providers.dart';
import '../../shared/widgets/brand_header.dart';
import '../../shared/utils/number_format.dart';

class NewsDetailPage extends ConsumerWidget {
  const NewsDetailPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(newsByIdProvider(id));
    if (item == null) {
      return Scaffold(body: Center(child: Text('Không tìm thấy bài viết')));
    }

    return Container(
      decoration: const BoxDecoration(gradient: AppGradients.dark),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              const BrandHeader(title: 'Chi tiết tin tức'),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(item.image, height: 200, width: double.infinity, fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: AppColors.brandRed.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
                        child: Text(item.category, style: const TextStyle(fontSize: 11, color: AppColors.brandRed, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 12),
                      Text(item.title, style: AppTextStyles.h2.copyWith(color: Colors.white)),
                      const SizedBox(height: 8),
                      Text(formatVnDate(item.date), style: const TextStyle(color: Colors.white38, fontSize: 12)),
                      const SizedBox(height: 20),
                      Text(item.body, style: AppTextStyles.bodyMd.copyWith(color: Colors.white70, height: 1.8)),
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
}
