import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class RankingsPage extends StatelessWidget {
  const RankingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('排行榜'),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: '热播榜'),
                Tab(text: '好评榜'),
                Tab(text: '新剧榜'),
              ],
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildRankingList('热播榜'),
                  _buildRankingList('好评榜'),
                  _buildRankingList('新剧榜'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankingList(String title) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.leaderboard,
            size: 64,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            '$title - 排行列表',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
