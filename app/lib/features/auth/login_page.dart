import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/validators.dart';
import '../../providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  final _codeFocusNode = FocusNode();

  bool _agreedToTerms = false;
  bool _isSendingCode = false;
  int _countdown = 0;

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _phoneFocusNode.dispose();
    _codeFocusNode.dispose();
    super.dispose();
  }

  /// 发送验证码
  Future<void> _sendCode() async {
    final phone = _phoneController.text.trim();
    final error = Validators.phoneValidator(phone);
    if (error != null) {
      _showToast(error);
      return;
    }

    setState(() => _isSendingCode = true);
    // TODO: 调用发送验证码 API
    // final success = await AuthService.instance.sendSmsCode(phone);
    setState(() => _isSendingCode = false);

    // 暂时直接启动倒计时，实际应判断 API 返回结果
    _startCountdown();
    _showToast('验证码已发送');
  }

  /// 开始倒计时
  void _startCountdown() {
    setState(() => _countdown = 60);
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      setState(() => _countdown--);
      return _countdown > 0;
    });
  }

  /// 手机号登录
  Future<void> _loginByPhone() async {
    if (!_agreedToTerms) {
      _showToast('请先同意用户协议和隐私政策');
      return;
    }

    final phone = _phoneController.text.trim();
    final code = _codeController.text.trim();

    final phoneError = Validators.phoneValidator(phone);
    if (phoneError != null) {
      _showToast(phoneError);
      return;
    }

    final codeError = Validators.smsCodeValidator(code);
    if (codeError != null) {
      _showToast(codeError);
      return;
    }

    final success =
        await ref.read(authStatusProvider.notifier).loginByPhone(phone, code);
    if (success && mounted) {
      context.go('/main');
    } else if (mounted) {
      _showToast('登录失败，请重试');
    }
  }

  /// 微信登录（预留）
  Future<void> _loginByWechat() async {
    if (!_agreedToTerms) {
      _showToast('请先同意用户协议和隐私政策');
      return;
    }

    final success =
        await ref.read(authStatusProvider.notifier).loginByWechat();
    if (success && mounted) {
      context.go('/main');
    } else if (mounted) {
      _showToast('微信登录暂未开放');
    }
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),

              // Logo
              const Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.play_circle_filled,
                      size: 80,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 16),
                    Text(
                      '山狸看剧',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '精彩短剧 一刷到底',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // 手机号输入框
              TextField(
                controller: _phoneController,
                focusNode: _phoneFocusNode,
                keyboardType: TextInputType.phone,
                maxLength: 11,
                decoration: const InputDecoration(
                  hintText: '请输入手机号',
                  prefixIcon: Icon(Icons.phone_outlined),
                  counterText: '',
                ),
              ),

              const SizedBox(height: 16),

              // 验证码输入框
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _codeController,
                      focusNode: _codeFocusNode,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: const InputDecoration(
                        hintText: '请输入验证码',
                        prefixIcon: Icon(Icons.lock_outline),
                        counterText: '',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    height: 48,
                    child: TextButton(
                      onPressed:
                          _countdown > 0 || _isSendingCode ? null : _sendCode,
                      child: Text(
                        _countdown > 0 ? '${_countdown}s' : '获取验证码',
                        style: TextStyle(
                          fontSize: 14,
                          color: _countdown > 0
                              ? AppColors.textSecondary
                              : AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 登录按钮
              ElevatedButton(
                onPressed: _loginByPhone,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text(
                  '登录',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 微信登录按钮（预留）
              OutlinedButton.icon(
                onPressed: _loginByWechat,
                icon: const Icon(Icons.chat, color: Color(0xFF07C160)),
                label: const Text(
                  '微信一键登录',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  minimumSize: const Size(double.infinity, 48),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
              ),

              const SizedBox(height: 24),

              // 用户协议
              Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value: _agreedToTerms,
                      onChanged: (value) {
                        setState(() => _agreedToTerms = value ?? false);
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      activeColor: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Wrap(
                      children: [
                        const Text(
                          '我已阅读并同意',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: 打开用户协议
                          },
                          child: const Text(
                            '《用户协议》',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const Text(
                          '和',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: 打开隐私政策
                          },
                          child: const Text(
                            '《隐私政策》',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
