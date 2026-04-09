import 'package:hive_flutter/hive_flutter.dart';

class HiveBoxes {
  HiveBoxes._();

  // Box 名称
  static const String userBox = 'user_box';
  static const String dramaBox = 'drama_box';
  static const String cacheBox = 'cache_box';
  static const String settingsBox = 'settings_box';
  static const String historyBox = 'history_box';
  static const String favoriteBox = 'favorite_box';

  // 打开所有 Box
  static Future<void> openBoxes() async {
    await Hive.openBox(userBox);
    await Hive.openBox(dramaBox);
    await Hive.openBox(cacheBox);
    await Hive.openBox(settingsBox);
    await Hive.openBox(historyBox);
    await Hive.openBox(favoriteBox);
  }

  // 获取 Box
  static Box<T> getBox<T>(String name) => Hive.box<T>(name);

  // 关闭所有 Box
  static Future<void> closeBoxes() async {
    await Hive.box(userBox).close();
    await Hive.box(dramaBox).close();
    await Hive.box(cacheBox).close();
    await Hive.box(settingsBox).close();
    await Hive.box(historyBox).close();
    await Hive.box(favoriteBox).close();
  }

  // 清除所有 Box 数据
  static Future<void> clearAllBoxes() async {
    await Hive.box(userBox).clear();
    await Hive.box(dramaBox).clear();
    await Hive.box(cacheBox).clear();
    await Hive.box(settingsBox).clear();
    await Hive.box(historyBox).clear();
    await Hive.box(favoriteBox).clear();
  }
}
