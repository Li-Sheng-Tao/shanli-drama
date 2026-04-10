<script setup>
import { ref } from 'vue'

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
}
</script>

<template>
  <div class="page page-dark">
    <!-- 视频播放器容器 -->
    <div class="video-container">
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
      <div class="action-bar">
        <div class="action-item">
          <div class="action-icon"></div>
          <span class="action-text">关注</span>
        </div>
        <div class="action-item">
          <div class="action-icon"></div>
          <span class="action-text">收藏</span>
        </div>
        <div class="action-item">
          <div class="action-icon"></div>
          <span class="action-text">评论</span>
        </div>
        <div class="action-item">
          <div class="action-icon"></div>
          <span class="action-text">点赞</span>
        </div>
        <div class="action-item">
          <div class="action-icon"></div>
          <span class="action-text">分享</span>
        </div>
      </div>
      
      <!-- 底部信息面板 -->
      <div class="info-panel">
        <h2 class="drama-title">{{ currentVideo.title }}</h2>
        <p class="drama-desc">{{ currentVideo.description }}</p>
        <div class="drama-tags">
          <span class="tag" v-for="tag in currentVideo.tags" :key="tag">
            {{ tag }}
          </span>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
/* 页面样式 */
.page {
  min-height: 100vh;
  position: relative;
}

.page-dark {
  background-color: #000000;
}

/* 视频容器 */
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

/* 右侧交互栏 */
.action-bar {
  position: absolute;
  right: 16px;
  top: 50%;
  transform: translateY(-50%);
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 20px;
  z-index: 10;
}

.action-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
}

.action-icon {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background-color: rgba(255, 255, 255, 0.2);
  border: 2px solid rgba(255, 255, 255, 0.3);
}

.action-text {
  font-size: 12px;
  color: #FFFFFF;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
}

/* 底部信息面板 */
.info-panel {
  position: absolute;
  bottom: 100px;
  left: 16px;
  right: 100px;
  z-index: 10;
}

.drama-title {
  font-size: 18px;
  font-weight: 700;
  color: #FFFFFF;
  margin-bottom: 8px;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
}

.drama-desc {
  font-size: 14px;
  color: #9CA3AF;
  margin-bottom: 12px;
  line-height: 1.4;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.drama-tags {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.tag {
  font-size: 10px;
  color: #FFFFFF;
  background-color: rgba(255, 255, 255, 0.2);
  padding: 4px 8px;
  border-radius: 9999px;
}
</style>