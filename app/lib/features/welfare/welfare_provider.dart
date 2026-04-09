import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ==================== 签到相关 ====================

/// 签到状态 Provider
final checkinProvider = StateProvider<bool>((ref) => false);

/// 连续签到天数 Provider
final checkinDaysProvider = StateProvider<int>((ref) => 3);

/// 7天签到奖励数据
final checkinRewardsProvider = StateProvider<List<CheckinDay>>((ref) => [
      CheckinDay(day: 1, reward: 10, checked: true),
      CheckinDay(day: 2, reward: 15, checked: true),
      CheckinDay(day: 3, reward: 20, checked: true),
      CheckinDay(day: 4, reward: 25, checked: false),
      CheckinDay(day: 5, reward: 30, checked: false),
      CheckinDay(day: 6, reward: 40, checked: false),
      CheckinDay(day: 7, reward: 60, checked: false),
    ]);

class CheckinDay {
  final int day;
  final int reward;
  final bool checked;

  const CheckinDay({
    required this.day,
    required this.reward,
    required this.checked,
  });

  CheckinDay copyWith({bool? checked}) {
    return CheckinDay(
      day: day,
      reward: reward,
      checked: checked ?? this.checked,
    );
  }
}

// ==================== 金币相关 ====================

/// 金币余额
final welfareCoinBalanceProvider = StateProvider<int>((ref) => 1280);

/// 今日已获得金币
final todayEarnedCoinsProvider = StateProvider<int>((ref) => 60);

/// 今日目标金币
final dailyCoinTargetProvider = StateProvider<int>((ref) => 200);

// ==================== 宝箱相关 ====================

/// 宝箱列表
final blindBoxListProvider = StateProvider<List<BlindBoxItem>>((ref) => [
      BlindBoxItem(
        id: 'small',
        name: '小宝箱',
        coinCost: 50,
        themeColor: 0xFF9C27B0, // 紫色
        icon: Icons.inventory_2_outlined,
      ),
      BlindBoxItem(
        id: 'medium',
        name: '中宝箱',
        coinCost: 150,
        themeColor: 0xFFFF6B35, // 金色/橙色
        icon: Icons.card_giftcard,
      ),
      BlindBoxItem(
        id: 'large',
        name: '大宝箱',
        coinCost: 300,
        themeColor: 0xFFF44336, // 红色
        icon: Icons.star_purple500_outlined,
      ),
    ]);

/// 宝箱开启结果
final blindBoxResultProvider = StateProvider<BlindBoxResult?>((ref) => null);

class BlindBoxItem {
  final String id;
  final String name;
  final int coinCost;
  final int themeColor;
  final IconData icon;

  const BlindBoxItem({
    required this.id,
    required this.name,
    required this.coinCost,
    required this.themeColor,
    required this.icon,
  });
}

class BlindBoxResult {
  final String boxId;
  final int rewardCoins;
  final String message;

  const BlindBoxResult({
    required this.boxId,
    required this.rewardCoins,
    required this.message,
  });
}

// ==================== 任务相关 ====================

/// 任务分组
enum TaskGroup { newcomer, daily, achievement }

/// 任务项
class TaskItem {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final int coinReward;
  final int targetValue;
  final int progress;
  final bool completed;
  final bool rewardClaimed;
  final TaskGroup group;

  const TaskItem({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.coinReward,
    required this.targetValue,
    this.progress = 0,
    this.completed = false,
    this.rewardClaimed = false,
    required this.group,
  });

  bool get canClaim => completed && !rewardClaimed;

  double get progressRatio {
    if (targetValue <= 0) return 0.0;
    return (progress / targetValue).clamp(0.0, 1.0);
  }

  TaskItem copyWith({
    int? progress,
    bool? completed,
    bool? rewardClaimed,
  }) {
    return TaskItem(
      id: id,
      name: name,
      description: description,
      icon: icon,
      coinReward: coinReward,
      targetValue: targetValue,
      progress: progress ?? this.progress,
      completed: completed ?? this.completed,
      rewardClaimed: rewardClaimed ?? this.rewardClaimed,
      group: group,
    );
  }
}

/// 任务列表 Provider
final taskListProvider = StateProvider<List<TaskItem>>((ref) => [
      // 新人任务
      TaskItem(
        id: 'new_1',
        name: '完善个人资料',
        description: '设置头像和昵称',
        icon: Icons.person_add_outlined,
        coinReward: 50,
        targetValue: 1,
        progress: 1,
        completed: true,
        rewardClaimed: true,
        group: TaskGroup.newcomer,
      ),
      TaskItem(
        id: 'new_2',
        name: '观看第一部短剧',
        description: '完整观看一集短剧',
        icon: Icons.play_circle_outline,
        coinReward: 30,
        targetValue: 1,
        progress: 1,
        completed: true,
        rewardClaimed: false,
        group: TaskGroup.newcomer,
      ),
      TaskItem(
        id: 'new_3',
        name: '首次分享',
        description: '分享一部短剧给好友',
        icon: Icons.share_outlined,
        coinReward: 40,
        targetValue: 1,
        progress: 0,
        completed: false,
        rewardClaimed: false,
        group: TaskGroup.newcomer,
      ),
      // 日常任务
      TaskItem(
        id: 'daily_1',
        name: '每日签到',
        description: '每天签到领取金币',
        icon: Icons.today,
        coinReward: 10,
        targetValue: 1,
        progress: 1,
        completed: true,
        rewardClaimed: true,
        group: TaskGroup.daily,
      ),
      TaskItem(
        id: 'daily_2',
        name: '观看3集短剧',
        description: '今日观看3集短剧',
        icon: Icons.tv,
        coinReward: 20,
        targetValue: 3,
        progress: 1,
        completed: false,
        rewardClaimed: false,
        group: TaskGroup.daily,
      ),
      TaskItem(
        id: 'daily_3',
        name: '看1个广告',
        description: '观看广告获得金币',
        icon: Icons.ad_units_outlined,
        coinReward: 15,
        targetValue: 1,
        progress: 0,
        completed: false,
        rewardClaimed: false,
        group: TaskGroup.daily,
      ),
      TaskItem(
        id: 'daily_4',
        name: '评论1条',
        description: '对任意短剧发表评论',
        icon: Icons.comment_outlined,
        coinReward: 10,
        targetValue: 1,
        progress: 0,
        completed: false,
        rewardClaimed: false,
        group: TaskGroup.daily,
      ),
      // 成就任务
      TaskItem(
        id: 'ach_1',
        name: '累计观看100集',
        description: '累计观看100集短剧',
        icon: Icons.emoji_events_outlined,
        coinReward: 200,
        targetValue: 100,
        progress: 42,
        completed: false,
        rewardClaimed: false,
        group: TaskGroup.achievement,
      ),
      TaskItem(
        id: 'ach_2',
        name: '连续签到7天',
        description: '连续7天签到',
        icon: Icons.local_fire_department_outlined,
        coinReward: 100,
        targetValue: 7,
        progress: 3,
        completed: false,
        rewardClaimed: false,
        group: TaskGroup.achievement,
      ),
      TaskItem(
        id: 'ach_3',
        name: '邀请5位好友',
        description: '成功邀请5位好友注册',
        icon: Icons.group_add_outlined,
        coinReward: 300,
        targetValue: 5,
        progress: 1,
        completed: false,
        rewardClaimed: false,
        group: TaskGroup.achievement,
      ),
    ]);

/// 任务分组标题
String taskGroupTitle(TaskGroup group) {
  switch (group) {
    case TaskGroup.newcomer:
      return '新人任务';
    case TaskGroup.daily:
      return '日常任务';
    case TaskGroup.achievement:
      return '成就任务';
  }
}

/// 任务分组图标
IconData taskGroupIcon(TaskGroup group) {
  switch (group) {
    case TaskGroup.newcomer:
      return Icons.star_outline;
    case TaskGroup.daily:
      return Icons.calendar_today_outlined;
    case TaskGroup.achievement:
      return Icons.military_tech_outlined;
  }
}
