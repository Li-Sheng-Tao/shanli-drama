import React, { useEffect, useState } from 'react';
import { View, Image, StyleSheet, TouchableOpacity, ActivityIndicator } from 'react-native';
import AdService from '../../services/AdService';

const SplashAd = ({ onAdComplete }) => {
  const [ad, setAd] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadAd();
  }, []);

  const loadAd = async () => {
    try {
      const adData = await AdService.getSplashAd();
      setAd(adData);
      setLoading(false);
      
      // 记录广告展示
      AdService.recordAdImpression(adData.id);
      
      // 设置广告展示时长
      setTimeout(() => {
        onAdComplete();
      }, adData.duration);
    } catch (error) {
      console.error('Failed to load splash ad:', error);
      setLoading(false);
      onAdComplete();
    }
  };

  const handleAdPress = () => {
    if (ad) {
      AdService.recordAdClick(ad.id);
      // 这里可以添加跳转逻辑
      onAdComplete();
    }
  };

  if (loading) {
    return (
      <View style={styles.loadingContainer}>
        <ActivityIndicator size="large" color="#0000ff" />
      </View>
    );
  }

  if (!ad) {
    return null;
  }

  return (
    <TouchableOpacity 
      style={styles.container} 
      activeOpacity={0.9} 
      onPress={handleAdPress}
    >
      <Image 
        source={{ uri: ad.imageUrl }} 
        style={styles.image} 
        resizeMode="cover"
      />
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#ffffff',
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#ffffff',
  },
  image: {
    width: '100%',
    height: '100%',
  },
});

export default SplashAd;
