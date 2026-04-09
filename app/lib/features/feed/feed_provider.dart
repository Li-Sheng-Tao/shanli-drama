import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/drama.dart';
import '../../models/episode.dart';

/// Feed 当前播放索引
final feedCurrentIndexProvider = StateProvider<int>((ref) => 0);

/// Feed 当前剧集ID
final feedCurrentDramaIdProvider = StateProvider<String>((ref) => '');

/// Feed 当前集数ID
final feedCurrentEpisodeIdProvider = StateProvider<String>((ref) => '');

/// Feed 播放状态
final feedPlayingProvider = StateProvider<bool>((ref) => true);

/// Feed 点赞状态
final feedLikedProvider = StateProvider<bool>((ref) => false);

/// Feed 收藏状态
final feedFavoritedProvider = StateProvider<bool>((ref) => false);

/// Feed 当前集数索引
final feedEpisodeIndexProvider = StateProvider<int>((ref) => 0);

/// Feed 是否显示暂停图标
final feedShowPauseIconProvider = StateProvider<bool>((ref) => false);

/// Feed 观看时长（分钟）
final feedWatchMinutesProvider = StateProvider<int>((ref) => 0);

/// Feed 是否显示金币提示
final feedShowCoinHintProvider = StateProvider<bool>((ref) => false);

/// Feed 剧集数据
final feedDramasProvider = Provider<List<Drama>>((ref) {
  return _getMockDramas();
});

/// Feed 当前剧集
final feedCurrentDramaProvider = Provider<Drama?>((ref) {
  final dramas = ref.watch(feedDramasProvider);
  final currentIndex = ref.watch(feedCurrentIndexProvider);
  if (currentIndex >= 0 && currentIndex < dramas.length) {
    return dramas[currentIndex];
  }
  return null;
});

/// Feed 当前剧集的集数列表
final feedEpisodesProvider = Provider<List<Episode>>((ref) {
  final drama = ref.watch(feedCurrentDramaProvider);
  if (drama == null) return [];
  return _getMockEpisodes(drama.id);
});

/// Feed 当前集数
final feedCurrentEpisodeProvider = Provider<Episode?>((ref) {
  final episodes = ref.watch(feedEpisodesProvider);
  final episodeIndex = ref.watch(feedEpisodeIndexProvider);
  if (episodeIndex >= 0 && episodeIndex < episodes.length) {
    return episodes[episodeIndex];
  }
  return null;
});

/// Feed 点赞数
final feedLikeCountProvider = Provider<int>((ref) {
  final drama = ref.watch(feedCurrentDramaProvider);
  return drama?.collectCount ?? 0;
});

/// Feed 评论数
final feedCommentCountProvider = Provider<int>((ref) {
  final drama = ref.watch(feedCurrentDramaProvider);
  return drama?.playCount ?? 0;
});

/// Feed Notifier
class FeedNotifier extends StateNotifier<FeedState> {
  FeedNotifier() : super(const FeedState());

  /// 切换播放/暂停
  void togglePlayPause() {
    state = state.copyWith(
      isPlaying: !state.isPlaying,
      showPauseIcon: true,
    );
    // 2秒后隐藏暂停图标
    Future.delayed(const Duration(seconds: 2), () {
      state = state.copyWith(showPauseIcon: false);
    });
  }

  /// 切换点赞
  void toggleLike() {
    state = state.copyWith(isLiked: !state.isLiked);
  }

  /// 切换收藏
  void toggleFavorite() {
    state = state.copyWith(isFavorited: !state.isFavorited);
  }

  /// 切换到下一集
  void nextEpisode() {
    final episodes = _getMockEpisodes(state.currentDramaId);
    if (state.episodeIndex < episodes.length - 1) {
      state = state.copyWith(episodeIndex: state.episodeIndex + 1);
    }
  }

  /// 切换到上一集
  void previousEpisode() {
    if (state.episodeIndex > 0) {
      state = state.copyWith(episodeIndex: state.episodeIndex - 1);
    }
  }

  /// 跳转到指定集数
  void jumpToEpisode(int index) {
    state = state.copyWith(episodeIndex: index);
  }

  /// 切换到下一个剧集
  void nextDrama() {
    final dramas = _getMockDramas();
    if (state.dramaIndex < dramas.length - 1) {
      state = state.copyWith(
        dramaIndex: state.dramaIndex + 1,
        episodeIndex: 0,
        isLiked: false,
        isFavorited: false,
      );
    }
  }

  /// 增加观看时长
  void incrementWatchMinutes() {
    state = state.copyWith(watchMinutes: state.watchMinutes + 1);
    if (state.watchMinutes >= 3 && !state.showCoinHint) {
      state = state.copyWith(showCoinHint: true);
    }
  }

  /// 领取金币
  void claimCoin() {
    state = state.copyWith(showCoinHint: false, watchMinutes: 0);
  }

  /// 更新当前剧集索引
  void updateDramaIndex(int index) {
    final dramas = _getMockDramas();
    if (index >= 0 && index < dramas.length) {
      state = state.copyWith(
        dramaIndex: index,
        episodeIndex: 0,
        isLiked: false,
        isFavorited: false,
      );
    }
  }
}

/// Feed 状态
class FeedState {
  final int dramaIndex;
  final int episodeIndex;
  final String currentDramaId;
  final bool isPlaying;
  final bool isLiked;
  final bool isFavorited;
  final bool showPauseIcon;
  final int watchMinutes;
  final bool showCoinHint;

  const FeedState({
    this.dramaIndex = 0,
    this.episodeIndex = 0,
    this.currentDramaId = '',
    this.isPlaying = true,
    this.isLiked = false,
    this.isFavorited = false,
    this.showPauseIcon = false,
    this.watchMinutes = 0,
    this.showCoinHint = false,
  });

  FeedState copyWith({
    int? dramaIndex,
    int? episodeIndex,
    String? currentDramaId,
    bool? isPlaying,
    bool? isLiked,
    bool? isFavorited,
    bool? showPauseIcon,
    int? watchMinutes,
    bool? showCoinHint,
  }) {
    return FeedState(
      dramaIndex: dramaIndex ?? this.dramaIndex,
      episodeIndex: episodeIndex ?? this.episodeIndex,
      currentDramaId: currentDramaId ?? this.currentDramaId,
      isPlaying: isPlaying ?? this.isPlaying,
      isLiked: isLiked ?? this.isLiked,
      isFavorited: isFavorited ?? this.isFavorited,
      showPauseIcon: showPauseIcon ?? this.showPauseIcon,
      watchMinutes: watchMinutes ?? this.watchMinutes,
      showCoinHint: showCoinHint ?? this.showCoinHint,
    );
  }
}

/// Feed Notifier Provider
final feedNotifierProvider = StateNotifierProvider<FeedNotifier, FeedState>((ref) {
  return FeedNotifier();
});

/// Mock 剧集数据
List<Drama> _getMockDramas() {
  return [
    Drama(
      id: 'drama_001',
      title: '总裁的替身新娘',
      coverUrl: 'https://via.placeholder.com/400x600/1A1A2E/FFFFFF?text=总裁的替身新娘',
      description: '豪门总裁与替身新娘的虐恋情深，跨越阶级的真爱能否修成正果？',
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
      id: 'drama_002',
      title: '重生之复仇女王',
      coverUrl: 'https://via.placeholder.com/400x600/2A2A4E/FFFFFF?text=重生之复仇女王',
      description: '前世被渣男背叛，重生归来，她要让所有伤害她的人付出代价！',
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
      id: 'drama_003',
      title: '穿越时空爱上你',
      coverUrl: 'https://via.placeholder.com/400x600/3A3A6E/FFFFFF?text=穿越时空爱上你',
      description: '现代女孩意外穿越到古代，与冷酷王爷展开一段跨越时空的爱恋。',
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
      id: 'drama_004',
      title: '神秘庄园的秘密',
      coverUrl: 'https://via.placeholder.com/400x600/4A4A8E/FFFFFF?text=神秘庄园的秘密',
      description: '继承神秘庄园后，她发现这里隐藏着一个惊天秘密...',
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
      id: 'drama_005',
      title: '霸道王爷俏王妃',
      coverUrl: 'https://via.placeholder.com/400x600/5A5AAE/FFFFFF?text=霸道王爷俏王妃',
      description: '穿越古代，成为王爷的王妃，却发现自己竟然是...',
      genre: '穿越',
      tags: ['穿越', '古言', '甜宠'],
      episodeCount: 90,
      status: 'ongoing',
      isExclusive: false,
      isNew: true,
      playCount: 1876000,
      collectCount: 123000,
    ),
  ];
}

/// Mock 集数数据
List<Episode> _getMockEpisodes(String dramaId) {
  final episodeCount = _getMockDramas().firstWhere(
    (d) => d.id == dramaId,
    orElse: () => _getMockDramas().first,
  ).episodeCount;

  return List.generate(episodeCount, (index) {
    return Episode(
      id: '${dramaId}_ep_${index + 1}',
      dramaId: dramaId,
      episodeNumber: index + 1,
      title: '第${index + 1}集',
      videoUrl: 'https://example.com/video/$dramaId/${index + 1}.mp4',
      durationSeconds: 120,
      isFree: index < 2,
      coinCost: index < 2 ? 0 : 10,
    );
  });
}
