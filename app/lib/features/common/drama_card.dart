import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/format_utils.dart';

/// 剧集卡片组件
///
/// 用于在列表中展示剧集信息
class DramaCard extends StatelessWidget {
  final String dramaId;
  final String title;
  final String coverUrl;
  final String? genre;
  final String? status;
  final int? episodeCount;
  final int? playCount;
  final bool isNew;
  final bool isExclusive;
  final VoidCallback? onTap;

  const DramaCard({
    super.key,
    required this.dramaId,
    required this.title,
    required this.coverUrl,
    this.genre,
    this.status,
    this.episodeCount,
    this.playCount,
    this.isNew = false,
    this.isExclusive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => context.push('/drama/$dramaId'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 封面
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: coverUrl.isNotEmpty
                        ? Image.network(
                            coverUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.movie,
                              size: 32,
                              color: Colors.grey,
                            ),
                          )
                        : const Icon(
                            Icons.movie,
                            size: 32,
                            color: Colors.grey,
                          ),
                  ),
                ),

                // 标签
                if (isNew || isExclusive)
                  Positioned(
                    top: 4,
                    left: 4,
                    child: Row(
                      children: [
                        if (isNew)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              '新',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (isNew && isExclusive)
                          const SizedBox(width: 4),
                        if (isExclusive)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              gradient: AppColors.vipGradient,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              '独播',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                // 集数
                if (episodeCount != null)
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '共$episodeCount集',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          // 标题
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          // 副信息
          if (playCount != null || genre != null)
            Text(
              [
                if (genre != null) genre,
                if (playCount != null) FormatUtils.formatPlayCount(playCount!),
              ].join(' · '),
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
