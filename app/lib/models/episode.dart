import 'package:json_annotation/json_annotation.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode {
  final String id;
  @JsonKey(name: 'drama_id')
  final String dramaId;
  @JsonKey(name: 'episode_number')
  final int episodeNumber;
  final String title;
  @JsonKey(name: 'video_url')
  final String videoUrl;
  @JsonKey(name: 'duration_seconds')
  final int durationSeconds;
  @JsonKey(name: 'is_free')
  final bool isFree;
  @JsonKey(name: 'coin_cost')
  final int coinCost;

  const Episode({
    required this.id,
    required this.dramaId,
    required this.episodeNumber,
    required this.title,
    required this.videoUrl,
    required this.durationSeconds,
    this.isFree = true,
    this.coinCost = 0,
  });

  /// 是否需要付费观看
  bool get needPay => !isFree && coinCost > 0;

  /// 时长文本（mm:ss）
  String get durationText {
    final minutes = durationSeconds ~/ 60;
    final seconds = durationSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);

  Episode copyWith({
    String? id,
    String? dramaId,
    int? episodeNumber,
    String? title,
    String? videoUrl,
    int? durationSeconds,
    bool? isFree,
    int? coinCost,
  }) {
    return Episode(
      id: id ?? this.id,
      dramaId: dramaId ?? this.dramaId,
      episodeNumber: episodeNumber ?? this.episodeNumber,
      title: title ?? this.title,
      videoUrl: videoUrl ?? this.videoUrl,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      isFree: isFree ?? this.isFree,
      coinCost: coinCost ?? this.coinCost,
    );
  }
}
