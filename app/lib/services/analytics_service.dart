import 'package:flutter/foundation.dart';

/// 数据分析服务（预留）
///
/// 用于统计用户行为数据，如：
/// - 页面访问
/// - 视频播放
/// - 按钮点击
/// - 购买转化
class AnalyticsService {
  AnalyticsService._();
  static final AnalyticsService instance = AnalyticsService._();

  /// 初始化
  Future<void> init() async {
    // TODO: 集成第三方分析SDK
  }

  /// 页面访问事件
  void trackPageView({
    required String pageName,
    Map<String, dynamic>? parameters,
  }) {
    debugPrint('[Analytics] PageView: $pageName ${parameters ?? ''}');
  }

  /// 自定义事件
  void trackEvent({
    required String eventName,
    Map<String, dynamic>? parameters,
  }) {
    debugPrint('[Analytics] Event: $eventName ${parameters ?? ''}');
  }

  /// 视频播放事件
  void trackVideoPlay({
    required String dramaId,
    required String episodeId,
    required int episodeNumber,
  }) {
    trackEvent(
      eventName: 'video_play',
      parameters: {
        'drama_id': dramaId,
        'episode_id': episodeId,
        'episode_number': episodeNumber,
      },
    );
  }

  /// 视频完成事件
  void trackVideoComplete({
    required String dramaId,
    required String episodeId,
    required int episodeNumber,
    required int watchDuration,
  }) {
    trackEvent(
      eventName: 'video_complete',
      parameters: {
        'drama_id': dramaId,
        'episode_id': episodeId,
        'episode_number': episodeNumber,
        'watch_duration': watchDuration,
      },
    );
  }

  /// 购买事件
  void trackPurchase({
    required String orderNo,
    required String productType,
    required int amount,
    required String payMethod,
  }) {
    trackEvent(
      eventName: 'purchase',
      parameters: {
        'order_no': orderNo,
        'product_type': productType,
        'amount': amount,
        'pay_method': payMethod,
      },
    );
  }

  /// 广告展示事件
  void trackAdShow({
    required String adType,
    required String adPlacementId,
  }) {
    trackEvent(
      eventName: 'ad_show',
      parameters: {
        'ad_type': adType,
        'ad_placement_id': adPlacementId,
      },
    );
  }

  /// 广告点击事件
  void trackAdClick({
    required String adType,
    required String adPlacementId,
  }) {
    trackEvent(
      eventName: 'ad_click',
      parameters: {
        'ad_type': adType,
        'ad_placement_id': adPlacementId,
      },
    );
  }
}
