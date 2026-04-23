import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_gradients.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock/mock_providers.dart';
import '../../shared/widgets/brand_header.dart';
import '../../shared/widgets/glass_card.dart';

class BranchesPage extends ConsumerWidget {
  const BranchesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branches = ref.watch(branchesProvider);
    return Container(
      decoration: const BoxDecoration(gradient: AppGradients.dark),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(child: Column(children: [
          const BrandHeader(title: 'Hệ thống chi nhánh'),
          Expanded(child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            itemCount: branches.length,
            itemBuilder: (_, i) {
              final b = branches[i];
              return Padding(padding: const EdgeInsets.only(bottom: 10),
                child: GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(b.name, style: AppTextStyles.h4.copyWith(color: Colors.white)),
                  const SizedBox(height: 8),
                  Row(children: [const Icon(LucideIcons.mapPin, size: 14, color: Colors.white54), const SizedBox(width: 6),
                    Expanded(child: Text(b.address, style: const TextStyle(color: Colors.white54, fontSize: 12)))]),
                  const SizedBox(height: 4),
                  Row(children: [const Icon(LucideIcons.phone, size: 14, color: Colors.white54), const SizedBox(width: 6),
                    Text(b.phone, style: const TextStyle(color: Colors.white54, fontSize: 12))]),
                  const SizedBox(height: 4),
                  Row(children: [const Icon(LucideIcons.clock, size: 14, color: Colors.white54), const SizedBox(width: 6),
                    Text(b.hours, style: const TextStyle(color: Colors.white54, fontSize: 12))]),
                  const SizedBox(height: 6),
                  Text('${b.distanceKm} km', style: const TextStyle(color: AppColors.brandGold, fontSize: 12, fontWeight: FontWeight.w600)),
                ])));
            },
          )),
        ])),
      ),
    );
  }
}
