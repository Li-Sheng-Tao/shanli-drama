import '../models/coin_transaction.dart';

class CoinRepository {
  CoinRepository._();
  static final CoinRepository instance = CoinRepository._();

  /// 获取金币余额
  Future<int> getBalance() async {
    try {
      // TODO: 调用实际 API
      // final response = await DioClient.instance.get(
      //   ApiConstants.coinBalance,
      // );
      return 0;
    } catch (e) {
      return 0;
    }
  }

  /// 获取交易记录
  Future<List<CoinTransaction>> getTransactions({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      // TODO: 调用实际 API
      // final response = await DioClient.instance.get(
      //   ApiConstants.coinTransactions,
      //   queryParameters: {'page': page, 'page_size': pageSize},
      // );
      return [];
    } catch (e) {
      return [];
    }
  }

  /// 消费金币
  Future<bool> spendCoin(int amount, String reason) async {
    try {
      // TODO: 调用实际 API
      return true;
    } catch (e) {
      return false;
    }
  }
}
