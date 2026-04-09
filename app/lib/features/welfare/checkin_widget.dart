import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import 'welfare_provider.dart';

class CheckinWidget extends ConsumerStatefulWidget {
  const CheckinWidget({super.key});

  @override
  ConsumerState<CheckinWidget> createState() => _CheckinWidgetState();
}

class _CheckinWidgetState extends ConsumerState<CheckinWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _bounceAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );
    _startBounceAnimation();
  }

  void _startBounceAnimation() {
    _bounceController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final checkinDays = ref.watch(checkinDaysProvider);
    final isCheckedIn = ref.watch(checkinProvider);
    final checkinRewards = ref.watch(checkinRewardsProvider);

    return Container(
      padding: EdgeInsets.all(16.r),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题行
          Row(
            children: [
              Icon(
                Icons.today,
                color: AppColors.primary,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                '每日签到',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Text(
                '已连续签到 $checkinDays 天',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // 7天签到格子
          Row(
            children: List.generate(7, (index) {
              final day = checkinRewards[index];
              final isCompleted = day.checked;
              final isToday = index == checkinDays && !isCheckedIn;

              return Expanded(
                child: _buildDayCell(
                  day: day.day,
                  reward: day.reward,
                  isCompleted: isCompleted,
                  isToday: isToday,
                ),
              );
            }),
          ),

          SizedBox(height: 16.h),

          // 签到按钮
          SizedBox(
            width: double.infinity,
            height: 44.h,
            child: ElevatedButton(
              onPressed: isCheckedIn ? null : _doCheckin,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isCheckedIn ? Colors.grey.shade300 : AppColors.primary,
                disabledBackgroundColor: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.r),
                ),
                elevation: 0,
              ),
              child: Text(
                isCheckedIn ? '今日已签到' : '立即签到',
                style: TextStyle(
                  color: isCheckedIn ? AppColors.textSecondary : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayCell({
    required int day,
    required int reward,
    required bool isCompleted,
    required bool isToday,
  }) {
    return Column(
      children: [
        // 天数格子
        AnimatedBuilder(
          animation: isToday ? _bounceAnimation : AlwaysStoppedAnimation(1.0),
          builder: (context, child) {
            final scale = isToday ? _bounceAnimation.value : 1.0;
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.primary
                  : isToday
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : const Color(0xFFF5F5F5),
              shape: BoxShape.circle,
              border: isToday
                  ? Border.all(
                      color: AppColors.primary,
                      width: 2,
                    )
                  : null,
            ),
            child: Center(
              child: isCompleted
                  ? Icon(
                      Icons.check,
                      size: 18.sp,
                      color: Colors.white,
                    )
                  : Text(
                      '$day',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: isToday
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontWeight:
                            isToday ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        // 奖励金币
        Text(
          '+$reward',
          style: TextStyle(
            fontSize: 10.sp,
            color: isCompleted
                ? AppColors.primary
                : AppColors.textSecondary,
            fontWeight: isCompleted ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Future<void> _doCheckin() async {
    final checkinDays = ref.read(checkinDaysProvider);
    final rewards = ref.read(checkinRewardsProvider);

    // 更新签到状态
    ref.read(checkinProvider.notifier).state = true;
    ref.read(checkinDaysProvider.notifier).state = checkinDays + 1;

    // 更新签到格子
    ref.read(checkinRewardsProvider.notifier).state = rewards.map((day) {
      if (day.day == checkinDays + 1) {
        return day.copyWith(checked: true);
      }
      return day;
    }).toList();

    // 增加金币
    final earnedReward = rewards[checkinDays].reward;
    ref.read(welfareCoinBalanceProvider.notifier).state += earnedReward;
    ref.read(todayEarnedCoinsProvider.notifier).state += earnedReward;

    // 停止跳动动画
    _bounceController.stop();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('签到成功！获得 $earnedReward 山狸币'),
          backgroundColor: AppColors.primary,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }
}

/// 简单的 AnimatedBuilder 用于条件动画
class AnimatedBuilder extends StatelessWidget {
  final Animation<double> animation;
  final Widget Function(BuildContext context, Widget? child) builder;
  final Widget? child;

  const AnimatedBuilder({
    super.key,
    required this.animation,
    required this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder._internal(
      animation: animation,
      builder: builder,
      child: child,
    );
  }

  // 使用 AnimatedWidget 内部实现
  static _AnimatedBuilderInternal _internal({
    required Animation<double> animation,
    required Widget Function(BuildContext context, Widget? child) builder,
    Widget? child,
  }) {
    return _AnimatedBuilderInternal(
      listenable: animation,
      builder: builder,
      child: child,
    );
  }
}

class _AnimatedBuilderInternal extends AnimatedWidget {
  final Widget Function(BuildContext context, Widget? child) builder;
  final Widget? child;

  const _AnimatedBuilderInternal({
    required super.listenable,
    required this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return builder(context, child);
  }
}
