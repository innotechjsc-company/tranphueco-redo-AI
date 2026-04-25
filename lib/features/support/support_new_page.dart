import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_gradients.dart';
import '../../shared/widgets/brand_header.dart';

class SupportNewPage extends ConsumerStatefulWidget {
  const SupportNewPage({super.key});
  @override
  ConsumerState<SupportNewPage> createState() => _SupportNewPageState();
}

class _SupportNewPageState extends ConsumerState<SupportNewPage> {
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();
  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppGradients.dark),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Column(children: [
          const BrandHeader(title: 'Tạo yêu cầu hỗ trợ'),
          Expanded(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('TIÊU ĐỀ',
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        TextField(
                            controller: _titleCtrl,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: 'Nhập tiêu đề...',
                                hintStyle:
                                    const TextStyle(color: Colors.white38),
                                filled: true,
                                fillColor: Colors.white10,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none))),
                        const SizedBox(height: 16),
                        const Text('NỘI DUNG',
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        TextField(
                            controller: _contentCtrl,
                            maxLines: 6,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: 'Mô tả chi tiết...',
                                hintStyle:
                                    const TextStyle(color: Colors.white38),
                                filled: true,
                                fillColor: Colors.white10,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none))),
                        const SizedBox(height: 24),
                        SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                                onPressed: () => context.pop(),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.brandRed,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24))),
                                child: const Text('Gửi yêu cầu',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
                      ]))),
        ])),
      ),
    );
  }
}
