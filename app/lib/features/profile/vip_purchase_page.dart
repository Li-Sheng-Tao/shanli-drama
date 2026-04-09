import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import 'profile_provider.dart';

class VipPurchasePage extends ConsumerStatefulWidget {
  const VipPurchasePage({super.key});

  @override
  ConsumerState<VipPurchasePage> createState() => _VipPurchasePageState();
}

class _VipPurchasePageState extends ConsumerState<VipPurchasePage> {
  @override
  Widget build(BuildContext context) {
    final plans = ref.watch(vipPlansProvider);
    final selectedPlan = ref.watch(selectedVipPlanProvider);
    final selectedPayment = ref.watch(selectedPaymentMethodProvider);
    final benefits = ref.watch(vipBenefitsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF0),
      appBar: AppBar(
        title: const Text('会员中心'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. VIP Banner
            _buildVipBanner(),
            SizedBox(height: 20.h),

            // 2. VIP 权益展示
            _buildBenefits(benefits),
            SizedBox(height: 20.h),

            // 3. 套餐选择
            _buildPlanSection(plans, selectedPlan),
            SizedBox(height: 20.h),

            // 4. 支付方式
            _buildPaymentSection(selectedPayment),
            SizedBox(height: 20.h),

            // 5. 用户协议
            _buildAgreement(),

            SizedBox(height: 16.h),
          ],
        ),
      ),
      // 6. 底部开通按钮
      bottomNavigationBar: _buildBottomButton(selectedPlan),
    );
  }

  /// VIP Banner
  Widget _buildVipBanner() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFFFA000)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.workspace_premium,
            size: 56.sp,
            color: Colors.white,
          ),
          SizedBox(height: 12.h),
          Text(
            'VIP会员',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '全站剧集免费看 · 无广告 · 专属特权',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  /// VIP 权益展示
  Widget _buildBenefits(List<VipBenefit> benefits) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
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
            Text(
              'VIP专属权益',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: List.generate(benefits.length, (index) {
                final benefit = benefits[index];
                return Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 44.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD700).withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          benefit.icon,
                          size: 22.sp,
                          color: const Color(0xFFFFD700),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        benefit.title,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        benefit.description,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// 套餐选择
  Widget _buildPlanSection(List<VipPlan> plans, VipPlan? selectedPlan) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '选择套餐',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          // 套餐网格 (2x2)
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.w,
            childAspectRatio: 1.6,
            children: plans.map((plan) {
              final isSelected = selectedPlan?.type == plan.type;
              return _buildPlanCard(plan, isSelected);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(VipPlan plan, bool isSelected) {
    return GestureDetector(
      onTap: () {
        ref.read(selectedVipPlanProvider.notifier).state = plan;
      },
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.divider,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // 最划算标签
            if (plan.badgeText.isNotEmpty)
              Positioned(
                right: -1,
                top: -1,
                child: Container(
                  padding: EdgeInsets.only(left: 8.w, right: 4.w),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      bottomLeft: Radius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    plan.badgeText,
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  plan.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  plan.description,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 8.h),
                // 价格
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\u00A5',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '${plan.price ~/ 100}',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '.${plan.price % 100}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  '\u00A5${plan.originalPrice ~/ 100}.${plan.originalPrice % 100}',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.textHint,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 支付方式
  Widget _buildPaymentSection(PaymentMethod selectedPayment) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '支付方式',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
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
              children: [
                _buildPaymentOption(
                  icon: Icons.wechat_outlined,
                  title: '微信支付',
                  color: const Color(0xFF07C160),
                  isSelected: selectedPayment == PaymentMethod.wechat,
                  onTap: () {
                    ref.read(selectedPaymentMethodProvider.notifier).state =
                        PaymentMethod.wechat;
                  },
                ),
                Divider(height: 0.5, indent: 52.w, color: AppColors.divider),
                _buildPaymentOption(
                  icon: Icons.account_balance_wallet_outlined,
                  title: '支付宝',
                  color: const Color(0xFF1677FF),
                  isSelected: selectedPayment == PaymentMethod.alipay,
                  onTap: () {
                    ref.read(selectedPaymentMethodProvider.notifier).state =
                        PaymentMethod.alipay;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String title,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: color, size: 22.sp),
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 22.sp,
              )
            else
              Icon(
                Icons.radio_button_unchecked,
                color: AppColors.textHint,
                size: 22.sp,
              ),
          ],
        ),
      ),
    );
  }

  /// 用户协议
  Widget _buildAgreement() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '开通即表示同意',
              style: TextStyle(
                fontSize: 11.sp,
                color: AppColors.textHint,
              ),
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('用户协议 - 功能开发中'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: Text(
                '《用户协议》',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppColors.primary,
                ),
              ),
            ),
            Text(
              '和',
              style: TextStyle(
                fontSize: 11.sp,
                color: AppColors.textHint,
              ),
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('隐私政策 - 功能开发中'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: Text(
                '《隐私政策》',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 底部开通按钮
  Widget _buildBottomButton(VipPlan? selectedPlan) {
    final priceText = selectedPlan != null
        ? '\u00A5${selectedPlan.price ~/ 100}.${selectedPlan.price % 100}'
        : '请选择套餐';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            onPressed: selectedPlan != null
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('正在发起支付 $priceText'),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              disabledBackgroundColor: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
              elevation: 0,
            ),
            child: Text(
              selectedPlan != null ? '立即开通 $priceText' : '请选择套餐',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: selectedPlan != null
                    ? Colors.white
                    : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
