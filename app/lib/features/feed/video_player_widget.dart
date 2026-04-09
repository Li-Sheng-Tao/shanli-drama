import 'package:flutter/material.dart';

class VideoPlayerWidget extends StatelessWidget {
  final String videoUrl;
  final bool autoPlay;
  final bool looping;
  final VoidCallback? onCompleted;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    this.autoPlay = true,
    this.looping = false,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: 集成 video_player + chewie 实现视频播放
    return Container(
      color: Colors.black,
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.play_circle_outline,
              size: 64,
              color: Colors.white54,
            ),
            SizedBox(height: 8),
            Text(
              '视频播放器',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
