import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import 'welfare_provider.dart';

class BlindBoxWidget extends ConsumerStatefulWidget {
  const BlindBoxWidget({super.key});

  @override
  ConsumerState<BlindBoxWidget> createState() => _BlindBoxWidgetState();
}

class _BlindBoxWidgetState extends ConsumerState<BlindBoxWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _openController;
  late Animation<double> _scaleAnimation;
  BlindBoxItem? _openingBox;

  @override
  void initState() {
    super.initState();
    _openController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.8), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.8, end: 1.2), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(
      parent: _openController,
      curve: Curves.easeInOut,
    ));

    _openController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _showResult();
      }
    });
  }

  @override
  void dispose() {
    _openController.dispose();
    super.dispose();
  }

  void _showResult() {
    if (_openingBox == null) return;

    // 模拟随机奖励
    final randomReward = (_openingBox!.coinCost ~/ 2) +
        (DateTime.now().millisecond % (_openingBox!.coinCost ~/ 2));
    final messages = [
      '恭喜获得 $randomReward 山狸币！',
      '运气不错！获得 $randomReward 山狸币！',
      '太棒了！获得 $randomReward 山狸币！',
    ];

    ref.read(blindBoxResultProvider.notifier).state = BlindBoxResult(
      boxId: _openingBox!.id,
      rewardCoins: randomReward,
      message: messages[DateTime.now().millisecond % 3],
    );

    // 扣除金币
    ref.read(welfareCoinBalanceProvider.notifier).state -= _openingBox!.coinCost;

    _showResultDialog();
    _openingBox = null;
  }

  void _showResultDialog() {
    final result = ref.read(blindBoxResultProvider);
    if (result == null) return;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.card_giftcard,
              size: 64.sp,
              color: AppColors.secondary,
            ),
            SizedBox(height: 16.h),
            Text(
              result.message,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              '金币已到账',
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('好的'),
          ),
        ],
      ),
    );
  }

  Future<void> _openBox(BlindBoxItem box) async {
    final balance = ref.read(welfareCoinBalanceProvider);
    if (balance < box.coinCost) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('金币不足，无法开启'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _openingBox = box);
    await _openController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final boxes = ref.watch(blindBoxListProvider);

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
                Icons.card_giftcard,
                color: AppColors.primary,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                '宝箱盲盒',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Text(
                '试试手气',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // 宝箱列表
          Row(
            children: boxes.map((box) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: boxes.indexOf(box) == 0 ? 0 : 6.w,
                    right:
                        boxes.indexOf(box) == boxes.length - 1 ? 0 : 6.w,
                  ),
                  child: _buildBoxCard(box),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBoxCard(BlindBoxItem box) {
    final themeColor = Color(box.themeColor);
    final isOpening = _openingBox?.id == box.id;
    final balance = ref.watch(welfareCoinBalanceProvider);
    final canAfford = balance >= box.coinCost;

    return AnimatedBuilder(
      animation: isOpening ? _scaleAnimation : const AlwaysStoppedAnimation(1.0),
      builder: (context, child) {
        final scale = isOpening ? _scaleAnimation.value : 1.0;
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: GestureDetector(
        onTap: isOpening ? null : () => _openBox(box),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                themeColor.withValues(alpha: 0.15),
                themeColor.withValues(alpha: 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: themeColor.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            children: [
              // 宝箱图标
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: themeColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  box.icon,
                  size: 28.sp,
                  color: themeColor,
                ),
              ),
              SizedBox(height: 8.h),
              // 名称
              Text(
                box.name,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: themeColor,
                ),
              ),
              SizedBox(height: 4.h),
              // 所需金币
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.monetization_on,
                    size: 14.sp,
                    color: canAfford
                        ? AppColors.secondary
                        : AppColors.textHint,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    '${box.coinCost}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: canAfford
                          ? AppColors.secondary
                          : AppColors.textHint,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              // 开启按钮
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: canAfford ? themeColor : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  isOpening ? '开启中...' : '开启',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: canAfford ? Colors.white : AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// AnimatedBuilder 复用 (与 checkin_widget 中相同)
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
    return _AnimatedBuilderImpl(
      listenable: animation,
      builder: builder,
      child: child,
    );
  }
}

class _AnimatedBuilderImpl extends AnimatedWidget {
  final Widget Function(BuildContext context, Widget? child) builder;
  final Widget? child;

  const _AnimatedBuilderImpl({
    required super.listenable,
    required this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return builder(context, child);
  }
}
