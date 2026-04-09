class Validators {
  Validators._();

  /// 验证手机号
  static bool isValidPhone(String phone) {
    final regex = RegExp(r'^1[3-9]\d{9}$');
    return regex.hasMatch(phone);
  }

  /// 验证验证码（6位数字）
  static bool isValidSmsCode(String code) {
    final regex = RegExp(r'^\d{6}$');
    return regex.hasMatch(code);
  }

  /// 验证密码（至少6位，包含字母和数字）
  static bool isValidPassword(String password) {
    if (password.length < 6) return false;
    final hasLetter = RegExp(r'[a-zA-Z]').hasMatch(password);
    final hasNumber = RegExp(r'\d').hasMatch(password);
    return hasLetter && hasNumber;
  }

  /// 验证昵称（2-20个字符）
  static bool isValidNickname(String nickname) {
    return nickname.length >= 2 && nickname.length <= 20;
  }

  /// 验证URL
  static bool isValidUrl(String url) {
    final regex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    return regex.hasMatch(url);
  }

  /// 验证是否为空
  static bool isEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  /// 手机号格式化提示
  static String? phoneValidator(String? value) {
    if (isEmpty(value)) return '请输入手机号';
    if (!isValidPhone(value!)) return '请输入正确的手机号';
    return null;
  }

  /// 验证码格式化提示
  static String? smsCodeValidator(String? value) {
    if (isEmpty(value)) return '请输入验证码';
    if (!isValidSmsCode(value!)) return '请输入6位数字验证码';
    return null;
  }

  /// 密码格式化提示
  static String? passwordValidator(String? value) {
    if (isEmpty(value)) return '请输入密码';
    if (!isValidPassword(value!)) return '密码至少6位，需包含字母和数字';
    return null;
  }

  /// 昵称格式化提示
  static String? nicknameValidator(String? value) {
    if (isEmpty(value)) return '请输入昵称';
    if (!isValidNickname(value!)) return '昵称长度为2-20个字符';
    return null;
  }
}
