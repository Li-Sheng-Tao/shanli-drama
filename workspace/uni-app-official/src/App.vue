<script setup>
import { ref } from 'vue'

// 当前选中的页面
const activePage = ref('index')

// 切换页面
function switchPage(page) {
  activePage.value = page
}
</script>

<template>
  <div class="app">
    <!-- 页面内容 -->
    <div v-if="activePage === 'index'" class="page page-dark">
      <!-- 视频播放器容器 -->
      <div class="video-container">
        <video 
          class="video-player" 
          src="https://example.com/video.mp4" 
          autoplay 
          controls 
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
          <h2 class="drama-title">热门剧集标题</h2>
          <p class="drama-desc">这是一个精彩的剧集简介，包含了剧情概述和主要角色介绍。</p>
          <div class="drama-tags">
            <span class="tag">热门</span>
            <span class="tag">新剧</span>
            <span class="tag">独家</span>
          </div>
        </div>
      </div>
    </div>
    
    <div v-else-if="activePage === 'find'" class="page page-light">
      <div class="content">
        <h1>找片</h1>
        <p>找片页面内容</p>
      </div>
    </div>
    
    <div v-else-if="activePage === 'welfare'" class="page page-gray">
      <div class="content">
        <h1>福利</h1>
        <p>福利页面内容</p>
      </div>
    </div>
    
    <div v-else-if="activePage === 'mine'" class="page page-light">
      <div class="content">
        <h1>我的</h1>
        <p>个人中心页面内容</p>
      </div>
    </div>
    
    <!-- 底部导航栏 -->
    <div class="tabbar">
      <div class="tab-item" :class="{ active: activePage === 'index' }" @click="switchPage('index')">
        <div class="tab-icon"></div>
        <span class="tab-text">刷刷</span>
      </div>
      <div class="tab-item" :class="{ active: activePage === 'find' }" @click="switchPage('find')">
        <div class="tab-icon"></div>
        <span class="tab-text">找片</span>
      </div>
      <div class="tab-item" :class="{ active: activePage === 'welfare' }" @click="switchPage('welfare')">
        <div class="tab-icon"></div>
        <span class="tab-text">福利</span>
      </div>
      <div class="tab-item" :class="{ active: activePage === 'mine' }" @click="switchPage('mine')">
        <div class="tab-icon"></div>
        <span class="tab-text">我的</span>
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

.app {
  min-height: 100vh;
}

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