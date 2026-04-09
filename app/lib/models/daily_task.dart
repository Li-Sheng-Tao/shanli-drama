import 'package:json_annotation/json_annotation.dart';

part 'daily_task.g.dart';

@JsonSerializable()
class DailyTask {
  final String id;
  @JsonKey(name: 'task_key')
  final String taskKey;
  @JsonKey(name: 'task_name')
  final String taskName;
  final String description;
  @JsonKey(name: 'coin_reward')
  final int coinReward;
  @JsonKey(name: 'target_value')
  final int targetValue;
  final int progress;
  final bool completed;
  @JsonKey(name: 'reward_claimed')
  final bool rewardClaimed;

  const DailyTask({
    required this.id,
    required this.taskKey,
    required this.taskName,
    required this.description,
    required this.coinReward,
    required this.targetValue,
    this.progress = 0,
    this.completed = false,
    this.rewardClaimed = false,
  });

  /// 是否可以领取奖励
  bool get canClaim => completed && !rewardClaimed;

  /// 进度比例 (0.0 ~ 1.0)
  double get progressRatio {
    if (targetValue <= 0) return 0.0;
    return (progress / targetValue).clamp(0.0, 1.0);
  }

  factory DailyTask.fromJson(Map<String, dynamic> json) =>
      _$DailyTaskFromJson(json);

  Map<String, dynamic> toJson() => _$DailyTaskToJson(this);

  DailyTask copyWith({
    String? id,
    String? taskKey,
    String? taskName,
    String? description,
    int? coinReward,
    int? targetValue,
    int? progress,
    bool? completed,
    bool? rewardClaimed,
  }) {
    return DailyTask(
      id: id ?? this.id,
      taskKey: taskKey ?? this.taskKey,
      taskName: taskName ?? this.taskName,
      description: description ?? this.description,
      coinReward: coinReward ?? this.coinReward,
      targetValue: targetValue ?? this.targetValue,
      progress: progress ?? this.progress,
      completed: completed ?? this.completed,
      rewardClaimed: rewardClaimed ?? this.rewardClaimed,
    );
  }
}
