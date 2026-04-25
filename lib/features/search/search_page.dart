import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_gradients.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock/mock_providers.dart';
import '../../shared/widgets/glass_card.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});
  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final rewards = ref.watch(rewardsProvider);
    final news = ref.watch(newsProvider);
    final filtered = _query.isEmpty
        ? []
        : [
            ...rewards
                .where(
                    (r) => r.name.toLowerCase().contains(_query.toLowerCase()))
                .map((r) =>
                    _SearchResult(r.name, '/shop/${r.id}', 'Phần thưởng')),
            ...news
                .where(
                    (n) => n.title.toLowerCase().contains(_query.toLowerCase()))
                .map((n) => _SearchResult(n.title, '/news/${n.id}', 'Tin tức')),
          ];

    return Container(
      decoration: const BoxDecoration(gradient: AppGradients.dark),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Column(children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(children: [
                IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => context.pop()),
                Expanded(
                    child: TextField(
                        autofocus: true,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (v) => setState(() => _query = v),
                        decoration: InputDecoration(
                            hintText: 'Tìm kiếm...',
                            hintStyle: const TextStyle(color: Colors.white38),
                            filled: true,
                            fillColor: Colors.white10,
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.white38),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 12)))),
              ])),
          Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Text(
                          _query.isEmpty
                              ? 'Nhập từ khóa để tìm kiếm'
                              : 'Không tìm thấy kết quả',
                          style: AppTextStyles.body
                              .copyWith(color: Colors.white54)))
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                      itemCount: filtered.length,
                      itemBuilder: (_, i) {
                        final r = filtered[i];
                        return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: GlassCard(
                                onTap: () => context.push(r.route),
                                child: Row(children: [
                                  Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        Text(r.title,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14)),
                                        Text(r.type,
                                            style: const TextStyle(
                                                color: Colors.white38,
                                                fontSize: 11)),
                                      ])),
                                  const Icon(Icons.chevron_right,
                                      color: Colors.white30, size: 18),
                                ])));
                      })),
        ])),
      ),
    );
  }
}

class _SearchResult {
  final String title, route, type;
  _SearchResult(this.title, this.route, this.type);
}
