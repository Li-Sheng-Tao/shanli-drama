import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  final String nickname;
  final String avatar;
  final String content;
  @JsonKey(name: 'like_count')
  final int likeCount;
  @JsonKey(name: 'created_at')
  final String createdAt;

  const Comment({
    required this.id,
    required this.userId,
    required this.nickname,
    required this.avatar,
    required this.content,
    this.likeCount = 0,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  Comment copyWith({
    String? id,
    String? userId,
    String? nickname,
    String? avatar,
    String? content,
    int? likeCount,
    String? createdAt,
  }) {
    return Comment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      nickname: nickname ?? this.nickname,
      avatar: avatar ?? this.avatar,
      content: content ?? this.content,
      likeCount: likeCount ?? this.likeCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
