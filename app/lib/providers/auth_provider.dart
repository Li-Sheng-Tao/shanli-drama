import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../repositories/auth_repository.dart';

/// 认证状态
enum AuthStatus { unknown, authenticated, unauthenticated }

/// 认证状态 Provider
final authStatusProvider = StateNotifierProvider<AuthNotifier, AuthStatus>(
  (ref) => AuthNotifier(ref),
);

/// 当前用户 Provider
final currentUserProvider = StateProvider<User?>((ref) => null);

class AuthNotifier extends StateNotifier<AuthStatus> {
  final Ref _ref;

  AuthNotifier(this._ref) : super(AuthStatus.unknown) {
    _checkAuthStatus();
  }

  /// 检查登录状态
  void _checkAuthStatus() {
    final isLoggedIn = AuthRepository.instance.isLoggedIn;
    state = isLoggedIn ? AuthStatus.authenticated : AuthStatus.unauthenticated;
  }

  /// 手机号登录
  Future<bool> loginByPhone(String phone, String code) async {
    try {
      final user = await AuthRepository.instance.loginByPhone(phone, code);
      if (user != null) {
        _ref.read(currentUserProvider.notifier).state = user;
        state = AuthStatus.authenticated;
        return true;
      }
      return false;
    } catch (e) {
      state = AuthStatus.unauthenticated;
      return false;
    }
  }

  /// 微信登录（预留）
  Future<bool> loginByWechat() async {
    try {
      // TODO: 集成微信SDK后实现
      // final user = await AuthRepository.instance.loginByWechat();
      // if (user != null) {
      //   _ref.read(currentUserProvider.notifier).state = user;
      //   state = AuthStatus.authenticated;
      //   return true;
      // }
      return false;
    } catch (e) {
      state = AuthStatus.unauthenticated;
      return false;
    }
  }

  /// 退出登录
  Future<void> logout() async {
    await AuthRepository.instance.logout();
    _ref.read(currentUserProvider.notifier).state = null;
    state = AuthStatus.unauthenticated;
  }
}
