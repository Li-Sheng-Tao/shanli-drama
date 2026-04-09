import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import 'profile_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingListProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text('设置'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        children: settings.map((setting) {
          return _buildSettingItem(context, ref, setting);
        }).toList(),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    WidgetRef ref,
    SettingItem setting,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
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
      child: InkWell(
        onTap: () => _handleSettingTap(context, ref, setting),
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              Icon(
                setting.icon,
                size: 22.sp,
                color: AppColors.textPrimary,
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  setting.title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              // Switch 或 值文本
              if (setting.isSwitch)
                Switch(
                  value: setting.switchValue,
                  onChanged: (value) {
                    // 更新开关状态
                    final currentSettings = ref.read(settingListProvider);
                    ref.read(settingListProvider.notifier).state = currentSettings.map((s) {
                      if (s.type == setting.type) {
                        return SettingItem(
                          type: s.type,
                          title: s.title,
                          icon: s.icon,
                          isSwitch: s.isSwitch,
                          switchValue: value,
                        );
                      }
                      return s;
                    }).toList();
                  },
                  activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
                  activeThumbColor: AppColors.primary,
                )
              else if (setting.valueText != null)
                Row(
                  children: [
                    Text(
                      setting.valueText!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.chevron_right,
                      size: 20.sp,
                      color: AppColors.textHint,
                    ),
                  ],
                )
              else
                Icon(
                  Icons.chevron_right,
                  size: 20.sp,
                  color: AppColors.textHint,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSettingTap(
    BuildContext context,
    WidgetRef ref,
    SettingItem setting,
  ) {
    if (setting.isSwitch) return;

    switch (setting.type) {
      case SettingItemType.clearCache:
        _showClearCacheDialog(context);
        break;
      case SettingItemType.userAgreement:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('用户协议 - 功能开发中'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        break;
      case SettingItemType.privacyPolicy:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('隐私政策 - 功能开发中'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        break;
      case SettingItemType.aboutUs:
        _showAboutDialog(context);
        break;
      case SettingItemType.logout:
        _showLogoutDialog(context, ref);
        break;
      default:
        break;
    }
  }

  /// 清除缓存对话框
  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: Text(
          '清除缓存',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          '确定要清除所有缓存吗？',
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('缓存已清除'),
                  backgroundColor: AppColors.primary,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  /// 关于对话框
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: Text(
          '关于我们',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '山狸看剧',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '版本 v1.0.0',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              '山狸看剧是一款优质的短剧聚合平台，为您提供海量精彩短剧内容。',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  /// 退出登录对话框
  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: Text(
          '退出登录',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          '确定要退出登录吗？',
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              // 退出登录逻辑
              ref.read(profileUserProvider.notifier).state = null;
              ref.read(profileVipStatusProvider.notifier).state = false;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('已退出登录'),
                  backgroundColor: AppColors.primary,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('退出'),
          ),
        ],
      ),
    );
  }
}
