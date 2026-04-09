import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// 集数列表组件
///
/// 用于展示剧集的所有集数
class EpisodeList extends StatelessWidget {
  final int currentEpisode;
  final int totalEpisodes;
  final bool Function(int episodeNumber)? isFree;
  final int Function(int episodeNumber)? coinCost;
  final ValueChanged<int>? onEpisodeTap;

  const EpisodeList({
    super.key,
    required this.currentEpisode,
    required this.totalEpisodes,
    this.isFree,
    this.coinCost,
    this.onEpisodeTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        childAspectRatio: 1.5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: totalEpisodes,
      itemBuilder: (context, index) {
        final episodeNumber = index + 1;
        final isCurrent = episodeNumber == currentEpisode;
        final free = isFree?.call(episodeNumber) ?? true;
        final cost = coinCost?.call(episodeNumber) ?? 0;

        return GestureDetector(
          onTap: () => onEpisodeTap?.call(episodeNumber),
          child: Container(
            decoration: BoxDecoration(
              color: isCurrent
                  ? AppColors.primary
                  : free
                      ? const Color(0xFFF5F5F5)
                      : const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(8),
              border: isCurrent
                  ? null
                  : Border.all(
                      color: free
                          ? Colors.transparent
                          : AppColors.secondary.withValues(alpha: 0.3),
                    ),
            ),
            alignment: Alignment.center,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Text(
                  '$episodeNumber',
                  style: TextStyle(
                    fontSize: 14,
                    color: isCurrent
                        ? Colors.white
                        : free
                            ? AppColors.textPrimary
                            : AppColors.secondary,
                    fontWeight:
                        isCurrent ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                if (!free && cost > 0)
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '$cost',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
