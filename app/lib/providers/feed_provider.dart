import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/drama.dart';

/// Feed 当前索引
final feedIndexProvider = StateProvider<int>((ref) => 0);

/// Feed 剧集列表
final feedDramasProvider = StateProvider<List<Drama>>((ref) => []);

/// Feed 是否正在加载
final feedLoadingProvider = StateProvider<bool>((ref) => false);

/// Feed 是否还有更多
final feedHasMoreProvider = StateProvider<bool>((ref) => true);

/// Feed 自动播放
final feedAutoPlayProvider = StateProvider<bool>((ref) => true);

class FeedNotifier extends StateNotifier<List<Drama>> {
  FeedNotifier() : super([]);

  /// 加载更多
  Future<void> loadMore() async {
    // TODO: 实现分页加载
  }

  /// 刷新
  Future<void> refresh() async {
    // TODO: 实现刷新逻辑
  }
}
