<template>
  <view class="page page-dark">
    <view class="content">
      <text class="title">刷刷</text>
      <text class="subtitle">短视频流页面</text>
    </view>
  </view>
</template>

<script setup>
// 刷刷页面
</script>

<style lang="scss" scoped>
.page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
}

.content {
  text-align: center;
}

.title {
  font-size: $font-size-xl;
  font-weight: $font-weight-bold;
  color: $color-text-primary;
  margin-bottom: $spacing-md;
}

.subtitle {
  font-size: $font-size-base;
  color: $color-text-secondary;
}
</style>