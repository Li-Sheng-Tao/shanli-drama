import React, { useEffect, useState } from 'react';
import { View, Image, StyleSheet, TouchableOpacity, ActivityIndicator, Text } from 'react-native';
import AdService from '../../services/AdService';

const UnlockAd = ({ onAdComplete }) => {
  const [ad, setAd] = useState(null);
  const [loading, setLoading] = useState(true);
  const [countdown, setCountdown] = useState(0);

  useEffect(() => {
    loadAd();
  }, []);

  useEffect(() => {
    let timer;
    if (countdown > 0) {
      timer = setInterval(() => {
        setCountdown(prev => {
          if (prev <= 1) {
            clearInterval(timer);
            onAdComplete();
            return 0;
          }
          return prev - 1;
        });
      }, 1000);
    }
    return () => clearInterval(timer);
  }, [countdown, onAdComplete]);

  const loadAd = async () => {
    try {
      const adData = await AdService.getUnlockAd();
      setAd(adData);
      setLoading(false);
      setCountdown(Math.ceil(adData.duration / 1000));
      
      // 记录广告展示
      AdService.recordAdImpression(adData.id);
    } catch (error) {
      console.error('Failed to load unlock ad:', error);
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

  const handleSkip = () => {
    onAdComplete();
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
    <View style={styles.container}>
      <TouchableOpacity 
        style={styles.adContainer} 
        activeOpacity={0.9} 
        onPress={handleAdPress}
      >
        <Image 
          source={{ uri: ad.imageUrl }} 
          style={styles.image} 
          resizeMode="cover"
        />
      </TouchableOpacity>
      <TouchableOpacity style={styles.skipButton} onPress={handleSkip}>
        <Text style={styles.skipText}>跳过 {countdown}s</Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#000000',
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#000000',
  },
  adContainer: {
    flex: 1,
  },
  image: {
    width: '100%',
    height: '100%',
  },
  skipButton: {
    position: 'absolute',
    top: 50,
    right: 20,
    paddingHorizontal: 20,
    paddingVertical: 10,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    borderRadius: 20,
  },
  skipText: {
    color: '#ffffff',
    fontSize: 16,
  },
});

export default UnlockAd;
