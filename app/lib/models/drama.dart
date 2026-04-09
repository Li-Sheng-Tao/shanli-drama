import 'package:json_annotation/json_annotation.dart';

part 'drama.g.dart';

@JsonSerializable()
class Drama {
  final String id;
  final String title;
  @JsonKey(name: 'cover_url')
  final String coverUrl;
  final String description;
  final String genre;
  final List<String> tags;
  @JsonKey(name: 'episode_count')
  final int episodeCount;
  final String status;
  @JsonKey(name: 'is_exclusive')
  final bool isExclusive;
  @JsonKey(name: 'is_new')
  final bool isNew;
  @JsonKey(name: 'play_count')
  final int playCount;
  @JsonKey(name: 'collect_count')
  final int collectCount;

  const Drama({
    required this.id,
    required this.title,
    required this.coverUrl,
    this.description = '',
    this.genre = '',
    this.tags = const [],
    this.episodeCount = 0,
    this.status = 'ongoing',
    this.isExclusive = false,
    this.isNew = false,
    this.playCount = 0,
    this.collectCount = 0,
  });

  /// 状态文本
  String get statusText {
    switch (status) {
      case 'ongoing':
        return '连载中';
      case 'completed':
        return '已完结';
      default:
        return '未知';
    }
  }

  factory Drama.fromJson(Map<String, dynamic> json) => _$DramaFromJson(json);

  Map<String, dynamic> toJson() => _$DramaToJson(this);

  Drama copyWith({
    String? id,
    String? title,
    String? coverUrl,
    String? description,
    String? genre,
    List<String>? tags,
    int? episodeCount,
    String? status,
    bool? isExclusive,
    bool? isNew,
    int? playCount,
    int? collectCount,
  }) {
    return Drama(
      id: id ?? this.id,
      title: title ?? this.title,
      coverUrl: coverUrl ?? this.coverUrl,
      description: description ?? this.description,
      genre: genre ?? this.genre,
      tags: tags ?? this.tags,
      episodeCount: episodeCount ?? this.episodeCount,
      status: status ?? this.status,
      isExclusive: isExclusive ?? this.isExclusive,
      isNew: isNew ?? this.isNew,
      playCount: playCount ?? this.playCount,
      collectCount: collectCount ?? this.collectCount,
    );
  }
}
