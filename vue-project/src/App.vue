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

// 跳转到其他页面
function goToFind() {
  console.log('跳转到找片页面')
}

function goToWelfare() {
  console.log('跳转到福利页面')
}

function goToMine() {
  console.log('跳转到我的页面')
}
</script>

<template>
  <div class="app">
    <!-- 刷刷页面 -->
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
      
      <!-- 底部导航栏 -->
      <div class="tabbar">
        <div class="tab-item active">
          <div class="tab-icon"></div>
          <span class="tab-text">刷刷</span>
        </div>
        <div class="tab-item" @click="goToFind">
          <div class="tab-icon"></div>
          <span class="tab-text">找片</span>
        </div>
        <div class="tab-item" @click="goToWelfare">
          <div class="tab-icon"></div>
          <span class="tab-text">福利</span>
        </div>
        <div class="tab-item" @click="goToMine">
          <div class="tab-icon"></div>
          <span class="tab-text">我的</span>
        </div>
      </div>
    </div>
  </div>
</template>

<style>
/* 全局样式 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'PingFang SC', 'Helvetica Neue', 'Microsoft YaHei', sans-serif;
  font-size: 14px;
  line-height: 1.5;
  color: #333;
}

/* 颜色变量 */
:root {
  --color-primary: #FF4757;
  --color-bg-primary: #000000;
  --color-bg-secondary: #FFFFFF;
  --color-text-primary: #FFFFFF;
  --color-text-secondary: #9CA3AF;
  --color-text-muted: #6B7280;
  --spacing-xs: 4px;
  --spacing-sm: 8px;
  --spacing-md: 12px;
  --spacing-base: 16px;
  --spacing-lg: 20px;
  --spacing-xl: 24px;
  --spacing-xxl: 32px;
  --font-size-xs: 10px;
  --font-size-sm: 12px;
  --font-size-base: 14px;
  --font-size-md: 16px;
  --font-size-lg: 18px;
  --font-size-xl: 20px;
  --font-size-xxl: 24px;
  --font-weight-normal: 400;
  --font-weight-medium: 500;
  --font-weight-bold: 700;
  --radius-sm: 4px;
  --radius-base: 8px;
  --radius-md: 12px;
  --radius-lg: 16px;
  --radius-pill: 9999px;
  --z-base: 1;
  --z-card: 10;
  --z-sticky: 100;
  --z-navbar: 200;
  --z-dropdown: 300;
  --z-modal-bg: 400;
  --z-modal: 500;
  --z-toast: 600;
  --z-tooltip: 700;
}

/* 页面样式 */
.page {
  min-height: 100vh;
  position: relative;
}

.page-dark {
  background-color: var(--color-bg-primary);
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
  right: var(--spacing-base);
  top: 50%;
  transform: translateY(-50%);
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: var(--spacing-lg);
  z-index: var(--z-card);
}

.action-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: var(--spacing-xs);
}

.action-icon {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background-color: rgba(255, 255, 255, 0.2);
  border: 2px solid rgba(255, 255, 255, 0.3);
}

.action-text {
  font-size: var(--font-size-sm);
  color: var(--color-text-primary);
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
}

/* 底部信息面板 */
.info-panel {
  position: absolute;
  bottom: 100px;
  left: var(--spacing-base);
  right: 100px;
  z-index: var(--z-card);
}

.drama-title {
  font-size: var(--font-size-lg);
  font-weight: var(--font-weight-bold);
  color: var(--color-text-primary);
  margin-bottom: var(--spacing-sm);
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
}

.drama-desc {
  font-size: var(--font-size-base);
  color: var(--color-text-secondary);
  margin-bottom: var(--spacing-md);
  line-height: 1.4;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.drama-tags {
  display: flex;
  gap: var(--spacing-sm);
  flex-wrap: wrap;
}

.tag {
  font-size: var(--font-size-xs);
  color: var(--color-text-primary);
  background-color: rgba(255, 255, 255, 0.2);
  padding: var(--spacing-xs) var(--spacing-sm);
  border-radius: var(--radius-pill);
}

/* 底部导航栏 */
.tabbar {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  height: 56px;
  background-color: var(--color-bg-secondary);
  border-top: 1px solid #e8e8e8;
  display: flex;
  justify-content: space-around;
  align-items: center;
  z-index: var(--z-navbar);
}

.tab-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: var(--spacing-xs);
  cursor: pointer;
  padding: var(--spacing-sm);
}

.tab-item.active .tab-text {
  color: var(--color-primary);
  font-weight: var(--font-weight-medium);
}

.tab-icon {
  width: 24px;
  height: 24px;
  background-color: var(--color-text-muted);
  border-radius: 4px;
}

.tab-item.active .tab-icon {
  background-color: var(--color-primary);
}

.tab-text {
  font-size: var(--font-size-xs);
  color: var(--color-text-muted);
}
</style>
