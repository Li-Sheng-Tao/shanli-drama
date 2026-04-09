import '../core/storage/storage_service.dart';
import '../models/user.dart';

class AuthRepository {
  AuthRepository._();
  static final AuthRepository instance = AuthRepository._();

  /// 是否已登录
  bool get isLoggedIn => StorageService.instance.isLoggedIn;

  /// 手机号+验证码登录
  Future<User?> loginByPhone(String phone, String code) async {
    try {
      // TODO: 调用实际 API
      // final response = await DioClient.instance.post(
      //   ApiConstants.loginByPhone,
      //   data: {'phone': phone, 'code': code},
      // );
      // final apiResponse = ApiResponse.fromJson(response.data, User.fromJson);
      // if (apiResponse.isSuccess && apiResponse.data != null) {
      //   final user = apiResponse.data as User;
      //   await StorageService.instance.setToken(apiResponse.data!.token);
      //   await StorageService.instance.setUserId(user.id);
      //   await StorageService.instance.setNickname(user.nickname);
      //   await StorageService.instance.setAvatar(user.avatar);
      //   return user;
      // }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// 微信登录（预留）
  Future<User?> loginByWechat() async {
    // TODO: 集成微信SDK后实现
    return null;
  }

  /// 发送验证码
  Future<bool> sendSmsCode(String phone) async {
    try {
      // TODO: 调用实际 API
      // final response = await DioClient.instance.post(
      //   ApiConstants.sendSmsCode,
      //   data: {'phone': phone},
      // );
      // return response.statusCode == 200;
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 退出登录
  Future<void> logout() async {
    await StorageService.instance.clearToken();
    await StorageService.instance.remove('user_id');
    await StorageService.instance.remove('user_nickname');
    await StorageService.instance.remove('user_avatar');
  }

  /// 刷新Token
  Future<String?> refreshToken() async {
    try {
      // TODO: 调用实际 API
      return null;
    } catch (e) {
      return null;
    }
  }
}
