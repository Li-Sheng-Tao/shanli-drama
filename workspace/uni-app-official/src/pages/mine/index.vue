<script setup>
// 跳转到设置页面
function goToSetting() {
  console.log('跳转到设置页面')
}
</script>

<template>
  <div class="page page-light">
    <!-- 波浪头部 -->
    <div class="wave-header">
      <div class="header-content">
        <!-- 设置入口 -->
        <div class="setting-icon" @click="goToSetting">
          <div class="setting-img"></div>
        </div>
        
        <!-- 用户头像 -->
        <div class="user-avatar">
          <div class="avatar-img"></div>
        </div>
        
        <!-- 用户信息 -->
        <div class="user-info">
          <h2 class="user-name">用户昵称</h2>
          <span class="user-id">ID: 12345678</span>
        </div>
      </div>
      
      <!-- 波浪背景 -->
      <div class="wave-bg">
        <svg class="wave-svg" viewBox="0 0 1440 320" xmlns="http://www.w3.org/2000/svg">
          <path fill="#ffffff" fill-opacity="1" d="M0,192L48,197.3C96,203,192,213,288,229.3C384,245,480,267,576,250.7C672,235,768,181,864,181.3C960,181,1056,235,1152,234.7C1248,235,1344,181,1392,154.7L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path>
        </svg>
      </div>
    </div>
    
    <!-- 内容区域 -->
    <div class="content-container">
      <span class="content-text">个人中心内容</span>
    </div>
  </div>
</template>

<style scoped>
/* 页面样式 */
.page {
  min-height: 100vh;
  background-color: #FFFFFF;
}

/* 波浪头部 */
.wave-header {
  position: relative;
  background: linear-gradient(135deg, #8B5CF6, #EC4899);
  padding: 24px 16px 32px;
  overflow: hidden;
}

.header-content {
  position: relative;
  z-index: 2;
  text-align: center;
}

.setting-icon {
  position: absolute;
  top: 16px;
  right: 16px;
  width: 48px;
  height: 48px;
  background-color: rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.setting-img {
  width: 24px;
  height: 24px;
  background-color: #FFFFFF;
  border-radius: 4px;
}

.user-avatar {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  background-color: #FFFFFF;
  margin: 0 auto 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 4px solid #FFFFFF;
}

.avatar-img {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  background-color: #6B7280;
}

.user-info {
  margin-bottom: 20px;
}

.user-name {
  font-size: 16px;
  font-weight: 700;
  color: #FFFFFF;
  margin-bottom: 4px;
  display: block;
}

.user-id {
  font-size: 12px;
  color: rgba(255, 255, 255, 0.8);
  display: block;
}

.wave-bg {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 100px;
  z-index: 1;
}

.wave-svg {
  width: 100%;
  height: 100%;
}

/* 内容区域 */
.content-container {
  min-height: 60vh;
  padding: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.content-text {
  font-size: 14px;
  color: #6B7280;
}
</style>