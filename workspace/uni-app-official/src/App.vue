<script setup>
// App.vue
</script>

<template>
  <div class="app">
    <!-- 直接显示刷刷页面 -->
    <div class="page page-dark">
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