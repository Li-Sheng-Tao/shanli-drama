<template>
  <div class="index-page">
    <div class="video-container">
      <video class="video-player" src="https://vjs.zencdn.net/v/oceans.mp4" autoplay loop muted></video>
      <div class="video-overlay">
        <div class="video-info">
          <h2 class="video-title">测试视频</h2>
          <p class="video-desc">这是一个测试视频，用于展示刷刷页面的功能</p>
        </div>
      </div>
    </div>
    <div class="interaction-bar">
      <div class="interaction-item">
        <div class="interaction-icon like-icon"></div>
        <span class="interaction-text">1.2w</span>
      </div>
      <div class="interaction-item">
        <div class="interaction-icon comment-icon"></div>
        <span class="interaction-text">328</span>
      </div>
      <div class="interaction-item">
        <div class="interaction-icon share-icon"></div>
        <span class="interaction-text">分享</span>
      </div>
      <div class="interaction-item">
        <div class="interaction-icon follow-icon"></div>
        <span class="interaction-text">关注</span>
      </div>
    </div>
  </div>
</template>

<script setup>
// 刷刷页面
</script>

<style scoped>
.index-page {
  position: relative;
  width: 100%;
  height: 100vh;
  overflow: hidden;
}

.video-container {
  position: relative;
  width: 100%;
  height: 100%;
}

.video-player {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.video-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 20px;
  background: linear-gradient(transparent, rgba(0, 0, 0, 0.8));
  color: #fff;
}

.video-title {
  font-size: 18px;
  font-weight: bold;
  margin-bottom: 8px;
}

.video-desc {
  font-size: 14px;
  opacity: 0.8;
}

.interaction-bar {
  position: absolute;
  right: 10px;
  bottom: 100px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 20px;
}

.interaction-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  color: #fff;
}

.interaction-icon {
  width: 40px;
  height: 40px;
  margin-bottom: 5px;
  background-size: contain;
  background-repeat: no-repeat;
  background-position: center;
}

.like-icon {
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z" fill="%23fff"/></svg>');
}

.comment-icon {
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M21 6h-2v9H6v2c0 .55.45 1 1 1h11l4 4V7c0-.55-.45-1-1-1zm-4 6V3c0-.55-.45-1-1-1H3c-.55 0-1 .45-1 1v14l4-4h10c.55 0 1-.45 1-1z" fill="%23fff"/></svg>');
}

.share-icon {
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M18 16.08c-.76 0-1.44.3-1.96.77L8.91 12.7c.05-.23.09-.46.09-.7s-.04-.47-.09-.7l7.05-4.11c.54.5 1.25.81 2.04.81 1.66 0 3-1.34 3-3s-1.34-3-3-3-3 1.34-3 3c0 .24.04.47.09.7L8.04 9.81C7.5 9.31 6.79 9 6 9c-1.66 0-3 1.34-3 3s1.34 3 3 3c.79 0 1.5-.31 2.04-.81l7.12 4.16c-.05.21-.08.43-.08.65 0 1.61 1.31 2.92 2.92 2.92 1.61 0 2.92-1.31 2.92-2.92s-1.31-2.92-2.92-2.92z" fill="%23fff"/></svg>');
}

.follow-icon {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  background-color: #ff4d4f;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  font-weight: bold;
}

.interaction-text {
  font-size: 12px;
  margin-top: 5px;
}
</style>