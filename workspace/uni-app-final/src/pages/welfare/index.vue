<template>
  <div class="welfare-page">
    <div class="gradient-header">
      <h1 class="header-title">福利中心</h1>
    </div>
    <div class="welfare-content">
      <div class="welfare-card">
        <div class="card-header">
          <h3 class="card-title">新人福利</h3>
          <span class="card-tag">限时</span>
        </div>
        <div class="card-body">
          <p class="card-desc">注册即送100金币</p>
          <button class="card-button">立即领取</button>
        </div>
      </div>
      <div class="welfare-card">
        <div class="card-header">
          <h3 class="card-title">每日签到</h3>
          <span class="card-tag">每日</span>
        </div>
        <div class="card-body">
          <p class="card-desc">连续签到7天送VIP</p>
          <button class="card-button">立即签到</button>
        </div>
      </div>
      <div class="welfare-card">
        <div class="card-header">
          <h3 class="card-title">邀请好友</h3>
          <span class="card-tag">奖励</span>
        </div>
        <div class="card-body">
          <p class="card-desc">邀请好友注册送50金币</p>
          <button class="card-button">立即邀请</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
// 福利页面
</script>

<style scoped>
.welfare-page {
  min-height: 100vh;
  background-color: #f5f5f5;
}

.gradient-header {
  background: linear-gradient(135deg, #ff4d4f, #ff7a45);
  padding: 40px 20px 20px;
  color: #fff;
  border-bottom-left-radius: 20px;
  border-bottom-right-radius: 20px;
}

.header-title {
  font-size: 24px;
  font-weight: bold;
}

.welfare-content {
  padding: 20px;
}

.welfare-card {
  background-color: #fff;
  border-radius: 12px;
  padding: 20px;
  margin-bottom: 15px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
}

.card-title {
  font-size: 18px;
  font-weight: bold;
  color: #333;
}

.card-tag {
  font-size: 12px;
  padding: 2px 8px;
  background-color: #ff4d4f;
  color: #fff;
  border-radius: 10px;
}

.card-body {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-desc {
  font-size: 14px;
  color: #666;
}

.card-button {
  background-color: #ff4d4f;
  color: #fff;
  border: none;
  padding: 8px 16px;
  border-radius: 20px;
  font-size: 14px;
  font-weight: bold;
}
</style>