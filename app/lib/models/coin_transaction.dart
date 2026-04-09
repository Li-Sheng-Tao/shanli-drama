import 'package:json_annotation/json_annotation.dart';

part 'coin_transaction.g.dart';

@JsonSerializable()
class CoinTransaction {
  final String id;
  final String type;
  final int amount;
  @JsonKey(name: 'balance_after')
  final int balanceAfter;
  final String description;
  @JsonKey(name: 'created_at')
  final String createdAt;

  const CoinTransaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.balanceAfter,
    required this.description,
    required this.createdAt,
  });

  /// 是否为收入
  bool get isIncome => amount > 0;

  /// 类型文本
  String get typeText {
    switch (type) {
      case 'watch_ad':
        return '看广告奖励';
      case 'daily_checkin':
        return '每日签到';
      case 'task_reward':
        return '任务奖励';
      case 'watch_episode':
        return '观看剧集';
      case 'blind_box':
        return '盲盒抽奖';
      case 'vip_purchase':
        return 'VIP购买';
      case 'recharge':
        return '充值';
      case 'system':
        return '系统调整';
      default:
        return type;
    }
  }

  factory CoinTransaction.fromJson(Map<String, dynamic> json) =>
      _$CoinTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$CoinTransactionToJson(this);
}
