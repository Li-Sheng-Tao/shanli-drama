import React from 'react';
import { View, Text, StyleSheet, TouchableOpacity, Image } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useNavigation } from '@react-navigation/native';

const PersonalCenterScreen = () => {
  const navigation = useNavigation();

  // 模拟用户数据
  const userData = {
    avatar: 'https://via.placeholder.com/100',
    nickname: '山狸用户',
    userId: 'ID: 10086',
    isVip: true,
    vipExpiry: '2026-12-31',
    coins: 1888
  };

  const menuItems = [
    {
      id: '1',
      title: '我的收藏',
      icon: 'heart',
      onPress: () => console.log('我的收藏')
    },
    {
      id: '2',
      title: '观看历史',
      icon: 'time',
      onPress: () => console.log('观看历史')
    },
    {
      id: '3',
      title: '我的预约',
      icon: 'calendar',
      onPress: () => console.log('我的预约')
    },
    {
      id: '4',
      title: '消息中心',
      icon: 'notifications',
      onPress: () => console.log('消息中心')
    },
    {
      id: '5',
      title: '设置',
      icon: 'settings',
      onPress: () => navigation.navigate('Settings')
    }
  ];

  return (
    <View style={styles.container}>
      {/* 会员区域 */}
      <View style={styles.vipSection}>
        <View style={styles.vipInfo}>
          <Text style={styles.vipTitle}>会员权益</Text>
          <Text style={styles.vipDesc}>解锁畅看 + 去广告</Text>
          <Text style={styles.vipExpiry}>会员到期: {userData.vipExpiry}</Text>
        </View>
        <TouchableOpacity style={styles.vipButton}>
          <Text style={styles.vipButtonText}>续费会员</Text>
        </TouchableOpacity>
      </View>

      {/* 个人信息区域 */}
      <View style={styles.userSection}>
        <Image source={{ uri: userData.avatar }} style={styles.avatar} />
        <View style={styles.userInfo}>
          <Text style={styles.nickname}>{userData.nickname}</Text>
          <Text style={styles.userId}>{userData.userId}</Text>
        </View>
        <View style={styles.coinInfo}>
          <Ionicons name="star" size={20} color="#FFD700" />
          <Text style={styles.coinAmount}>{userData.coins}</Text>
        </View>
      </View>

      {/* 功能列表 */}
      <View style={styles.menuSection}>
        {menuItems.map((item) => (
          <TouchableOpacity key={item.id} style={styles.menuItem} onPress={item.onPress}>
            <View style={styles.menuItemLeft}>
              <Ionicons name={item.icon} size={24} color="#007AFF" />
              <Text style={styles.menuItemTitle}>{item.title}</Text>
            </View>
            <Ionicons name="chevron-forward" size={20} color="#999" />
          </TouchableOpacity>
        ))}
      </View>

      {/* VIP客服 */}
      <TouchableOpacity style={styles.customerService}>
        <Ionicons name="headset" size={24} color="#007AFF" />
        <Text style={styles.customerServiceText}>VIP客服</Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  vipSection: {
    backgroundColor: '#007AFF',
    padding: 20,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  vipInfo: {
    flex: 1,
  },
  vipTitle: {
    color: '#fff',
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 4,
  },
  vipDesc: {
    color: '#fff',
    fontSize: 14,
    opacity: 0.8,
    marginBottom: 4,
  },
  vipExpiry: {
    color: '#fff',
    fontSize: 12,
    opacity: 0.6,
  },
  vipButton: {
    backgroundColor: '#fff',
    paddingHorizontal: 20,
    paddingVertical: 8,
    borderRadius: 16,
  },
  vipButtonText: {
    color: '#007AFF',
    fontSize: 14,
    fontWeight: '600',
  },
  userSection: {
    backgroundColor: '#fff',
    padding: 20,
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 10,
  },
  avatar: {
    width: 80,
    height: 80,
    borderRadius: 40,
  },
  userInfo: {
    flex: 1,
    marginLeft: 16,
  },
  nickname: {
    fontSize: 18,
    fontWeight: '600',
    marginBottom: 4,
  },
  userId: {
    fontSize: 14,
    color: '#666',
  },
  coinInfo: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  coinAmount: {
    fontSize: 16,
    fontWeight: '600',
    marginLeft: 4,
    color: '#FFD700',
  },
  menuSection: {
    backgroundColor: '#fff',
    marginTop: 10,
  },
  menuItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  menuItemLeft: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  menuItemTitle: {
    fontSize: 16,
    marginLeft: 12,
  },
  customerService: {
    backgroundColor: '#fff',
    marginTop: 10,
    padding: 16,
    flexDirection: 'row',
    alignItems: 'center',
  },
  customerServiceText: {
    fontSize: 16,
    marginLeft: 12,
  },
});

export default PersonalCenterScreen;