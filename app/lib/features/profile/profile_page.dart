import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import 'profile_provider.dart';
import 'vip_purchase_page.dart';
import 'settings_page.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileUserProvider);
    final isVip = ref.watch(profileVipStatusProvider);
    final vipExpire = ref.watch(profileVipExpireProvider);
    final menuItems = ref.watch(menuListProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. 顶部用户信息卡片
            _buildUserHeader(context, ref, user, isVip, vipExpire),
            SizedBox(height: 12.h),

            // 2. VIP 会员入口
            _buildVipBanner(context),
            SizedBox(height: 12.h),

            // 3. 功能菜单列表
            _buildMenuList(context, ref, menuItems),
            SizedBox(height: 24.h),

            // 4. 底部版本号
            _buildVersionInfo(),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  /// 顶部用户信息卡片
  Widget _buildUserHeader(
    BuildContext context,
    WidgetRef ref,
    dynamic user,
    bool isVip,
    String vipExpire,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 48.h,
        bottom: 24.h,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF2D2D44)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // 顶部设置按钮
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(
                Icons.settings_outlined,
                color: Colors.white.withValues(alpha: 0.7),
                size: 22.sp,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
            ),
          ),
          SizedBox(height: 8.h),
          // 头像 + 用户信息
          Row(
            children: [
              // 头像（带VIP皇冠）
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 64.w,
                    height: 64.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isVip
                            ? const Color(0xFFFFD700)
                            : Colors.white.withValues(alpha: 0.3),
                        width: 2,
                      ),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://api.dicebear.com/7.x/avataaars/svg?seed=shanli',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // VIP 皇冠标识
                  if (isVip)
                    Positioned(
                      right: -4,
                      top: -4,
                      child: Container(
                        width: 22.w,
                        height: 22.h,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFD700),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.star,
                          size: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 16.w),
              // 昵称 + VIP标签
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '山狸用户',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isVip) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFD700), Color(0xFFFFA000)],
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            'VIP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),
                  if (isVip)
                    Text(
                      'VIP到期：${formatVipExpire(vipExpire)}',
                      style: TextStyle(
                        color: const Color(0xFFFFD700).withValues(alpha: 0.8),
                        fontSize: 12.sp,
                      ),
                    )
                  else
                    Text(
                      '登录享受更多权益',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 12.sp,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// VIP 会员入口
  Widget _buildVipBanner(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFFFA000)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.workspace_premium,
            color: Colors.white,
            size: 28.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '开通VIP，畅看去广告',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '首周仅9.9元',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const VipPurchasePage()),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Text(
                '立即开通',
                style: TextStyle(
                  color: const Color(0xFFFFA000),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 功能菜单列表
  Widget _buildMenuList(
    BuildContext context,
    WidgetRef ref,
    List<MenuItem> items,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          return _buildMenuItem(context, ref, item, isLast: index == items.length - 1);
        }),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    WidgetRef ref,
    MenuItem item, {
    required bool isLast,
  }) {
    return InkWell(
      onTap: () => _handleMenuTap(context, item),
      borderRadius: BorderRadius.vertical(
        top: isLast && item.type == MenuItemType.favorites
            ? Radius.circular(12.r)
            : Radius.zero,
        bottom: isLast
            ? Radius.circular(12.r)
            : Radius.zero,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: AppColors.divider,
                    width: 0.5,
                  ),
                ),
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              size: 22.sp,
              color: AppColors.textPrimary,
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            if (item.hasBadge)
              Container(
                width: 8.w,
                height: 8.h,
                decoration: const BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
              ),
            if (item.hasBadge) SizedBox(width: 8.w),
            Icon(
              Icons.chevron_right,
              size: 20.sp,
              color: AppColors.textHint,
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuTap(BuildContext context, MenuItem item) {
    switch (item.type) {
      case MenuItemType.favorites:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('我的收藏 - 功能开发中'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        break;
      case MenuItemType.history:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('观看历史 - 功能开发中'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        break;
      case MenuItemType.messages:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('我的消息 - 功能开发中'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        break;
      case MenuItemType.invite:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('邀请好友 - 功能开发中'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        break;
      case MenuItemType.feedback:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('意见反馈 - 功能开发中'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        break;
      case MenuItemType.settings:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const SettingsPage()),
        );
        break;
    }
  }

  /// 底部版本号
  Widget _buildVersionInfo() {
    return Center(
      child: Text(
        '山狸看剧 v1.0.0',
        style: TextStyle(
          fontSize: 12.sp,
          color: AppColors.textHint,
        ),
      ),
    );
  }
}
