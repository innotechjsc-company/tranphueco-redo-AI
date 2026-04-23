import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_gradients.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock/mock_providers.dart';
import '../../shared/widgets/brand_header.dart';
import '../../shared/widgets/glass_card.dart';
import '../../shared/utils/number_format.dart';

class HandbookPage extends ConsumerWidget {
  const HandbookPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(handbookProvider);
    return Container(
      decoration: const BoxDecoration(gradient: AppGradients.dark),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push('/handbook/new'),
          backgroundColor: AppColors.brandRed,
          child: const Icon(Icons.add, color: Colors.white)),
        body: SafeArea(child: Column(children: [
          const BrandHeader(title: 'Sổ tay kỹ thuật'),
          Expanded(child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            itemCount: notes.length,
            itemBuilder: (_, i) {
              final n = notes[i];
              return Padding(padding: const EdgeInsets.only(bottom: 10),
                child: GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(n.title, style: AppTextStyles.h4.copyWith(color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(n.content, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white54, fontSize: 13)),
                  const SizedBox(height: 6),
                  Text(formatVnDate(n.createdAt), style: const TextStyle(color: Colors.white38, fontSize: 11)),
                ])));
            },
          )),
        ])),
      ),
    );
  }
}
