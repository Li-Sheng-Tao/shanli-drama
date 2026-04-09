import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import 'feed_provider.dart';

class FeedPage extends ConsumerStatefulWidget {
  const FeedPage({super.key});

  @override
  ConsumerState<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  late PageController _pageController;
  int _lastTapTime = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// 格式化数字
  String _formatCount(int count) {
    if (count >= 10000) {
      return '${(count / 10000).toStringAsFixed(1)}w';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  /// 处理双击点赞
  void _handleDoubleTap(WidgetRef ref) {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastTapTime < 300) {
      // 双击点赞
      final notifier = ref.read(feedNotifierProvider.notifier);
      if (!ref.read(feedNotifierProvider).isLiked) {
        notifier.toggleLike();
      }
    } else {
      // 单击暂停/播放
      final notifier = ref.read(feedNotifierProvider.notifier);
      notifier.togglePlayPause();
    }
    _lastTapTime = now;
  }

  @override
  Widget build(BuildContext context) {
    final dramas = ref.watch(feedDramasProvider);
    final feedState = ref.watch(feedNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Stack(
          children: [
            // PageView 上下滑动切换
            PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: dramas.length,
              onPageChanged: (index) {
                ref.read(feedNotifierProvider.notifier).updateDramaIndex(index);
              },
              itemBuilder: (context, index) {
                return _buildVideoPage(context, ref, index, dramas[index], feedState);
              },
            ),

            // 顶部 Tab 栏
            _buildTopTabBar(),

            // 收藏/付费提示弹窗
            if (feedState.showCoinHint) _buildCoinHintDialog(ref),
          ],
        ),
      ),
    );
  }

  /// 构建视频页面
  Widget _buildVideoPage(
    BuildContext context,
    WidgetRef ref,
    int index,
    dynamic drama,
    FeedState feedState,
  ) {
    final isCurrentPage = index == feedState.dramaIndex;
    final episodes = ref.watch(feedEpisodesProvider);
    final currentEpisode = ref.watch(feedCurrentEpisodeProvider);
    final episodeIndex = feedState.episodeIndex;

    return GestureDetector(
      onTap: () => _handleDoubleTap(ref),
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            // 视频播放区域（黑色背景占位）
            Positioned.fill(
              child: Container(
                color: AppColors.backgroundDark,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.play_circle_outline,
                        size: 80.r,
                        color: Colors.white.withValues(alpha: 0.15),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        drama.title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 暂停图标
            if (isCurrentPage && feedState.showPauseIcon)
              Center(
                child: AnimatedOpacity(
                  opacity: feedState.showPauseIcon ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    feedState.isPlaying
                        ? Icons.play_arrow
                        : Icons.pause,
                    size: 80.r,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ),

            // 双击点赞动画
            if (isCurrentPage && feedState.isLiked)
              Center(
                child: AnimatedScale(
                  scale: feedState.isLiked ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.favorite,
                    size: 100.r,
                    color: AppColors.primary.withValues(alpha: 0.8),
                  ),
                ),
              ),

            // 右侧互动栏
            if (isCurrentPage) _buildInteractionBar(ref, drama, feedState),

            // 底部信息浮层
            if (isCurrentPage)
              _buildBottomInfo(
                ref,
                drama,
                feedState,
                episodes,
                currentEpisode,
                episodeIndex,
              ),
          ],
        ),
      ),
    );
  }

  /// 顶部 Tab 栏
  Widget _buildTopTabBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTopTab('关注', false),
              SizedBox(width: 24.w),
              _buildTopTab('推荐', true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopTab(String text, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.6),
          ),
        ),
        SizedBox(height: 4.h),
        Container(
          width: 24.w,
          height: 3.h,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
      ],
    );
  }

  /// 右侧互动栏
  Widget _buildInteractionBar(WidgetRef ref, dynamic drama, FeedState feedState) {
    return Positioned(
      right: 12.w,
      bottom: 200.h,
      child: Column(
        children: [
          // 观看时长提示气泡
          if (feedState.showCoinHint)
            GestureDetector(
              onTap: () => ref.read(feedNotifierProvider.notifier).claimCoin(),
              child: Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '已看${feedState.watchMinutes}分钟\n领金币',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.white,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

          // 发布者头像
          _buildAvatar(drama),

          SizedBox(height: 20.h),

          // 点赞按钮
          _buildActionButton(
            icon: feedState.isLiked ? Icons.favorite : Icons.favorite_border,
            color: feedState.isLiked ? AppColors.primary : Colors.white,
            count: _formatCount(drama.collectCount),
            onTap: () => ref.read(feedNotifierProvider.notifier).toggleLike(),
          ),

          SizedBox(height: 20.h),

          // 评论按钮
          _buildActionButton(
            icon: Icons.comment_outlined,
            color: Colors.white,
            count: _formatCount(drama.playCount),
            onTap: () {
              // TODO: 打开评论面板
            },
          ),

          SizedBox(height: 20.h),

          // 分享按钮
          _buildActionButton(
            icon: Icons.share_outlined,
            color: Colors.white,
            count: '',
            onTap: () {
              // TODO: 分享功能
            },
          ),

          SizedBox(height: 20.h),

          // 收藏按钮
          _buildActionButton(
            icon: feedState.isFavorited ? Icons.star : Icons.star_border,
            color: feedState.isFavorited ? AppColors.primary : Colors.white,
            count: '',
            onTap: () => ref.read(feedNotifierProvider.notifier).toggleFavorite(),
          ),
        ],
      ),
    );
  }

  /// 发布者头像
  Widget _buildAvatar(dynamic drama) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 48.r,
          height: 48.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 2.w),
            color: Colors.grey.shade800,
          ),
          child: Icon(
            Icons.person,
            size: 24.r,
            color: Colors.white54,
          ),
        ),
        // 关注按钮（头像下方）
        Positioned(
          bottom: -8.r,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 20.r,
              height: 20.r,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                size: 14.r,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 互动按钮
  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required String count,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 30.r, color: color),
          if (count.isNotEmpty) ...[
            SizedBox(height: 4.h),
            Text(
              count,
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 底部信息浮层
  Widget _buildBottomInfo(
    WidgetRef ref,
    dynamic drama,
    FeedState feedState,
    List episodes,
    dynamic currentEpisode,
    int episodeIndex,
  ) {
    return Positioned(
      left: 0,
      right: 60.w,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withValues(alpha: 0.3),
              Colors.black.withValues(alpha: 0.7),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 剧名
            GestureDetector(
              onTap: () => context.push('/drama/${drama.id}'),
              child: Text(
                drama.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            SizedBox(height: 6.h),

            // 热度标签 + 分类标签
            Row(
              children: [
                _buildInfoTag('🔥 ${_formatCount(drama.playCount)}', AppColors.primary),
                SizedBox(width: 8.w),
                _buildInfoTag(drama.genre, Colors.white.withValues(alpha: 0.7)),
                if (drama.isExclusive) ...[
                  SizedBox(width: 8.w),
                  _buildInfoTag('独播', AppColors.secondary),
                ],
              ],
            ),

            SizedBox(height: 6.h),

            // 集数信息
            Text(
              '第${episodeIndex + 1}集 | 共${drama.episodeCount}集',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 13.sp,
              ),
            ),

            SizedBox(height: 6.h),

            // 单集介绍文字
            _buildDescription(drama.description),

            SizedBox(height: 10.h),

            // 集数横向滚动选择器
            _buildEpisodeSelector(ref, episodes, episodeIndex),
          ],
        ),
      ),
    );
  }

  /// 信息标签
  Widget _buildInfoTag(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.sp,
          color: color,
        ),
      ),
    );
  }

  /// 剧集介绍（展开/收起）
  Widget _buildDescription(String description) {
    return Consumer(
      builder: (context, ref, child) {
        final isExpanded = ref.watch(_descriptionExpandedProvider);
        return GestureDetector(
          onTap: () {
            ref.read(_descriptionExpandedProvider.notifier).state = !isExpanded;
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 12.sp,
                  height: 1.4,
                ),
                maxLines: isExpanded ? null : 2,
                overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
              if (!isExpanded && description.length > 40)
                Text(
                  '展开查看更多',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 11.sp,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  /// 集数横向滚动选择器
  Widget _buildEpisodeSelector(WidgetRef ref, List episodes, int episodeIndex) {
    return SizedBox(
      height: 32.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: episodes.length > 20 ? 20 : episodes.length,
        itemBuilder: (context, index) {
          final isSelected = index == episodeIndex;
          return GestureDetector(
            onTap: () {
              ref.read(feedNotifierProvider.notifier).jumpToEpisode(index);
            },
            child: Container(
              margin: EdgeInsets.only(right: 6.w),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16.r),
              ),
              alignment: Alignment.center,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.7),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 金币提示弹窗
  Widget _buildCoinHintDialog(WidgetRef ref) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.6),
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 40.w),
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  size: 48.r,
                  color: AppColors.primary,
                ),
                SizedBox(height: 16.h),
                Text(
                  '精彩继续',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '收藏本剧，不错过后续更新',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          ref.read(feedNotifierProvider.notifier).claimCoin();
                        },
                        child: Container(
                          height: 44.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(22.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '稍后再说',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          ref.read(feedNotifierProvider.notifier).toggleFavorite();
                          ref.read(feedNotifierProvider.notifier).claimCoin();
                        },
                        child: Container(
                          height: 44.h,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(22.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '收藏追剧',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 描述展开状态
final _descriptionExpandedProvider = StateProvider<bool>((ref) => false);
