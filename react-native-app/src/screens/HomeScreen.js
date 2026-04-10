import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, TouchableOpacity } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import PopupAd from '../components/ads/PopupAd';

const HomeScreen = () => {
  const navigation = useNavigation();
  const [showPopupAd, setShowPopupAd] = useState(false);

  useEffect(() => {
    // 进入首页后显示弹窗广告
    setTimeout(() => {
      setShowPopupAd(true);
    }, 1000);
  }, []);

  const handlePopupClose = () => {
    setShowPopupAd(false);
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>山狸漫剧</Text>
      <Text style={styles.subtitle}>发现精彩剧集</Text>
      <View style={styles.buttonContainer}>
        <TouchableOpacity
          style={styles.button}
          onPress={() => navigation.navigate('MainTabs')}
          activeOpacity={0.7}
        >
          <Text style={styles.buttonText}>进入应用</Text>
        </TouchableOpacity>
      </View>
      <PopupAd visible={showPopupAd} onClose={handlePopupClose} />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f5f5f5',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
  },
  subtitle: {
    fontSize: 16,
    color: '#666',
    marginBottom: 40,
  },
  buttonContainer: {
    width: '80%',
    alignItems: 'center',
  },
  button: {
    backgroundColor: '#007AFF',
    paddingHorizontal: 32,
    paddingVertical: 12,
    borderRadius: 24,
    elevation: 2,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    marginBottom: 16,
    width: '100%',
    alignItems: 'center',
  },
  buttonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
  },
});

export default HomeScreen;
