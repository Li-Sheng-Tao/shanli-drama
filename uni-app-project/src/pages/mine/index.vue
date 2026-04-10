<template>
  <view class="page page-light">
    <view class="content">
      <text class="title">我的</text>
      <text class="subtitle">个人中心页面</text>
    </view>
  </view>
</template>

<script setup>
// 我的页面
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
  color: $color-accent-gold;
  margin-bottom: $spacing-md;
}

.subtitle {
  font-size: $font-size-base;
  color: $color-text-muted;
}
</style>