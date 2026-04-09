import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user.dart';

// ==================== 用户信息 ====================

/// 当前用户信息
final profileUserProvider = StateProvider<User?>((ref) => User(
      id: 'user_001',
      nickname: '山狸用户',
      avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=shanli',
      vipLevel: 1,
      vipExpireAt: DateTime.now().add(const Duration(days: 30)).toIso8601String(),
      coinBalance: 1280,
      totalWatchSeconds: 7200,
    ));

// ==================== VIP 相关 ====================

/// VIP 状态
final profileVipStatusProvider = StateProvider<bool>((ref) => true);

/// VIP 到期时间
final profileVipExpireProvider = StateProvider<String>((ref) =>
    DateTime.now().add(const Duration(days: 30)).toIso8601String());

/// VIP 等级
final profileVipLevelProvider = StateProvider<int>((ref) => 1);

// ==================== VIP 套餐 ====================

/// VIP 套餐类型
enum VipPlanType { weekly, monthly, quarterly, yearly }

/// VIP 套餐
class VipPlan {
  final VipPlanType type;
  final String name;
  final int price;
  final int originalPrice;
  final String description;
  final String badgeText;

  const VipPlan({
    required this.type,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.description,
    this.badgeText = '',
  });

  /// 折扣
  double get discount => price / originalPrice;
}

/// VIP 套餐列表
final vipPlansProvider = StateProvider<List<VipPlan>>((ref) => [
      VipPlan(
        type: VipPlanType.weekly,
        name: '周会员',
        price: 99,
        originalPrice: 199,
        description: '7天VIP权益',
      ),
      VipPlan(
        type: VipPlanType.monthly,
        name: '月会员',
        price: 299,
        originalPrice: 599,
        description: '30天VIP权益',
      ),
      VipPlan(
        type: VipPlanType.quarterly,
        name: '季会员',
        price: 699,
        originalPrice: 1499,
        description: '90天VIP权益',
      ),
      VipPlan(
        type: VipPlanType.yearly,
        name: '年会员',
        price: 1999,
        originalPrice: 5999,
        description: '365天VIP权益',
        badgeText: '最划算',
      ),
    ]);

/// 当前选中的套餐
final selectedVipPlanProvider = StateProvider<VipPlan?>((ref) => null);

/// 支付方式
enum PaymentMethod { wechat, alipay }

/// 当前选中的支付方式
final selectedPaymentMethodProvider =
    StateProvider<PaymentMethod>((ref) => PaymentMethod.wechat);

// ==================== VIP 权益 ====================

/// VIP 权益列表
final vipBenefitsProvider = StateProvider<List<VipBenefit>>((ref) => [
      VipBenefit(
        icon: Icons.block_outlined,
        title: '去广告',
        description: '畅享无广告观看体验',
      ),
      VipBenefit(
        icon: Icons.play_circle_outline,
        title: '畅看全部',
        description: '全站剧集免费观看',
      ),
      VipBenefit(
        icon: Icons.support_agent_outlined,
        title: '专属客服',
        description: '优先响应VIP用户问题',
      ),
      VipBenefit(
        icon: Icons.flash_on_outlined,
        title: '优先看新剧',
        description: '新剧抢先观看特权',
      ),
    ]);

class VipBenefit {
  final IconData icon;
  final String title;
  final String description;

  const VipBenefit({
    required this.icon,
    required this.title,
    required this.description,
  });
}

// ==================== 菜单项 ====================

/// 菜单项类型
enum MenuItemType {
  favorites,
  history,
  messages,
  invite,
  feedback,
  settings,
}

/// 菜单项
class MenuItem {
  final MenuItemType type;
  final String title;
  final IconData icon;
  final bool hasBadge;
  final bool showArrow;

  const MenuItem({
    required this.type,
    required this.title,
    required this.icon,
    this.hasBadge = false,
    this.showArrow = true,
  });
}

/// 菜单列表
final menuListProvider = StateProvider<List<MenuItem>>((ref) => [
      MenuItem(
        type: MenuItemType.favorites,
        title: '我的收藏',
        icon: Icons.favorite_border,
      ),
      MenuItem(
        type: MenuItemType.history,
        title: '观看历史',
        icon: Icons.history,
      ),
      MenuItem(
        type: MenuItemType.messages,
        title: '我的消息',
        icon: Icons.notifications_outlined,
        hasBadge: true,
      ),
      MenuItem(
        type: MenuItemType.invite,
        title: '邀请好友',
        icon: Icons.person_add_outlined,
      ),
      MenuItem(
        type: MenuItemType.feedback,
        title: '意见反馈',
        icon: Icons.feedback_outlined,
      ),
      MenuItem(
        type: MenuItemType.settings,
        title: '设置',
        icon: Icons.settings_outlined,
      ),
    ]);

// ==================== 设置项 ====================

/// 设置项类型
enum SettingItemType {
  notification,
  autoPlay,
  clearCache,
  userAgreement,
  privacyPolicy,
  aboutUs,
  logout,
}

/// 设置项
class SettingItem {
  final SettingItemType type;
  final String title;
  final IconData icon;
  final bool isSwitch;
  final bool switchValue;
  final String? valueText;

  const SettingItem({
    required this.type,
    required this.title,
    required this.icon,
    this.isSwitch = false,
    this.switchValue = false,
    this.valueText,
  });
}

/// 设置列表
final settingListProvider = StateProvider<List<SettingItem>>((ref) => [
      SettingItem(
        type: SettingItemType.notification,
        title: '消息通知',
        icon: Icons.notifications_outlined,
        isSwitch: true,
        switchValue: true,
      ),
      SettingItem(
        type: SettingItemType.clearCache,
        title: '清除缓存',
        icon: Icons.delete_outline,
        valueText: '0 MB',
      ),
      SettingItem(
        type: SettingItemType.userAgreement,
        title: '用户协议',
        icon: Icons.description_outlined,
      ),
      SettingItem(
        type: SettingItemType.privacyPolicy,
        title: '隐私政策',
        icon: Icons.privacy_tip_outlined,
      ),
      SettingItem(
        type: SettingItemType.aboutUs,
        title: '关于我们',
        icon: Icons.info_outline,
      ),
      SettingItem(
        type: SettingItemType.logout,
        title: '退出登录',
        icon: Icons.logout,
      ),
]);

// ==================== 工具函数 ====================

/// 格式化 VIP 到期时间
String formatVipExpire(String? expireAt) {
  if (expireAt == null) return '未开通';
  try {
    final date = DateTime.parse(expireAt);
    if (date.isBefore(DateTime.now())) {
      return '已过期';
    }
    final days = date.difference(DateTime.now()).inDays;
    if (days == 0) return '今日到期';
    if (days < 30) return '$days天后到期';
    return '${date.year}年${date.month}月${date.day}日到期';
  } catch (e) {
    return '未开通';
  }
}
