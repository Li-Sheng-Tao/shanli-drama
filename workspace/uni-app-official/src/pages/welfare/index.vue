<script setup>
import { ref } from 'vue'

// 模拟已赚会员时长
const memberDuration = ref(7)

// 去兑换页面
function goToExchange() {
  console.log('去兑换页面')
}
</script>

<template>
  <div class="page page-gray">
    <!-- 渐变头部 -->
    <div class="gradient-header">
      <div class="header-content">
        <h1 class="header-title">福利中心</h1>
        <div class="member-duration">
          <span class="duration-label">已赚会员时长</span>
          <span class="duration-value">{{ memberDuration }}天</span>
        </div>
        <button class="exchange-btn" @click="goToExchange">去兑换</button>
      </div>
    </div>
    
    <!-- 内容区域 -->
    <div class="content-container">
      <span class="content-text">福利任务内容</span>
    </div>
  </div>
</template>

<style scoped>
/* 页面样式 */
.page {
  min-height: 100vh;
  background-color: #F5F5F5;
}

/* 渐变头部 */
.gradient-header {
  background: linear-gradient(135deg, #FF4D4F, #FF7A45);
  padding: 24px 16px 32px;
  border-bottom-left-radius: 16px;
  border-bottom-right-radius: 16px;
  position: relative;
  overflow: hidden;
}

.header-content {
  position: relative;
  z-index: 1;
}

.header-title {
  font-size: 18px;
  font-weight: 700;
  color: #FFFFFF;
  margin-bottom: 20px;
  text-align: center;
}

.member-duration {
  text-align: center;
  margin-bottom: 24px;
}

.duration-label {
  font-size: 12px;
  color: rgba(255, 255, 255, 0.8);
  display: block;
  margin-bottom: 4px;
}

.duration-value {
  font-size: 24px;
  font-weight: 700;
  color: #FFFFFF;
}

.exchange-btn {
  display: block;
  width: 80%;
  margin: 0 auto;
  padding: 12px 0;
  background-color: #FFFFFF;
  color: #FF4757;
  font-size: 14px;
  font-weight: 500;
  border-radius: 9999px;
  border: none;
  outline: none;
  cursor: pointer;
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