import 'package:flutter/foundation.dart';

/// 视频播放服务
///
/// 管理视频播放器的生命周期、缓存等
class VideoService {
  VideoService._();
  static final VideoService instance = VideoService._();

  /// 获取视频播放地址
  ///
  /// 根据剧集ID和集数ID获取实际的视频播放URL
  Future<String?> getPlayUrl({
    required String dramaId,
    required String episodeId,
  }) async {
    try {
      // TODO: 调用实际 API 获取播放地址
      // final response = await DioClient.instance.get(
      //   ApiConstants.episodePlayUrl,
      //   queryParameters: {
      //     'drama_id': dramaId,
      //     'episode_id': episodeId,
      //   },
      // );
      // return response.data['play_url'] as String?;
      return null;
    } catch (e) {
      debugPrint('获取播放地址失败: $e');
      return null;
    }
  }

  /// 预加载下一集
  Future<void> preloadNextEpisode(String episodeId) async {
    // TODO: 实现预加载逻辑
  }

  /// 上报播放进度
  Future<void> reportPlayProgress({
    required String dramaId,
    required String episodeId,
    required int progressSeconds,
    required int totalSeconds,
  }) async {
    // TODO: 调用实际 API 上报播放进度
  }

  /// 记录观看时长（用于任务系统）
  Future<void> recordWatchDuration(int seconds) async {
    // TODO: 调用实际 API 记录观看时长
  }
}
