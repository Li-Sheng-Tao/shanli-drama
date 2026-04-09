import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/drama.dart';

/// 找片页当前 Tab 索引
final exploreTabIndexProvider = StateProvider<int>((ref) => 0);

/// 搜索关键词
final exploreSearchKeywordProvider = StateProvider<String>((ref) => '');

/// 排行榜子 Tab 索引
final exploreRankingTabIndexProvider = StateProvider<int>((ref) => 0);

/// 日历选中日期索引（0=今天，1=明天，-1=昨天）
final exploreSelectedDateIndexProvider = StateProvider<int>((ref) => 0);

/// 是否正在刷新
final exploreRefreshingProvider = StateProvider<bool>((ref) => false);

/// 推荐剧集列表
final exploreRecommendDramasProvider = Provider<List<Drama>>((ref) {
  return _getMockRecommendDramas();
});

/// 排行榜数据
final exploreRankingDramasProvider = Provider<List<Drama>>((ref) {
  return _getMockRankingDramas();
});

/// 上新剧集数据
final exploreNewDramasProvider = Provider<List<Drama>>((ref) {
  return _getMockNewDramas();
});

/// 日期列表
final exploreDateListProvider = Provider<List<ExploreDateItem>>((ref) {
  return _getMockDateList();
});

/// Explore Notifier
class ExploreNotifier extends StateNotifier<ExploreState> {
  ExploreNotifier() : super(const ExploreState());

  /// 切换 Tab
  void switchTab(int index) {
    state = state.copyWith(currentTabIndex: index);
  }

  /// 切换排行榜子 Tab
  void switchRankingTab(int index) {
    state = state.copyWith(rankingTabIndex: index);
  }

  /// 选择日期
  void selectDate(int index) {
    state = state.copyWith(selectedDateIndex: index);
  }

  /// 更新搜索关键词
  void updateSearchKeyword(String keyword) {
    state = state.copyWith(searchKeyword: keyword);
  }

  /// 刷新
  Future<void> refresh() async {
    state = state.copyWith(isRefreshing: true);
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 800));
    state = state.copyWith(isRefreshing: false);
  }
}

/// Explore 状态
class ExploreState {
  final int currentTabIndex;
  final int rankingTabIndex;
  final int selectedDateIndex;
  final String searchKeyword;
  final bool isRefreshing;

  const ExploreState({
    this.currentTabIndex = 0,
    this.rankingTabIndex = 0,
    this.selectedDateIndex = 0,
    this.searchKeyword = '',
    this.isRefreshing = false,
  });

  ExploreState copyWith({
    int? currentTabIndex,
    int? rankingTabIndex,
    int? selectedDateIndex,
    String? searchKeyword,
    bool? isRefreshing,
  }) {
    return ExploreState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      rankingTabIndex: rankingTabIndex ?? this.rankingTabIndex,
      selectedDateIndex: selectedDateIndex ?? this.selectedDateIndex,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }
}

/// Explore Notifier Provider
final exploreNotifierProvider = StateNotifierProvider<ExploreNotifier, ExploreState>((ref) {
  return ExploreNotifier();
});

/// 日期项
class ExploreDateItem {
  final String label;
  final String date;
  final String weekDay;
  final bool isToday;
  final bool hasUpdate;

  const ExploreDateItem({
    required this.label,
    required this.date,
    required this.weekDay,
    required this.isToday,
    required this.hasUpdate,
  });
}

/// Mock 推荐剧集数据（至少10个）
List<Drama> _getMockRecommendDramas() {
  return [
    Drama(
      id: 'rec_001',
      title: '总裁的替身新娘',
      coverUrl: 'https://via.placeholder.com/300x400/FF6B35/FFFFFF?text=总裁的替身新娘',
      description: '豪门总裁与替身新娘的虐恋情深',
      genre: '甜宠',
      tags: ['豪门', '替身', '虐恋'],
      episodeCount: 80,
      status: 'ongoing',
      isExclusive: true,
      isNew: true,
      playCount: 1258000,
      collectCount: 85600,
    ),
    Drama(
      id: 'rec_002',
      title: '重生之复仇女王',
      coverUrl: 'https://via.placeholder.com/300x400/E91E63/FFFFFF?text=重生之复仇女王',
      description: '前世被渣男背叛，重生归来复仇',
      genre: '逆袭',
      tags: ['重生', '复仇', '爽文'],
      episodeCount: 100,
      status: 'ongoing',
      isExclusive: false,
      isNew: true,
      playCount: 2345000,
      collectCount: 156000,
    ),
    Drama(
      id: 'rec_003',
      title: '穿越时空爱上你',
      coverUrl: 'https://via.placeholder.com/300x400/9C27B0/FFFFFF?text=穿越时空爱上你',
      description: '现代女孩穿越古代与王爷相恋',
      genre: '穿越',
      tags: ['穿越', '古言', '甜宠'],
      episodeCount: 60,
      status: 'completed',
      isExclusive: false,
      isNew: false,
      playCount: 890000,
      collectCount: 67800,
    ),
    Drama(
      id: 'rec_004',
      title: '神秘庄园的秘密',
      coverUrl: 'https://via.placeholder.com/300x400/607D8B/FFFFFF?text=神秘庄园的秘密',
      description: '继承神秘庄园后发现惊天秘密',
      genre: '悬疑',
      tags: ['悬疑', '推理', '惊悚'],
      episodeCount: 40,
      status: 'completed',
      isExclusive: true,
      isNew: false,
      playCount: 567000,
      collectCount: 45600,
    ),
    Drama(
      id: 'rec_005',
      title: '霸道王爷俏王妃',
      coverUrl: 'https://via.placeholder.com/300x400/3F51B5/FFFFFF?text=霸道王爷俏王妃',
      description: '穿越古代成为王爷的王妃',
      genre: '穿越',
      tags: ['穿越', '古言', '甜宠'],
      episodeCount: 90,
      status: 'ongoing',
      isExclusive: false,
      isNew: true,
      playCount: 1876000,
      collectCount: 123000,
    ),
    Drama(
      id: 'rec_006',
      title: '闪婚老公是千亿大佬',
      coverUrl: 'https://via.placeholder.com/300x400/FF5722/FFFFFF?text=闪婚老公是千亿大佬',
      description: '意外闪婚，老公竟是隐藏大佬',
      genre: '甜宠',
      tags: ['闪婚', '豪门', '甜宠'],
      episodeCount: 70,
      status: 'ongoing',
      isExclusive: true,
      isNew: true,
      playCount: 3456000,
      collectCount: 234000,
    ),
    Drama(
      id: 'rec_007',
      title: '回到2005当首富',
      coverUrl: 'https://via.placeholder.com/300x400/4CAF50/FFFFFF?text=回到2005当首富',
      description: '重生回到2005年，开启商业帝国',
      genre: '逆袭',
      tags: ['重生', '商战', '逆袭'],
      episodeCount: 120,
      status: 'ongoing',
      isExclusive: false,
      isNew: false,
      playCount: 1567000,
      collectCount: 98700,
    ),
    Drama(
      id: 'rec_008',
      title: '被退婚后我成了首富',
      coverUrl: 'https://via.placeholder.com/300x400/00BCD4/FFFFFF?text=被退婚后我成了首富',
      description: '被退婚后意外获得超能力',
      genre: '逆袭',
      tags: ['退婚', '逆袭', '爽文'],
      episodeCount: 85,
      status: 'completed',
      isExclusive: false,
      isNew: false,
      playCount: 987000,
      collectCount: 76500,
    ),
    Drama(
      id: 'rec_009',
      title: '医妃惊天下',
      coverUrl: 'https://via.placeholder.com/300x400/673AB7/FFFFFF?text=医妃惊天下',
      description: '现代女医穿越古代成为王妃',
      genre: '穿越',
      tags: ['穿越', '医术', '古言'],
      episodeCount: 95,
      status: 'ongoing',
      isExclusive: true,
      isNew: true,
      playCount: 2134000,
      collectCount: 167000,
    ),
    Drama(
      id: 'rec_010',
      title: '暗夜追踪者',
      coverUrl: 'https://via.placeholder.com/300x400/455A64/FFFFFF?text=暗夜追踪者',
      description: '连环失踪案背后的惊天阴谋',
      genre: '悬疑',
      tags: ['悬疑', '刑侦', '推理'],
      episodeCount: 50,
      status: 'completed',
      isExclusive: false,
      isNew: false,
      playCount: 789000,
      collectCount: 54300,
    ),
    Drama(
      id: 'rec_011',
      title: '千金归来',
      coverUrl: 'https://via.placeholder.com/300x400/AD1457/FFFFFF?text=千金归来',
      description: '真假千金的故事，谁是真正的继承人',
      genre: '逆袭',
      tags: ['真假千金', '豪门', '逆袭'],
      episodeCount: 75,
      status: 'ongoing',
      isExclusive: false,
      isNew: true,
      playCount: 1654000,
      collectCount: 112000,
    ),
    Drama(
      id: 'rec_012',
      title: '龙王赘婿',
      coverUrl: 'https://via.placeholder.com/300x400/1B5E20/FFFFFF?text=龙王赘婿',
      description: '隐世龙王入赘豪门，扮猪吃虎',
      genre: '逆袭',
      tags: ['赘婿', '龙王', '爽文'],
      episodeCount: 110,
      status: 'ongoing',
      isExclusive: true,
      isNew: false,
      playCount: 2890000,
      collectCount: 198000,
    ),
  ];
}

/// Mock 排行榜数据
List<Drama> _getMockRankingDramas() {
  final dramas = _getMockRecommendDramas();
  // 按播放量排序
  final sorted = List<Drama>.from(dramas)
    ..sort((a, b) => b.playCount.compareTo(a.playCount));
  return sorted;
}

/// Mock 上新剧集数据
List<Drama> _getMockNewDramas() {
  return _getMockRecommendDramas()
      .where((d) => d.isNew)
      .toList();
}

/// Mock 日期列表
List<ExploreDateItem> _getMockDateList() {
  final now = DateTime.now();
  final weekDays = ['日', '一', '二', '三', '四', '五', '六'];
  return List.generate(7, (index) {
    final date = now.add(Duration(days: index));
    return ExploreDateItem(
      label: index == 0 ? '今天' : index == 1 ? '明天' : '${date.month}/${date.day}',
      date: '${date.month}月${date.day}日',
      weekDay: '周${weekDays[date.weekday % 7]}',
      isToday: index == 0,
      hasUpdate: index < 5, // 前5天有更新
    );
  });
}
