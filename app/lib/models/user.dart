import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String nickname;
  final String avatar;
  @JsonKey(name: 'vip_level')
  final int vipLevel;
  @JsonKey(name: 'vip_expire_at')
  final String? vipExpireAt;
  @JsonKey(name: 'coin_balance')
  final int coinBalance;
  @JsonKey(name: 'total_watch_seconds')
  final int totalWatchSeconds;

  const User({
    required this.id,
    required this.nickname,
    required this.avatar,
    this.vipLevel = 0,
    this.vipExpireAt,
    this.coinBalance = 0,
    this.totalWatchSeconds = 0,
  });

  bool get isVip => vipLevel > 0 &&
      vipExpireAt != null &&
      DateTime.parse(vipExpireAt!).isAfter(DateTime.now());

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? nickname,
    String? avatar,
    int? vipLevel,
    String? vipExpireAt,
    int? coinBalance,
    int? totalWatchSeconds,
  }) {
    return User(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      avatar: avatar ?? this.avatar,
      vipLevel: vipLevel ?? this.vipLevel,
      vipExpireAt: vipExpireAt ?? this.vipExpireAt,
      coinBalance: coinBalance ?? this.coinBalance,
      totalWatchSeconds: totalWatchSeconds ?? this.totalWatchSeconds,
    );
  }
}
