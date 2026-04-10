<template>
  <view class="app">
    <router-view />
  </view>
</template>

<script setup>
// App.vue
</script>

<style lang="scss">
@import './assets/styles/global.scss';

.app {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  font-family: $font-family-base;
  color: $color-text-dark;
}
</style>