<template>
  <div class="mine-page">
    <div class="wave-header">
      <div class="user-info">
        <div class="avatar"></div>
        <div class="user-details">
          <h2 class="user-name">用户名</h2>
          <p class="user-id">ID: 12345678</p>
        </div>
      </div>
    </div>
    <div class="mine-content">
      <div class="menu-item">
        <div class="menu-icon vip-icon"></div>
        <span class="menu-text">我的VIP</span>
        <div class="menu-arrow"></div>
      </div>
      <div class="menu-item">
        <div class="menu-icon history-icon"></div>
        <span class="menu-text">观看历史</span>
        <div class="menu-arrow"></div>
      </div>
      <div class="menu-item">
        <div class="menu-icon download-icon"></div>
        <span class="menu-text">我的下载</span>
        <div class="menu-arrow"></div>
      </div>
      <div class="menu-item">
        <div class="menu-icon favorite-icon"></div>
        <span class="menu-text">我的收藏</span>
        <div class="menu-arrow"></div>
      </div>
      <div class="menu-item">
        <div class="menu-icon setting-icon"></div>
        <span class="menu-text">设置</span>
        <div class="menu-arrow"></div>
      </div>
    </div>
  </div>
</template>

<script setup>
// 我的页面
</script>

<style scoped>
.mine-page {
  min-height: 100vh;
  background-color: #f5f5f5;
}

.wave-header {
  background: linear-gradient(135deg, #ff4d4f, #ff7a45);
  padding: 40px 20px 20px;
  color: #fff;
  position: relative;
  overflow: hidden;
}

.wave-header::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 20px;
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="%23f5f5f5" fill-opacity="1" d="M0,224L48,218.7C96,213,192,203,288,186.7C384,171,480,149,576,160C672,171,768,213,864,213.3C960,213,1056,171,1152,165.3C1248,160,1344,192,1392,208L1440,224L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
  background-size: cover;
  background-repeat: no-repeat;
  background-position: bottom;
}

.user-info {
  display: flex;
  align-items: center;
  z-index: 1;
  position: relative;
}

.avatar {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  background-color: rgba(255, 255, 255, 0.3);
  margin-right: 15px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.user-details {
  flex: 1;
}

.user-name {
  font-size: 18px;
  font-weight: bold;
  margin-bottom: 5px;
}

.user-id {
  font-size: 14px;
  opacity: 0.8;
}

.mine-content {
  padding: 10px;
}

.menu-item {
  display: flex;
  align-items: center;
  background-color: #fff;
  padding: 15px;
  border-radius: 8px;
  margin-bottom: 10px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.menu-icon {
  width: 24px;
  height: 24px;
  margin-right: 15px;
  background-size: contain;
  background-repeat: no-repeat;
  background-position: center;
}

.vip-icon {
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 2L15.09 8.26L22 9.27L17 14.14L18.18 21.02L12 17.77L5.82 21.02L7 14.14L2 9.27L8.91 8.26L12 2z" fill="%23ff4d4f"/></svg>');
}

.history-icon {
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M13 3c-4.97 0-9 4.03-9 9H1l3.89 3.89.07.14L9 12H6c0-3.87 3.13-7 7-7s7 3.13 7 7-3.13 7-7 7c-1.93 0-3.68-.79-4.94-2.06l-1.42 1.42C8.27 19.99 10.51 21 13 21c4.97 0 9-4.03 9-9s-4.03-9-9-9zm-1 5v5l4.28 2.54.72-1.21-3.5-2.08V8H12z" fill="%23ff4d4f"/></svg>');
}

.download-icon {
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M19.35 10.04C18.67 6.59 15.64 4 12 4 9.11 4 6.6 5.64 5.35 8.04 2.34 8.36 0 10.91 0 14c0 3.31 2.69 6 6 6h13c2.76 0 5-2.24 5-5 0-2.64-2.05-4.78-4.65-4.96zM19 18H6c-2.21 0-4-1.79-4-4 0-2.05 1.53-3.76 3.56-3.97l1.07-.11.5-.95C8.08 7.14 9.94 6 12 6c2.62 0 4.88 1.86 5.39 4.43l.3 1.5 1.53.11c1.56.1 2.78 1.41 2.78 2.96 0 1.65-1.35 3-3 3zm-5.55-8h-2.9v3H8l4 4 4-4h-2.55z" fill="%23ff4d4f"/></svg>');
}

.favorite-icon {
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z" fill="%23ff4d4f"/></svg>');
}

.setting-icon {
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M19.14 12.94c.04-.3.06-.61.06-.94 0-.32-.02-.64-.07-.94l2.03-1.58c.18-.14.23-.41.12-.61l-1.92-3.32c-.12-.22-.37-.29-.59-.22l-2.39.96c-.5-.38-1.03-.7-1.62-.94l-.36-2.54c-.04-.24-.24-.41-.48-.41h-3.84c-.24 0-.43.17-.47.41l-.36 2.54c-.59.24-1.13.57-1.62.94l-2.39-.96c-.22-.08-.47 0-.59.22L2.74 8.87c-.12.21-.08.47.12.61l2.03 1.58c-.05.3-.09.63-.09.94s.02.64.07.94l-2.03 1.58c-.18.14-.23.41-.12.61l1.92 3.32c.12.22.37.29.59.22l2.39-.96c.5.38 1.03.7 1.62.94l.36 2.54c.05.24.24.41.48.41h3.84c.24 0 .44-.17.47-.41l.36-2.54c.59-.24 1.13-.56 1.62-.94l2.39.96c.22.08.47 0 .59-.22l1.92-3.32c.12-.22.07-.47-.12-.61l-2.01-1.58zM12 15.6c-1.98 0-3.6-1.62-3.6-3.6s1.62-3.6 3.6-3.6 3.6 1.62 3.6 3.6-1.62 3.6-3.6 3.6z" fill="%23ff4d4f"/></svg>');
}

.menu-text {
  flex: 1;
  font-size: 14px;
  color: #333;
}

.menu-arrow {
  width: 16px;
  height: 16px;
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M8.59 16.59L13.17 12 8.59 7.41 10 6l6 6-6 6-1.41-1.41z" fill="%23999"/></svg>');
  background-size: contain;
  background-repeat: no-repeat;
  background-position: center;
}
</style>