import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/daily_task.dart';

/// 每日任务列表
final dailyTasksProvider = StateProvider<List<DailyTask>>((ref) => []);

/// 签到状态
final checkinProvider = StateProvider<bool>((ref) => false);

/// 签到天数
final checkinDaysProvider = StateProvider<int>((ref) => 0);

class TaskNotifier extends StateNotifier<List<DailyTask>> {
  TaskNotifier() : super([]);

  /// 加载任务列表
  Future<void> loadTasks() async {
    // TODO: 从 API 加载每日任务
  }

  /// 更新任务进度
  void updateProgress(String taskKey, int progress) {
    state = state.map((task) {
      if (task.taskKey == taskKey) {
        return task.copyWith(
          progress: progress,
          completed: progress >= task.targetValue,
        );
      }
      return task;
    }).toList();
  }

  /// 领取奖励
  void claimReward(String taskId) {
    state = state.map((task) {
      if (task.id == taskId) {
        return task.copyWith(rewardClaimed: true);
      }
      return task;
    }).toList();
  }
}

final taskNotifierProvider = StateNotifierProvider<TaskNotifier, List<DailyTask>>(
  (ref) => TaskNotifier(),
);
