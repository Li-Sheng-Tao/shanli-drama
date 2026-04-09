import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/drama.dart';
import '../models/episode.dart';
import '../repositories/drama_repository.dart';

/// 推荐剧集列表
final recommendDramasProvider =
    FutureProvider<List<Drama>>((ref) async {
  return DramaRepository.instance.getRecommendDramas();
});

/// 剧集详情
final dramaDetailProvider =
    FutureProvider.family<Drama?, String>((ref, dramaId) async {
  return DramaRepository.instance.getDramaDetail(dramaId);
});

/// 剧集列表（分页）
final dramaListProvider =
    FutureProvider.family<List<Drama>, String>((ref, category) async {
  return DramaRepository.instance.getDramaList(category: category);
});

/// 剧集集数列表
final episodeListProvider =
    FutureProvider.family<List<Episode>, String>((ref, dramaId) async {
  return DramaRepository.instance.getEpisodeList(dramaId);
});

/// 搜索结果
final searchResultProvider =
    FutureProvider.family<List<Drama>, String>((ref, keyword) async {
  return DramaRepository.instance.searchDramas(keyword);
});

/// 排行榜
final rankingProvider =
    FutureProvider<List<Drama>>((ref) async {
  return DramaRepository.instance.getRankings();
});

/// 收藏状态
final isFavoriteProvider =
    StateProvider.family<bool, String>((ref, dramaId) => false);

class DramaNotifier extends StateNotifier<AsyncValue<List<Drama>>> {
  DramaNotifier() : super(const AsyncValue.loading());

  /// 刷新推荐列表
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final dramas = await DramaRepository.instance.getRecommendDramas();
      state = AsyncValue.data(dramas);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
