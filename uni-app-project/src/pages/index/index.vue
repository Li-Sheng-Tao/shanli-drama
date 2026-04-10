<template>
  <view class="page page-dark">
    <!-- 视频播放器容器 -->
    <view class="video-container">
      <video 
        class="video-player" 
        :src="currentVideo.url" 
        :autoplay="true" 
        :controls="false"
        :show-fullscreen-btn="false"
        :show-play-btn="false"
        :show-center-play-btn="false"
        @play="onPlay"
        @pause="onPause"
        @ended="onEnded"
      />
      
      <!-- 右侧交互栏 -->
      <view class="action-bar">
        <view class="action-item">
          <image class="action-icon" src="/static/tabbar/home-active.png" mode="aspectFill" />
          <text class="action-text">关注</text>
        </view>
        <view class="action-item">
          <image class="action-icon" src="/static/tabbar/home-active.png" mode="aspectFill" />
          <text class="action-text">收藏</text>
        </view>
        <view class="action-item">
          <image class="action-icon" src="/static/tabbar/home-active.png" mode="aspectFill" />
          <text class="action-text">评论</text>
        </view>
        <view class="action-item">
          <image class="action-icon" src="/static/tabbar/home-active.png" mode="aspectFill" />
          <text class="action-text">点赞</text>
        </view>
        <view class="action-item">
          <image class="action-icon" src="/static/tabbar/home-active.png" mode="aspectFill" />
          <text class="action-text">分享</text>
        </view>
      </view>
      
      <!-- 底部信息面板 -->
      <view class="info-panel">
        <text class="drama-title">{{ currentVideo.title }}</text>
        <text class="drama-desc">{{ currentVideo.description }}</text>
        <view class="drama-tags">
          <view class="tag" v-for="tag in currentVideo.tags" :key="tag">
            {{ tag }}
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref, onMounted } from 'vue'

// 模拟视频数据
const currentVideo = ref({
  url: 'https://example.com/video.mp4',
  title: '热门剧集标题',
  description: '这是一个精彩的剧集简介，包含了剧情概述和主要角色介绍。',
  tags: ['热门', '新剧', '独家']
})

// 视频播放事件处理
function onPlay() {
  console.log('视频开始播放')
}

function onPause() {
  console.log('视频暂停')
}

function onEnded() {
  console.log('视频播放结束')
  // 可以在这里实现自动播放下一个视频
}

// 页面加载
onMounted(() => {
  console.log('刷刷页面加载')
  // 可以在这里初始化视频列表数据
})
</script>

<style lang="scss" scoped>
.page {
  min-height: 100vh;
  background-color: $color-bg-primary;
  position: relative;
}

.video-container {
  width: 100%;
  height: 100vh;
  position: relative;
  overflow: hidden;
}

.video-player {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.action-bar {
  position: absolute;
  right: $spacing-base;
  top: 50%;
  transform: translateY(-50%);
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: $spacing-lg;
  z-index: $z-card;
}

.action-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: $spacing-xs;
}

.action-icon {
  width: 48rpx;
  height: 48rpx;
  border-radius: 50%;
  background-color: rgba(0, 0, 0, 0.5);
  padding: 8rpx;
}

.action-text {
  font-size: $font-size-sm;
  color: $color-text-primary;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
}

.info-panel {
  position: absolute;
  bottom: 100rpx; // 留出底部导航栏的空间
  left: $spacing-base;
  right: 100rpx; // 留出右侧交互栏的空间
  z-index: $z-card;
}

.drama-title {
  font-size: $font-size-lg;
  font-weight: $font-weight-bold;
  color: $color-text-primary;
  margin-bottom: $spacing-sm;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
}

.drama-desc {
  font-size: $font-size-base;
  color: $color-text-secondary;
  margin-bottom: $spacing-md;
  line-height: 1.4;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.drama-tags {
  display: flex;
  gap: $spacing-sm;
  flex-wrap: wrap;
}

.tag {
  font-size: $font-size-xs;
  color: $color-text-primary;
  background-color: rgba(255, 255, 255, 0.2);
  padding: $spacing-xs $spacing-sm;
  border-radius: $radius-pill;
}
</style>