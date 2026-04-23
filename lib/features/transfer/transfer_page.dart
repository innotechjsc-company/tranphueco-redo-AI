import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_gradients.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock/mock_providers.dart';
import '../../shared/widgets/brand_header.dart';
import '../../shared/utils/number_format.dart';

class TransferPage extends ConsumerStatefulWidget {
  const TransferPage({super.key});
  @override
  ConsumerState<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends ConsumerState<TransferPage> {
  final _phoneCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  @override
  void dispose() { _phoneCtrl.dispose(); _amountCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    return Container(
      decoration: const BoxDecoration(gradient: AppGradients.dark),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(child: Column(children: [
          const BrandHeader(title: 'Chuyển điểm'),
          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(child: Column(children: [
                Text('Số dư hiện tại', style: AppTextStyles.bodySm.copyWith(color: Colors.white54)),
                const SizedBox(height: 4),
                Text('${formatVnNumber(user.points)} điểm', style: AppTextStyles.h2.copyWith(color: AppColors.brandGold)),
              ])),
              const SizedBox(height: 32),
              const Text('SỐ ĐIỆN THOẠI NGƯỜI NHẬN', style: TextStyle(fontSize: 11, color: Colors.white70, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              TextField(controller: _phoneCtrl, keyboardType: TextInputType.phone, style: const TextStyle(color: Colors.white),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(hintText: '0901 234 567', hintStyle: TextStyle(color: Colors.white38),
                  filled: true, fillColor: Colors.white10, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
              const SizedBox(height: 16),
              const Text('SỐ ĐIỂM CHUYỂN', style: TextStyle(fontSize: 11, color: Colors.white70, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              TextField(controller: _amountCtrl, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(hintText: '100', hintStyle: TextStyle(color: Colors.white38),
                  filled: true, fillColor: Colors.white10, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
              const SizedBox(height: 32),
              SizedBox(width: double.infinity, height: 48, child: ElevatedButton(
                onPressed: () => context.pop(),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.brandRed, foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
                child: const Text('Chuyển điểm', style: TextStyle(fontWeight: FontWeight.bold)))),
            ]))),
        ])),
      ),
    );
  }
}
