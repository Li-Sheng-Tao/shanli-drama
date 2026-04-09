import '../core/storage/storage_service.dart';
import '../repositories/auth_repository.dart';

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  /// 是否已登录
  bool get isLoggedIn => AuthRepository.instance.isLoggedIn;

  /// 获取 Token
  String? get token => StorageService.instance.getToken();

  /// 手机号登录
  Future<bool> loginByPhone(String phone, String code) async {
    final user = await AuthRepository.instance.loginByPhone(phone, code);
    return user != null;
  }

  /// 微信登录（预留）
  Future<bool> loginByWechat() async {
    final user = await AuthRepository.instance.loginByWechat();
    return user != null;
  }

  /// 发送验证码
  Future<bool> sendSmsCode(String phone) async {
    return AuthRepository.instance.sendSmsCode(phone);
  }

  /// 退出登录
  Future<void> logout() async {
    await AuthRepository.instance.logout();
  }
}
