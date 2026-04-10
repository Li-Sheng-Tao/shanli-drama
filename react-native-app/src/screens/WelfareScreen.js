import React from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView } from 'react-native';
import { Ionicons } from '@expo/vector-icons';

const WelfareScreen = () => {
  // 模拟用户数据
  const userData = {
    coins: 1888
  };

  const taskTypes = [
    {
      title: '新人任务',
      icon: 'star',
      tasks: [
        {
          id: '1',
          title: '签到1-7天',
          reward: '100金币',
          status: '进行中',
          progress: '3/7'
        },
        {
          id: '2',
          title: '首次收藏',
          reward: '50金币',
          status: '未完成'
        }
      ]
    },
    {
      title: '日常任务',
      icon: 'today',
      tasks: [
        {
          id: '3',
          title: '签到',
          reward: '20金币',
          status: '已完成'
        },
        {
          id: '4',
          title: '预约剧集',
          reward: '30金币',
          status: '未完成'
        },
        {
          id: '5',
          title: '观看时长',
          reward: '50金币',
          status: '进行中',
          progress: '15/30分钟'
        },
        {
          id: '6',
          title: '分享剧集',
          reward: '40金币',
          status: '未完成'
        }
      ]
    },
    {
      title: '成就任务',
      icon: 'trophy',
      tasks: [
        {
          id: '7',
          title: '首次登录',
          reward: '100金币',
          status: '已完成'
        },
        {
          id: '8',
          title: '看一部完整剧',
          reward: '200金币',
          status: '未完成'
        },
        {
          id: '9',
          title: '连续3天看剧',
          reward: '150金币',
          status: '进行中',
          progress: '2/3天'
        }
      ]
    }
  ];

  return (
    <ScrollView style={styles.container}>
      {/* 顶部金币区域 */}
      <View style={styles.coinSection}>
        <View style={styles.coinInfo}>
          <Text style={styles.coinTitle}>我的山狸币</Text>
          <View style={styles.coinAmountContainer}>
            <Ionicons name="star" size={24} color="#FFD700" />
            <Text style={styles.coinAmount}>{userData.coins}</Text>
          </View>
          <Text style={styles.coinRule}>X山狸币=可解锁（不可去广告）</Text>
        </View>
        <TouchableOpacity style={styles.exchangeButton}>
          <Text style={styles.exchangeButtonText}>去兑换</Text>
        </TouchableOpacity>
      </View>

      {/* 看剧引导 */}
      <View style={styles.guideSection}>
        <Text style={styles.guideTitle}>看漫剧得山狸币</Text>
        <TouchableOpacity style={styles.guideButton}>
          <Text style={styles.guideButtonText}>去看剧</Text>
        </TouchableOpacity>
      </View>

      {/* 宝箱盲盒活动 */}
      <View style={styles.boxSection}>
        <Text style={styles.boxTitle}>宝箱盲盒活动</Text>
        <Text style={styles.boxDesc}>解锁宝箱盲盒爆好礼</Text>
        <View style={styles.boxRewards}>
          <View style={styles.boxRewardItem}>
            <Ionicons name="star" size={24} color="#FFD700" />
            <Text style={styles.boxRewardText}>金币</Text>
          </View>
          <View style={styles.boxRewardItem}>
            <Ionicons name="ribbon" size={24} color="#FF69B4" />
            <Text style={styles.boxRewardText}>周会员</Text>
          </View>
          <View style={styles.boxRewardItem}>
            <Ionicons name="gift" size={24} color="#32CD32" />
            <Text style={styles.boxRewardText}>好礼</Text>
          </View>
          <View style={styles.boxRewardItem}>
            <Ionicons name="cash" size={24} color="#FFA500" />
            <Text style={styles.boxRewardText}>现金</Text>
          </View>
        </View>
        <TouchableOpacity style={styles.boxButton}>
          <Text style={styles.boxButtonText}>解锁宝箱</Text>
        </TouchableOpacity>
      </View>

      {/* 任务列表 */}
      <View style={styles.taskSection}>
        <Text style={styles.taskSectionTitle}>山狸币任务</Text>
        {taskTypes.map((type, index) => (
          <View key={index} style={styles.taskType}>
            <View style={styles.taskTypeHeader}>
              <Ionicons name={type.icon} size={20} color="#007AFF" />
              <Text style={styles.taskTypeTitle}>{type.title}</Text>
            </View>
            <View style={styles.taskList}>
              {type.tasks.map((task) => (
                <View key={task.id} style={styles.taskItem}>
                  <View style={styles.taskInfo}>
                    <Text style={styles.taskTitle}>{task.title}</Text>
                    {task.progress && (
                      <Text style={styles.taskProgress}>{task.progress}</Text>
                    )}
                  </View>
                  <View style={styles.taskReward}>
                    <Text style={styles.rewardText}>{task.reward}</Text>
                    <TouchableOpacity
                      style={[
                        styles.taskButton,
                        task.status === '已完成' && styles.taskButtonDisabled
                      ]}
                      disabled={task.status === '已完成'}
                    >
                      <Text
                        style={[
                          styles.taskButtonText,
                          task.status === '已完成' && styles.taskButtonTextDisabled
                        ]}
                      >
                        {task.status}
                      </Text>
                    </TouchableOpacity>
                  </View>
                </View>
              ))}
            </View>
          </View>
        ))}
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  coinSection: {
    backgroundColor: '#007AFF',
    padding: 20,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  coinInfo: {
    flex: 1,
  },
  coinTitle: {
    color: '#fff',
    fontSize: 16,
    marginBottom: 8,
  },
  coinAmountContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  coinAmount: {
    color: '#fff',
    fontSize: 24,
    fontWeight: 'bold',
    marginLeft: 8,
  },
  coinRule: {
    color: '#fff',
    fontSize: 12,
    opacity: 0.8,
  },
  exchangeButton: {
    backgroundColor: '#fff',
    paddingHorizontal: 24,
    paddingVertical: 10,
    borderRadius: 20,
  },
  exchangeButtonText: {
    color: '#007AFF',
    fontSize: 14,
    fontWeight: '600',
  },
  guideSection: {
    backgroundColor: '#fff',
    padding: 20,
    marginTop: 10,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  guideTitle: {
    fontSize: 16,
    fontWeight: '600',
  },
  guideButton: {
    backgroundColor: '#007AFF',
    paddingHorizontal: 20,
    paddingVertical: 8,
    borderRadius: 16,
  },
  guideButtonText: {
    color: '#fff',
    fontSize: 14,
    fontWeight: '600',
  },
  boxSection: {
    backgroundColor: '#fff',
    padding: 20,
    marginTop: 10,
  },
  boxTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 4,
  },
  boxDesc: {
    fontSize: 14,
    color: '#666',
    marginBottom: 16,
  },
  boxRewards: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    marginBottom: 20,
  },
  boxRewardItem: {
    alignItems: 'center',
  },
  boxRewardText: {
    marginTop: 8,
    fontSize: 14,
  },
  boxButton: {
    backgroundColor: '#FF69B4',
    paddingVertical: 12,
    borderRadius: 24,
    alignItems: 'center',
  },
  boxButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
  },
  taskSection: {
    marginTop: 10,
    paddingBottom: 20,
  },
  taskSectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginLeft: 16,
    marginBottom: 12,
  },
  taskType: {
    backgroundColor: '#fff',
    marginBottom: 10,
  },
  taskTypeHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  taskTypeTitle: {
    fontSize: 16,
    fontWeight: '600',
    marginLeft: 8,
  },
  taskList: {
    padding: 16,
  },
  taskItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  taskInfo: {
    flex: 1,
  },
  taskTitle: {
    fontSize: 16,
    marginBottom: 4,
  },
  taskProgress: {
    fontSize: 12,
    color: '#666',
  },
  taskReward: {
    alignItems: 'flex-end',
  },
  rewardText: {
    fontSize: 14,
    color: '#FFD700',
    marginBottom: 8,
  },
  taskButton: {
    backgroundColor: '#007AFF',
    paddingHorizontal: 16,
    paddingVertical: 6,
    borderRadius: 12,
  },
  taskButtonDisabled: {
    backgroundColor: '#d1d1d6',
  },
  taskButtonText: {
    color: '#fff',
    fontSize: 12,
    fontWeight: '600',
  },
  taskButtonTextDisabled: {
    color: '#999',
  },
});

export default WelfareScreen;