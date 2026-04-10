<template>
  <view class="page page-gray">
    <!-- 渐变头部 -->
    <view class="gradient-header">
      <view class="header-content">
        <text class="header-title">福利中心</text>
        <view class="member-duration">
          <text class="duration-label">已赚会员时长</text>
          <text class="duration-value">{{ memberDuration }}天</text>
        </view>
        <button class="exchange-btn" @click="goToExchange">去兑换</button>
      </view>
    </view>
    
    <!-- 内容区域 -->
    <view class="content-container">
      <text class="content-text">福利任务内容</text>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'

// 模拟已赚会员时长
const memberDuration = ref(7)

// 去兑换页面
function goToExchange() {
  console.log('去兑换页面')
  // 可以在这里跳转到兑换页面
}
</script>

<style lang="scss" scoped>
.page {
  min-height: 100vh;
  background-color: $color-bg-gray;
}

.gradient-header {
  background: $gradient-welfare;
  padding: $spacing-xl $spacing-base $spacing-xxl;
  border-bottom-left-radius: $radius-lg;
  border-bottom-right-radius: $radius-lg;
  position: relative;
  overflow: hidden;
}

.header-content {
  position: relative;
  z-index: 1;
}

.header-title {
  font-size: $font-size-lg;
  font-weight: $font-weight-bold;
  color: $color-text-primary;
  margin-bottom: $spacing-lg;
  text-align: center;
}

.member-duration {
  text-align: center;
  margin-bottom: $spacing-xl;
}

.duration-label {
  font-size: $font-size-sm;
  color: rgba(255, 255, 255, 0.8);
  display: block;
  margin-bottom: $spacing-xs;
}

.duration-value {
  font-size: $font-size-xxl;
  font-weight: $font-weight-bold;
  color: $color-text-primary;
}

.exchange-btn {
  display: block;
  width: 80%;
  margin: 0 auto;
  padding: $spacing-md 0;
  background-color: $color-text-primary;
  color: $color-primary;
  font-size: $font-size-base;
  font-weight: $font-weight-medium;
  border-radius: $radius-pill;
  border: none;
  outline: none;
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