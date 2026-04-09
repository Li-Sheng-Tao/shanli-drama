import 'package:json_annotation/json_annotation.dart';

part 'vip_order.g.dart';

@JsonSerializable()
class VipOrder {
  final String id;
  @JsonKey(name: 'order_no')
  final String orderNo;
  @JsonKey(name: 'plan_type')
  final String planType;
  final int amount;
  @JsonKey(name: 'pay_status')
  final String payStatus;

  const VipOrder({
    required this.id,
    required this.orderNo,
    required this.planType,
    required this.amount,
    required this.payStatus,
  });

  /// 套餐文本
  String get planTypeText {
    switch (planType) {
      case 'monthly':
        return '月度会员';
      case 'quarterly':
        return '季度会员';
      case 'yearly':
        return '年度会员';
      case 'lifetime':
        return '终身会员';
      default:
        return planType;
    }
  }

  /// 支付状态文本
  String get payStatusText {
    switch (payStatus) {
      case 'pending':
        return '待支付';
      case 'paid':
        return '已支付';
      case 'failed':
        return '支付失败';
      case 'cancelled':
        return '已取消';
      default:
        return payStatus;
    }
  }

  /// 是否已支付
  bool get isPaid => payStatus == 'paid';

  factory VipOrder.fromJson(Map<String, dynamic> json) =>
      _$VipOrderFromJson(json);

  Map<String, dynamic> toJson() => _$VipOrderToJson(this);
}
