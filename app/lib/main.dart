import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/network/dio_client.dart';
import 'core/storage/storage_service.dart';
import 'core/storage/hive_boxes.dart';
import 'services/ad_service.dart';
import 'services/analytics_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化本地存储
  await StorageService.init();

  // 初始化网络
  DioClient.init();

  // 初始化广告服务（预留）
  await AdService.instance.init();

  // 初始化数据分析（预留）
  await AnalyticsService.instance.init();

  runApp(const ProviderScope(child: App()));
}

@pragma('vm:entry-point')
void dispose() async {
  // 关闭 Hive
  await HiveBoxes.closeBoxes();
}
