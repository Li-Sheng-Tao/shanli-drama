// 广告服务，用于管理广告数据和逻辑

// 模拟广告数据
const mockAds = {
  splash: [
    {
      id: '1',
      imageUrl: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=mobile%20app%20splash%20screen%20advertisement%20for%20anime%20streaming%20app%2C%20colorful%2C%20eye-catching%2C%20professional&image_size=square_hd',
      duration: 3000, // 3秒
      linkUrl: 'https://example.com/ad1'
    }
  ],
  unlock: [
    {
      id: '1',
      imageUrl: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=mobile%20app%20unlock%20screen%20advertisement%20for%20anime%20streaming%20app%2C%20colorful%2C%20eye-catching%2C%20professional&image_size=portrait_16_9',
      duration: 5000, // 5秒
      linkUrl: 'https://example.com/ad2'
    }
  ],
  popup: [
    {
      id: '1',
      imageUrl: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=mobile%20app%20popup%20advertisement%20for%20anime%20streaming%20app%2C%20colorful%2C%20eye-catching%2C%20professional&image_size=square',
      duration: 8000, // 8秒
      linkUrl: 'https://example.com/ad3'
    }
  ]
};

class AdService {
  // 获取开屏广告
  getSplashAd() {
    return new Promise((resolve) => {
      // 模拟网络请求延迟
      setTimeout(() => {
        resolve(mockAds.splash[0]);
      }, 100);
    });
  }

  // 获取解锁广告
  getUnlockAd() {
    return new Promise((resolve) => {
      // 模拟网络请求延迟
      setTimeout(() => {
        resolve(mockAds.unlock[0]);
      }, 100);
    });
  }

  // 获取弹窗广告
  getPopupAd() {
    return new Promise((resolve) => {
      // 模拟网络请求延迟
      setTimeout(() => {
        resolve(mockAds.popup[0]);
      }, 100);
    });
  }

  // 记录广告点击
  recordAdClick(adId) {
    console.log('Ad clicked:', adId);
    // 这里可以添加实际的点击记录逻辑
  }

  // 记录广告展示
  recordAdImpression(adId) {
    console.log('Ad impression:', adId);
    // 这里可以添加实际的展示记录逻辑
  }
}

export default new AdService();
