import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive_boxes.dart';

class StorageService {
  StorageService._();
  static late final StorageService instance;

  SharedPreferences? _prefs;

  SharedPreferences get prefs => _prefs!;

  static Future<void> init() async {
    instance = StorageService._();
    instance._prefs = await SharedPreferences.getInstance();

    // 初始化 Hive
    await Hive.initFlutter();

    // 注册 Hive Adapter（如果有自定义类型）
    // Hive.registerAdapter(UserAdapter());

    // 打开 Box
    await HiveBoxes.openBoxes();
  }

  // ==================== Token ====================
  static const String _keyToken = 'auth_token';
  static const String _keyRefreshToken = 'refresh_token';

  String? getToken() => _prefs?.getString(_keyToken);

  Future<bool> setToken(String token) =>
      _prefs!.setString(_keyToken, token);

  String? getRefreshToken() => _prefs?.getString(_keyRefreshToken);

  Future<bool> setRefreshToken(String token) =>
      _prefs!.setString(_keyRefreshToken, token);

  Future<bool> clearToken() async {
    await _prefs!.remove(_keyToken);
    await _prefs!.remove(_keyRefreshToken);
    return true;
  }

  bool get isLoggedIn {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  // ==================== 用户信息 ====================
  static const String _keyUserId = 'user_id';
  static const String _keyNickname = 'user_nickname';
  static const String _keyAvatar = 'user_avatar';

  String? getUserId() => _prefs?.getString(_keyUserId);

  Future<bool> setUserId(String id) => _prefs!.setString(_keyUserId, id);

  String? getNickname() => _prefs?.getString(_keyNickname);

  Future<bool> setNickname(String name) =>
      _prefs!.setString(_keyNickname, name);

  String? getAvatar() => _prefs?.getString(_keyAvatar);

  Future<bool> setAvatar(String url) => _prefs!.setString(_keyAvatar, url);

  // ==================== 通用存储 ====================
  T? getValue<T>(String key) {
    if (T == String) {
      return _prefs?.getString(key) as T?;
    } else if (T == int) {
      return _prefs?.getInt(key) as T?;
    } else if (T == double) {
      return _prefs?.getDouble(key) as T?;
    } else if (T == bool) {
      return _prefs?.getBool(key) as T?;
    } else if (T == List<String>) {
      return _prefs?.getStringList(key) as T?;
    }
    return null;
  }

  Future<bool> setValue<T>(String key, T value) {
    if (value is String) {
      return _prefs!.setString(key, value);
    } else if (value is int) {
      return _prefs!.setInt(key, value);
    } else if (value is double) {
      return _prefs!.setDouble(key, value);
    } else if (value is bool) {
      return _prefs!.setBool(key, value);
    } else if (value is List<String>) {
      return _prefs!.setStringList(key, value);
    }
    return Future.value(false);
  }

  Future<bool> remove(String key) => _prefs!.remove(key);

  Future<bool> clear() => _prefs!.clear();
}
