import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../models/drama.dart';
import 'explore_provider.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const _tabs = ['推荐', '排行榜', '创作者', '上新'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        ref.read(exploreNotifierProvider.notifier).switchTab(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // 顶部搜索栏
            _buildSearchBar(),

            // Tab 切换栏
            _buildTabBar(),

            // Tab 内容
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildRecommendTab(),
                  _buildRankingTab(),
                  _buildCreatorTab(),
                  _buildNewTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 顶部搜索栏
  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: GestureDetector(
        onTap: () => context.push('/search'),
        child: Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Icon(
                Icons.search,
                size: 20.r,
                color: AppColors.textHint,
              ),
              SizedBox(width: 8.w),
              Text(
                '搜索剧名、演员、导演...',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Tab 切换栏
  Widget _buildTabBar() {
    return Container(
      color: AppColors.backgroundLight,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 3,
        labelStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
      ),
    );
  }

  /// 推荐Tab - 双排瀑布流
  Widget _buildRecommendTab() {
    final dramas = ref.watch(exploreRecommendDramasProvider);
    final isRefreshing = ref.watch(exploreNotifierProvider.select((s) => s.isRefreshing));

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => ref.read(exploreNotifierProvider.notifier).refresh(),
      child: isRefreshing
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : _buildWaterfallGrid(dramas),
    );
  }

  /// 双排瀑布流网格
  Widget _buildWaterfallGrid(List<Drama> dramas) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.62,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
      ),
      itemCount: dramas.length,
      itemBuilder: (context, index) {
        return _buildDramaCard(dramas[index]);
      },
    );
  }

  /// 剧集卡片
  Widget _buildDramaCard(Drama drama) {
    return GestureDetector(
      onTap: () => context.push('/drama/${drama.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 封面图 (3:4 比例)
            Expanded(
              child: Stack(
                children: [
                  // 封面占位
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8E8E8),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12.r),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.movie,
                        size: 36.r,
                        color: AppColors.textHint,
                      ),
                    ),
                  ),

                  // 左上角"推荐"水印
                  Positioned(
                    top: 6.w,
                    left: 6.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        '推荐',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // 右下角状态标签
                  Positioned(
                    bottom: 6.w,
                    right: 6.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: drama.status == 'ongoing'
                            ? AppColors.primary
                            : AppColors.success,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        drama.status == 'ongoing' ? '连载' : '完结',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // 独播标签
                  if (drama.isExclusive)
                    Positioned(
                      top: 6.w,
                      right: 6.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          '独播',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // 剧名和标签
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    drama.title,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          drama.genre,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${drama.episodeCount}集',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 排行榜Tab
  Widget _buildRankingTab() {
    final rankingTabIndex = ref.watch(exploreNotifierProvider.select((s) => s.rankingTabIndex));
    final dramas = ref.watch(exploreRankingDramasProvider);

    return Column(
      children: [
        // 子Tab
        _buildRankingSubTabs(rankingTabIndex),

        // 排行榜列表
        Expanded(
          child: _buildRankingList(dramas),
        ),
      ],
    );
  }

  /// 排行榜子Tab
  Widget _buildRankingSubTabs(int currentIndex) {
    const subTabs = ['热播榜', '热搜榜', '收藏榜', '预约榜'];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: List.generate(subTabs.length, (index) {
          final isSelected = index == currentIndex;
          return GestureDetector(
            onTap: () {
              ref.read(exploreNotifierProvider.notifier).switchRankingTab(index);
            },
            child: Container(
              margin: EdgeInsets.only(right: 12.w),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                subTabs[index],
                style: TextStyle(
                  fontSize: 13.sp,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  /// 排行榜列表
  Widget _buildRankingList(List<Drama> dramas) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      itemCount: dramas.length,
      itemBuilder: (context, index) {
        return _buildRankingItem(dramas, index);
      },
    );
  }

  /// 排行榜列表项
  Widget _buildRankingItem(List<Drama> dramas, int index) {
    final drama = dramas[index];
    final isTopThree = index < 3;
    final rankColors = [AppColors.primary, AppColors.secondary, const Color(0xFFCD7F32)];

    // 计算与前一名的差距
    String gapText = '';
    if (index > 0) {
      final gap = dramas[index - 1].playCount - drama.playCount;
      gapText = '距上一名 ${_formatCount(gap)}';
    }

    return GestureDetector(
      onTap: () => context.push('/drama/${drama.id}'),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // 排名数字
            SizedBox(
              width: 36.w,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: isTopThree ? 22.sp : 16.sp,
                  fontWeight: isTopThree ? FontWeight.bold : FontWeight.normal,
                  color: isTopThree ? rankColors[index] : AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(width: 10.w),

            // 封面缩略图
            Container(
              width: 56.r,
              height: 72.r,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E8E8),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Icon(
                  Icons.movie,
                  size: 20.r,
                  color: AppColors.textHint,
                ),
              ),
            ),

            SizedBox(width: 12.w),

            // 剧名 + 数据
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    drama.title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${drama.genre} | ${drama.episodeCount}集',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.play_circle_outline,
                        size: 14.r,
                        color: AppColors.textHint,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _formatCount(drama.playCount),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textHint,
                        ),
                      ),
                      if (gapText.isNotEmpty) ...[
                        SizedBox(width: 12.w),
                        Text(
                          gapText,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.primary.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 创作者Tab
  Widget _buildCreatorTab() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.people_outline,
            size: 64.r,
            color: AppColors.textHint,
          ),
          SizedBox(height: 16.h),
          Text(
            '创作者中心',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '敬请期待',
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }

  /// 上新Tab
  Widget _buildNewTab() {
    final dateList = ref.watch(exploreDateListProvider);
    final selectedDateIndex = ref.watch(exploreNotifierProvider.select((s) => s.selectedDateIndex));
    final newDramas = ref.watch(exploreNewDramasProvider);

    return Column(
      children: [
        // 日历条
        _buildCalendarBar(dateList, selectedDateIndex),

        // 当日更新列表
        Expanded(
          child: newDramas.isEmpty
              ? Center(
                  child: Text(
                    '暂无更新',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textHint,
                    ),
                  ),
                )
              : _buildNewDramasGrid(newDramas),
        ),
      ],
    );
  }

  /// 日历条
  Widget _buildCalendarBar(List<dynamic> dateList, int selectedIndex) {
    return Container(
      height: 72.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dateList.length,
        itemBuilder: (context, index) {
          final date = dateList[index];
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () {
              ref.read(exploreNotifierProvider.notifier).selectDate(index);
            },
            child: Container(
              width: 52.w,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date.label,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    date.weekDay,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  // 橙色圆点指示有更新
                  Container(
                    width: 6.r,
                    height: 6.r,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white
                          : (date.hasUpdate ? AppColors.primary : Colors.transparent),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// 上新剧集双排网格
  Widget _buildNewDramasGrid(List<Drama> dramas) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.62,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
      ),
      itemCount: dramas.length,
      itemBuilder: (context, index) {
        return _buildNewDramaCard(dramas[index]);
      },
    );
  }

  /// 上新剧集卡片
  Widget _buildNewDramaCard(Drama drama) {
    return GestureDetector(
      onTap: () => context.push('/drama/${drama.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 封面
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8E8E8),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12.r),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.movie,
                        size: 36.r,
                        color: AppColors.textHint,
                      ),
                    ),
                  ),
                  // 更新标签
                  Positioned(
                    top: 6.w,
                    left: 6.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        '更新',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 信息
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    drama.title,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      _buildPillTag(drama.genre),
                      SizedBox(width: 6.w),
                      _buildPillTag(drama.tags.isNotEmpty ? drama.tags.first : ''),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 胶囊标签
  Widget _buildPillTag(String text) {
    if (text.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.sp,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
