import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/mock/mock_data.dart';

class _DesktopDragScroll extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}

class HomeHandbookStrip extends StatelessWidget {
  final List<HandbookNote> notes;
  const HomeHandbookStrip({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ScrollConfiguration(
        behavior: _DesktopDragScroll(),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          physics: const BouncingScrollPhysics(),
          itemCount: notes.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, i) => _HandbookCard(note: notes[i]),
        ),
      ),
    );
  }
}

class _HandbookCard extends StatelessWidget {
  final HandbookNote note;
  const _HandbookCard({required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/handbook'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            width: 224,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card.withValues(alpha: 0.62),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFAEFC2), Color(0xFFE8CC6A)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        LucideIcons.bookOpen,
                        size: 14,
                        color: AppColors.brandNavyDeep,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.mutedForeground,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  note.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  note.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.mutedForeground,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
