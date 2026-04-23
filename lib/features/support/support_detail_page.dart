import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_gradients.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock/mock_providers.dart';
import '../../shared/widgets/brand_header.dart';
import '../../shared/widgets/glass_card.dart';

class SupportDetailPage extends ConsumerWidget {
  const SupportDetailPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticket = ref.watch(supportByIdProvider(id));
    if (ticket == null) return Scaffold(body: Center(child: Text('Không tìm thấy')));

    return Container(
      decoration: const BoxDecoration(gradient: AppGradients.dark),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(child: Column(children: [
          const BrandHeader(title: 'Chi tiết hỗ trợ'),
          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            child: GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(ticket.title, style: AppTextStyles.h3.copyWith(color: Colors.white)),
              const SizedBox(height: 8),
              Text(ticket.createdAt, style: const TextStyle(color: Colors.white38, fontSize: 12)),
              const SizedBox(height: 16),
              Text(ticket.content, style: AppTextStyles.bodyMd.copyWith(color: Colors.white70)),
            ])))),
        ])),
      ),
    );
  }
}
