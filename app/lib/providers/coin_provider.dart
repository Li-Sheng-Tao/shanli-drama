import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/coin_transaction.dart';
import '../repositories/coin_repository.dart';

/// 金币余额
final coinBalanceProvider = StateProvider<int>((ref) => 0);

/// 金币交易记录
final coinTransactionsProvider =
    FutureProvider<List<CoinTransaction>>((ref) async {
  return CoinRepository.instance.getTransactions();
});

class CoinNotifier extends StateNotifier<int> {
  CoinNotifier() : super(0) {
    _loadBalance();
  }

  Future<void> _loadBalance() async {
    final balance = await CoinRepository.instance.getBalance();
    state = balance;
  }

  /// 刷新余额
  Future<void> refreshBalance() async {
    await _loadBalance();
  }

  /// 增加金币
  void addCoin(int amount) {
    state += amount;
  }

  /// 减少金币
  bool deductCoin(int amount) {
    if (state >= amount) {
      state -= amount;
      return true;
    }
    return false;
  }
}

final coinNotifierProvider = StateNotifierProvider<CoinNotifier, int>(
  (ref) => CoinNotifier(),
);
