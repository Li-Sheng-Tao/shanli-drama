<template>
  <view class="page page-light">
    <!-- 波浪头部 -->
    <view class="wave-header">
      <view class="header-content">
        <!-- 设置入口 -->
        <view class="setting-icon" @click="goToSetting">
          <image src="/static/tabbar/home-active.png" mode="aspectFill" class="setting-img" />
        </view>
        
        <!-- 用户头像 -->
        <view class="user-avatar">
          <image src="/static/tabbar/home-active.png" mode="aspectFill" class="avatar-img" />
        </view>
        
        <!-- 用户信息 -->
        <view class="user-info">
          <text class="user-name">用户昵称</text>
          <text class="user-id">ID: 12345678</text>
        </view>
      </view>
      
      <!-- 波浪背景 -->
      <view class="wave-bg">
        <svg class="wave-svg" viewBox="0 0 1440 320" xmlns="http://www.w3.org/2000/svg">
          <path fill="#ffffff" fill-opacity="1" d="M0,192L48,197.3C96,203,192,213,288,229.3C384,245,480,267,576,250.7C672,235,768,181,864,181.3C960,181,1056,235,1152,234.7C1248,235,1344,181,1392,154.7L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path>
        </svg>
      </view>
    </view>
    
    <!-- 内容区域 -->
    <view class="content-container">
      <text class="content-text">个人中心内容</text>
    </view>
  </view>
</template>

<script setup>
// 跳转到设置页面
function goToSetting() {
  console.log('跳转到设置页面')
  // 可以在这里跳转到设置页面
}
</script>

<style lang="scss" scoped>
.page {
  min-height: 100vh;
  background-color: $color-bg-secondary;
}

.wave-header {
  position: relative;
  background: linear-gradient(135deg, #8B5CF6, #EC4899);
  padding: $spacing-xl $spacing-base $spacing-xxl;
  overflow: hidden;
}

.header-content {
  position: relative;
  z-index: 2;
  text-align: center;
}

.setting-icon {
  position: absolute;
  top: $spacing-base;
  right: $spacing-base;
  width: 48rpx;
  height: 48rpx;
  background-color: rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.setting-img {
  width: 24rpx;
  height: 24rpx;
}

.user-avatar {
  width: 120rpx;
  height: 120rpx;
  border-radius: 50%;
  background-color: $color-bg-secondary;
  margin: 0 auto $spacing-md;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 4rpx solid $color-bg-secondary;
}

.avatar-img {
  width: 100rpx;
  height: 100rpx;
  border-radius: 50%;
}

.user-info {
  margin-bottom: $spacing-lg;
}

.user-name {
  font-size: $font-size-md;
  font-weight: $font-weight-bold;
  color: $color-text-primary;
  margin-bottom: $spacing-xs;
  display: block;
}

.user-id {
  font-size: $font-size-sm;
  color: rgba(255, 255, 255, 0.8);
  display: block;
}

.wave-bg {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 100rpx;
  z-index: 1;
}

.wave-svg {
  width: 100%;
  height: 100%;
}

.content-container {
  min-height: 60vh;
  padding: $spacing-base;
  display: flex;
  align-items: center;
  justify-content: center;
}

.content-text {
  font-size: $font-size-base;
  color: $color-text-muted;
}
</style>