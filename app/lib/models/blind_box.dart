import 'package:json_annotation/json_annotation.dart';

part 'blind_box.g.dart';

@JsonSerializable()
class BlindBox {
  final String id;
  @JsonKey(name: 'box_name')
  final String boxName;
  @JsonKey(name: 'box_type')
  final String boxType;
  @JsonKey(name: 'coin_cost')
  final int coinCost;

  const BlindBox({
    required this.id,
    required this.boxName,
    required this.boxType,
    required this.coinCost,
  });

  /// 盲盒类型文本
  String get boxTypeText {
    switch (boxType) {
      case 'normal':
        return '普通盲盒';
      case 'silver':
        return '白银盲盒';
      case 'gold':
        return '黄金盲盒';
      case 'diamond':
        return '钻石盲盒';
      default:
        return boxType;
    }
  }

  factory BlindBox.fromJson(Map<String, dynamic> json) =>
      _$BlindBoxFromJson(json);

  Map<String, dynamic> toJson() => _$BlindBoxToJson(this);
}
