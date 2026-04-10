import React, { useState } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, Switch } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useNavigation } from '@react-navigation/native';

const SettingsScreen = () => {
  const navigation = useNavigation();
  const [notifications, setNotifications] = useState(true);
  const [darkMode, setDarkMode] = useState(false);
  const [autoPlay, setAutoPlay] = useState(true);

  const settingsSections = [
    {
      title: '账号设置',
      items: [
        {
          id: '1',
          title: '修改密码',
          icon: 'lock-closed',
          onPress: () => console.log('修改密码')
        },
        {
          id: '2',
          title: '绑定手机号',
          icon: 'phone-portrait',
          onPress: () => console.log('绑定手机号')
        },
        {
          id: '3',
          title: '账号安全',
          icon: 'shield-checkmark',
          onPress: () => console.log('账号安全')
        }
      ]
    },
    {
      title: '隐私设置',
      items: [
        {
          id: '4',
          title: '个人信息收集',
          icon: 'person-circle',
          onPress: () => console.log('个人信息收集')
        },
        {
          id: '5',
          title: '清除缓存',
          icon: 'trash',
          onPress: () => console.log('清除缓存')
        }
      ]
    },
    {
      title: '播放设置',
      items: [
        {
          id: '6',
          title: '自动播放',
          icon: 'play-skip-forward',
          type: 'switch',
          value: autoPlay,
          onValueChange: setAutoPlay
        },
        {
          id: '7',
          title: '默认清晰度',
          icon: 'videocam',
          onPress: () => console.log('默认清晰度')
        }
      ]
    },
    {
      title: '通知设置',
      items: [
        {
          id: '8',
          title: '消息通知',
          icon: 'notifications',
          type: 'switch',
          value: notifications,
          onValueChange: setNotifications
        },
        {
          id: '9',
          title: '新剧推送',
          icon: 'film',
          onPress: () => console.log('新剧推送')
        }
      ]
    },
    {
      title: '其他',
      items: [
        {
          id: '10',
          title: '关于我们',
          icon: 'information-circle',
          onPress: () => console.log('关于我们')
        },
        {
          id: '11',
          title: '用户协议',
          icon: 'document-text',
          onPress: () => console.log('用户协议')
        },
        {
          id: '12',
          title: '隐私政策',
          icon: 'shield',
          onPress: () => console.log('隐私政策')
        },
        {
          id: '13',
          title: '版本信息',
          icon: 'code-slash',
          value: 'v1.0.0',
          onPress: () => console.log('版本信息')
        }
      ]
    }
  ];

  return (
    <View style={styles.container}>
      {settingsSections.map((section, sectionIndex) => (
        <View key={sectionIndex} style={styles.section}>
          <Text style={styles.sectionTitle}>{section.title}</Text>
          <View style={styles.sectionContent}>
            {section.items.map((item) => (
              <TouchableOpacity
                key={item.id}
                style={styles.settingItem}
                onPress={item.onPress}
                disabled={item.type === 'switch'}
              >
                <View style={styles.settingItemLeft}>
                  <Ionicons name={item.icon} size={24} color="#007AFF" />
                  <Text style={styles.settingItemTitle}>{item.title}</Text>
                </View>
                {item.type === 'switch' ? (
                  <Switch
                    value={item.value}
                    onValueChange={item.onValueChange}
                    trackColor={{ false: '#d1d1d6', true: '#4cd964' }}
                    thumbColor={item.value ? '#fff' : '#f4f3f4'}
                  />
                ) : item.value ? (
                  <Text style={styles.settingItemValue}>{item.value}</Text>
                ) : (
                  <Ionicons name="chevron-forward" size={20} color="#999" />
                )}
              </TouchableOpacity>
            ))}
          </View>
        </View>
      ))}

      <TouchableOpacity style={styles.logoutButton}>
        <Text style={styles.logoutText}>退出登录</Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  section: {
    marginTop: 20,
  },
  sectionTitle: {
    fontSize: 14,
    color: '#666',
    marginLeft: 16,
    marginBottom: 8,
  },
  sectionContent: {
    backgroundColor: '#fff',
  },
  settingItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  settingItemLeft: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  settingItemTitle: {
    fontSize: 16,
    marginLeft: 12,
  },
  settingItemValue: {
    fontSize: 14,
    color: '#999',
  },
  logoutButton: {
    backgroundColor: '#fff',
    marginTop: 30,
    marginHorizontal: 16,
    padding: 16,
    borderRadius: 8,
    alignItems: 'center',
  },
  logoutText: {
    fontSize: 16,
    color: '#ff3b30',
    fontWeight: '600',
  },
});

export default SettingsScreen;