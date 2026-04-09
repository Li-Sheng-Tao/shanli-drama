import 'package:flutter_riverpod/flutter_riverpod.dart';

/// VIP 状态
final vipStatusProvider = StateProvider<bool>((ref) => false);

/// VIP 等级
final vipLevelProvider = StateProvider<int>((ref) => 0);

/// VIP 到期时间
final vipExpireAtProvider = StateProvider<String?>((ref) => null);

/// VIP 套餐列表
final vipPlansProvider = StateProvider<List<VipPlan>>((ref) => [
      VipPlan(
        planType: 'monthly',
        name: '月度会员',
        price: 30,
        originalPrice: 50,
        description: '30天VIP权益',
      ),
      VipPlan(
        planType: 'quarterly',
        name: '季度会员',
        price: 78,
        originalPrice: 150,
        description: '90天VIP权益',
      ),
      VipPlan(
        planType: 'yearly',
        name: '年度会员',
        price: 198,
        originalPrice: 600,
        description: '365天VIP权益',
      ),
    ]);

class VipPlan {
  final String planType;
  final String name;
  final int price;
  final int originalPrice;
  final String description;

  const VipPlan({
    required this.planType,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.description,
  });

  /// 折扣
  double get discount => price / originalPrice;
}
