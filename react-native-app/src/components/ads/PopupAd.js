import React, { useEffect, useState } from 'react';
import { View, Image, StyleSheet, TouchableOpacity, ActivityIndicator, Text, Modal } from 'react-native';
import AdService from '../../services/AdService';

const PopupAd = ({ visible, onClose }) => {
  const [ad, setAd] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (visible) {
      loadAd();
    }
  }, [visible]);

  const loadAd = async () => {
    try {
      const adData = await AdService.getPopupAd();
      setAd(adData);
      setLoading(false);
      
      // 记录广告展示
      AdService.recordAdImpression(adData.id);
      
      // 设置广告自动关闭
      setTimeout(() => {
        onClose();
      }, adData.duration);
    } catch (error) {
      console.error('Failed to load popup ad:', error);
      setLoading(false);
      onClose();
    }
  };

  const handleAdPress = () => {
    if (ad) {
      AdService.recordAdClick(ad.id);
      // 这里可以添加跳转逻辑
      onClose();
    }
  };

  const handleClose = () => {
    onClose();
  };

  if (!visible) {
    return null;
  }

  return (
    <Modal
      visible={visible}
      transparent
      animationType="fade"
      onRequestClose={handleClose}
    >
      <View style={styles.overlay}>
        <View style={styles.container}>
          {loading ? (
            <ActivityIndicator size="large" color="#0000ff" />
          ) : ad ? (
            <>
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
              <TouchableOpacity style={styles.closeButton} onPress={handleClose}>
                <Text style={styles.closeText}>×</Text>
              </TouchableOpacity>
            </>
          ) : null}
        </View>
      </View>
    </Modal>
  );
};

const styles = StyleSheet.create({
  overlay: {
    flex: 1,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  container: {
    width: '80%',
    backgroundColor: '#ffffff',
    borderRadius: 10,
    overflow: 'hidden',
    position: 'relative',
  },
  adContainer: {
    width: '100%',
  },
  image: {
    width: '100%',
    aspectRatio: 1,
  },
  closeButton: {
    position: 'absolute',
    top: 10,
    right: 10,
    width: 30,
    height: 30,
    borderRadius: 15,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  closeText: {
    color: '#ffffff',
    fontSize: 20,
    fontWeight: 'bold',
  },
});

export default PopupAd;
