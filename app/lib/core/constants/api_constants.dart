class ApiConstants {
  ApiConstants._();

  // 基础URL（根据环境切换）
  static const String baseUrlDev = 'https://dev-api.shanli.drama.com';
  static const String baseUrlProd = 'https://api.shanli.drama.com';

  // 当前使用的基础URL
  static const String baseUrl = baseUrlDev;

  // API 路径
  static const String loginByPhone = '/api/v1/auth/login/phone';
  static const String loginByWechat = '/api/v1/auth/login/wechat';
  static const String sendSmsCode = '/api/v1/auth/sms/code';
  static const String refreshToken = '/api/v1/auth/token/refresh';
  static const String logout = '/api/v1/auth/logout';

  static const String userProfile = '/api/v1/user/profile';
  static const String updateUserProfile = '/api/v1/user/profile';

  static const String dramaList = '/api/v1/drama/list';
  static const String dramaDetail = '/api/v1/drama/detail';
  static const String dramaSearch = '/api/v1/drama/search';
  static const String dramaRanking = '/api/v1/drama/ranking';
  static const String dramaCalendar = '/api/v1/drama/calendar';

  static const String episodeList = '/api/v1/drama/episodes';
  static const String episodePlayUrl = '/api/v1/drama/play-url';

  static const String commentList = '/api/v1/comment/list';
  static const String commentCreate = '/api/v1/comment/create';
  static const String commentLike = '/api/v1/comment/like';

  static const String coinBalance = '/api/v1/coin/balance';
  static const String coinTransactions = '/api/v1/coin/transactions';

  static const String dailyTasks = '/api/v1/task/daily';
  static const String taskClaim = '/api/v1/task/claim';
  static const String checkin = '/api/v1/task/checkin';

  static const String vipPlans = '/api/v1/vip/plans';
  static const String vipPurchase = '/api/v1/vip/purchase';
  static const String vipStatus = '/api/v1/vip/status';

  static const String blindBoxList = '/api/v1/blind-box/list';
  static const String blindBoxOpen = '/api/v1/blind-box/open';

  // 分页
  static const int defaultPageSize = 20;

  // 超时
  static const int connectTimeout = 15000; // 15秒
  static const int receiveTimeout = 15000; // 15秒
  static const int sendTimeout = 15000; // 15秒
}
