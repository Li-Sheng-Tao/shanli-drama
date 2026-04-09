import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../models/drama.dart';
import '../../models/comment.dart';
import 'explore_provider.dart';

/// 剧集详情页
class DramaDetailPage extends ConsumerStatefulWidget {
  final String dramaId;

  const DramaDetailPage({
    super.key,
    required this.dramaId,
  });

  @override
  ConsumerState<DramaDetailPage> createState() => _DramaDetailPageState();
}

class _DramaDetailPageState extends ConsumerState<DramaDetailPage> {
  bool _isDescriptionExpanded = false;
  bool _isFavorited = false;
  bool _isSubscribed = false;
  int _selectedEpisode = 0;
  final TextEditingController _commentController = TextEditingController();

  /// Mock 剧集数据
  Drama get _mockDrama {
    final allDramas = ref.read(exploreRecommendDramasProvider);
    return allDramas.firstWhere(
      (d) => d.id == widget.dramaId,
      orElse: () => allDramas.first,
    );
  }

  /// Mock 评论数据
  List<Comment> get _mockComments {
    return [
      const Comment(
        id: 'c1',
        userId: 'u1',
        nickname: '剧迷小王',
        avatar: '',
        content: '太好看了！每天都在追，根本停不下来！',
        likeCount: 256,
        createdAt: '2024-01-15 10:30',
      ),
      const Comment(
        id: 'c2',
        userId: 'u2',
        nickname: '追剧达人',
        avatar: '',
        content: '剧情太上头了，男主太帅了！',
        likeCount: 189,
        createdAt: '2024-01-14 22:15',
      ),
      const Comment(
        id: 'c3',
        userId: 'u3',
        nickname: '影视评论员',
        avatar: '',
        content: '演员演技在线，剧情紧凑不拖沓，推荐！',
        likeCount: 342,
        createdAt: '2024-01-14 18:45',
      ),
      const Comment(
        id: 'c4',
        userId: 'u4',
        nickname: '甜宠爱好者',
        avatar: '',
        content: '又甜又虐，看得我哭了好几次',
        likeCount: 128,
        createdAt: '2024-01-13 20:00',
      ),
      const Comment(
        id: 'c5',
        userId: 'u5',
        nickname: '新入坑的',
        avatar: '',
        content: '刚发现这部剧，一口气看了10集！',
        likeCount: 95,
        createdAt: '2024-01-13 15:30',
      ),
    ];
  }

  /// 格式化数字
  String _formatCount(int count) {
    if (count >= 10000) {
      return '${(count / 10000).toStringAsFixed(1)}w';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final drama = _mockDrama;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: CustomScrollView(
        slivers: [
          // 顶部封面区域
          _buildCoverSliver(drama),

          // 剧集信息内容
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 基本信息
                  _buildBasicInfo(drama),

                  // 操作按钮行
                  _buildActionButtons(drama),

                  // 剧情介绍
                  _buildDescription(drama),

                  // 选集区域
                  _buildEpisodeSelector(drama),

                  // 评论区
                  _buildCommentSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 顶部封面区域
  Widget _buildCoverSliver(Drama drama) {
    return SliverAppBar(
      expandedHeight: 320.h,
      pinned: true,
      backgroundColor: AppColors.backgroundDark,
      leading: GestureDetector(
        onTap: () => context.pop(),
        child: Container(
          margin: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 22.r,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            // TODO: 分享功能
          },
          child: Container(
            margin: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.share,
              color: Colors.white,
              size: 20.r,
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // 封面背景
            Container(
              color: AppColors.backgroundDark,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 140.r,
                      height: 190.r,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.movie,
                              size: 48.r,
                              color: Colors.white54,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              drama.title,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white54,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 渐变遮罩
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 120.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.white,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 基本信息
  Widget _buildBasicInfo(Drama drama) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题行
          Row(
            children: [
              Expanded(
                child: Text(
                  drama.title,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // 评分
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16.r,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '9.${drama.id.hashCode % 10}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // 分类标签 + 状态
          Row(
            children: [
              ...drama.tags.map((tag) => Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: _buildPillTag(tag),
                  )),
              SizedBox(width: 4.w),
              // 状态标签
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: drama.status == 'ongoing'
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  drama.status == 'ongoing' ? '连载中' : '已完结',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: drama.status == 'ongoing'
                        ? AppColors.primary
                        : AppColors.success,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (drama.isExclusive) ...[
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '独播',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),

          SizedBox(height: 8.h),

          // 播放量等数据
          Row(
            children: [
              Icon(Icons.play_circle_outline, size: 14.r, color: AppColors.textHint),
              SizedBox(width: 4.w),
              Text(
                '${_formatCount(drama.playCount)}次播放',
                style: TextStyle(fontSize: 12.sp, color: AppColors.textHint),
              ),
              SizedBox(width: 16.w),
              Icon(Icons.favorite_outline, size: 14.r, color: AppColors.textHint),
              SizedBox(width: 4.w),
              Text(
                '${_formatCount(drama.collectCount)}收藏',
                style: TextStyle(fontSize: 12.sp, color: AppColors.textHint),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 操作按钮行
  Widget _buildActionButtons(Drama drama) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          // 收藏按钮
          GestureDetector(
            onTap: () => setState(() => _isFavorited = !_isFavorited),
            child: Container(
              width: 52.r,
              height: 44.h,
              decoration: BoxDecoration(
                color: _isFavorited
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isFavorited ? Icons.favorite : Icons.favorite_border,
                    size: 20.r,
                    color: _isFavorited ? AppColors.primary : AppColors.textSecondary,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '收藏',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: _isFavorited ? AppColors.primary : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: 10.w),

          // 预约按钮
          GestureDetector(
            onTap: () => setState(() => _isSubscribed = !_isSubscribed),
            child: Container(
              width: 52.r,
              height: 44.h,
              decoration: BoxDecoration(
                color: _isSubscribed
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isSubscribed ? Icons.notifications_active : Icons.notifications_outlined,
                    size: 20.r,
                    color: _isSubscribed ? AppColors.primary : AppColors.textSecondary,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    _isSubscribed ? '已预约' : '预约',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: _isSubscribed ? AppColors.primary : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: 10.w),

          // 开始播放按钮（主按钮）
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.push('/play/${drama.id}/1');
              },
              child: Container(
                height: 44.h,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(22.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_arrow, size: 22.r, color: Colors.white),
                    SizedBox(width: 4.w),
                    Text(
                      '开始播放',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 剧情介绍
  Widget _buildDescription(Drama drama) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '剧情介绍',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () => setState(() => _isDescriptionExpanded = !_isDescriptionExpanded),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  drama.description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                  maxLines: _isDescriptionExpanded ? null : 3,
                  overflow: _isDescriptionExpanded
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isDescriptionExpanded ? '收起' : '展开查看更多',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.primary,
                      ),
                    ),
                    Icon(
                      _isDescriptionExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 16.r,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 选集区域
  Widget _buildEpisodeSelector(Drama drama) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '选集',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Text(
                '共${drama.episodeCount}集',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: drama.episodeCount,
              itemBuilder: (context, index) {
                final isSelected = index == _selectedEpisode;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedEpisode = index);
                  },
                  child: Container(
                    width: 48.r,
                    height: 36.h,
                    margin: EdgeInsets.only(right: 8.w),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8.r),
                      border: isSelected
                          ? null
                          : Border.all(
                              color: const Color(0xFFE0E0E0),
                              width: 0.5,
                            ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$index',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: isSelected
                            ? Colors.white
                            : AppColors.textPrimary,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8.h),
          // 付费提示
          if (drama.episodeCount > 2)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                '前2集免费，后续每集10金币',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textHint,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// 评论区
  Widget _buildCommentSection() {
    final comments = _mockComments;

    return Container(
      margin: EdgeInsets.only(top: 16.h),
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 评论区标题
          Row(
            children: [
              Text(
                '评论',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '(${comments.length})',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // 评论列表
          ...comments.map((comment) => _buildCommentItem(comment)),

          SizedBox(height: 12.h),

          // 发表评论输入框
          _buildCommentInput(),

          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  /// 评论项
  Widget _buildCommentItem(Comment comment) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头像
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E8),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              size: 18.r,
              color: AppColors.textHint,
            ),
          ),

          SizedBox(width: 10.w),

          // 评论内容
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 昵称 + 时间
                Row(
                  children: [
                    Text(
                      comment.nickname,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      comment.createdAt,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 4.h),

                // 评论文字
                Text(
                  comment.content,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),

                SizedBox(height: 4.h),

                // 点赞
                Row(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 14.r,
                      color: AppColors.textHint,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${comment.likeCount}',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textHint,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      '回复',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 发表评论输入框
  Widget _buildCommentInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      height: 44.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: '发表评论...',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textHint,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10.h),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // TODO: 发送评论
              if (_commentController.text.isNotEmpty) {
                _commentController.clear();
                FocusScope.of(context).unfocus();
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                '发送',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 胶囊标签
  Widget _buildPillTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
