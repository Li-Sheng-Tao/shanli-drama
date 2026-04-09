import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import 'welfare_provider.dart';

class TaskListWidget extends ConsumerWidget {
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskListProvider);

    // 按分组
    final groups = TaskGroup.values;
    final groupTasks = <TaskGroup, List<TaskItem>>{};
    for (final group in groups) {
      groupTasks[group] = tasks.where((t) => t.group == group).toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groups.map((group) {
        final items = groupTasks[group]!;
        if (items.isEmpty) return const SizedBox.shrink();

        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: _buildTaskGroup(context, ref, group, items),
        );
      }).toList(),
    );
  }

  Widget _buildTaskGroup(
    BuildContext context,
    WidgetRef ref,
    TaskGroup group,
    List<TaskItem> tasks,
  ) {
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
          // 分组标题
          Row(
            children: [
              Icon(
                taskGroupIcon(group),
                color: AppColors.primary,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                taskGroupTitle(group),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Text(
                '${tasks.where((t) => t.rewardClaimed).length}/${tasks.length}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // 任务列表
          ...tasks.map((task) => _buildTaskItem(context, ref, task)),
        ],
      ),
    );
  }

  Widget _buildTaskItem(
    BuildContext context,
    WidgetRef ref,
    TaskItem task,
  ) {
    final isGreyedOut = task.rewardClaimed;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Opacity(
        opacity: isGreyedOut ? 0.6 : 1.0,
        child: Row(
          children: [
            // 左侧图标
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: isGreyedOut
                    ? Colors.grey.shade200
                    : AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Icon(
                  task.icon,
                  color: isGreyedOut ? Colors.grey : AppColors.primary,
                  size: 20.sp,
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // 中间内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 任务名称
                  Row(
                    children: [
                      Text(
                        task.name,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      // 金币奖励标签
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.monetization_on,
                              size: 10.sp,
                              color: AppColors.secondary,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              '+${task.coinReward}',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  // 任务描述
                  Text(
                    task.description,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  // 进度条
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3.r),
                          child: LinearProgressIndicator(
                            value: task.progressRatio,
                            backgroundColor: const Color(0xFFF0F0F0),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.primary,
                            ),
                            minHeight: 4.h,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '${task.progress}/${task.targetValue}',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),

            // 右侧按钮
            _buildActionButton(context, ref, task),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    WidgetRef ref,
    TaskItem task,
  ) {
    if (task.rewardClaimed) {
      // 已领取
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check, size: 12.sp, color: AppColors.textSecondary),
            SizedBox(width: 2.w),
            Text(
              '已领取',
              style: TextStyle(
                fontSize: 11.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    } else if (task.canClaim) {
      // 可领取
      return SizedBox(
        height: 30.h,
        child: ElevatedButton(
          onPressed: () => _claimReward(context, ref, task),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            minimumSize: Size.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            elevation: 0,
          ),
          child: Text(
            '领取',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
          ),
        ),
      );
    } else {
      // 去完成
      return SizedBox(
        height: 30.h,
        child: OutlinedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('功能开发中，敬请期待'),
                duration: Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            minimumSize: Size.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            side: BorderSide(color: AppColors.primary.withValues(alpha: 0.5)),
            elevation: 0,
          ),
          child: Text(
            '去完成',
            style: TextStyle(fontSize: 12.sp),
          ),
        ),
      );
    }
  }

  void _claimReward(BuildContext context, WidgetRef ref, TaskItem task) {
    // 更新任务状态
    final tasks = ref.read(taskListProvider);
    ref.read(taskListProvider.notifier).state = tasks.map((t) {
      if (t.id == task.id) {
        return t.copyWith(rewardClaimed: true);
      }
      return t;
    }).toList();

    // 增加金币
    ref.read(welfareCoinBalanceProvider.notifier).state += task.coinReward;
    ref.read(todayEarnedCoinsProvider.notifier).state += task.coinReward;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('领取成功！获得 ${task.coinReward} 山狸币'),
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
