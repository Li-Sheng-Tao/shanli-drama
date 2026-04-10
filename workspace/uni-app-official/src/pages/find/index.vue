<script setup>
import { ref } from 'vue'

// Tab 数据
const tabs = [
  { id: 'filter', name: '筛选' },
  { id: 'ranking', name: '排行榜' },
  { id: 'creator', name: '创作者' },
  { id: 'new', name: '上新' }
]

// 当前激活的 Tab
const activeTab = ref('filter')

// 切换 Tab
function switchTab(tabId) {
  activeTab.value = tabId
  console.log('切换到 Tab:', tabId)
}
</script>

<template>
  <div class="page page-light">
    <!-- 搜索框 -->
    <div class="search-container">
      <div class="search-box">
        <div class="search-icon"></div>
        <span class="search-placeholder">搜索剧集、演员、标签</span>
      </div>
    </div>
    
    <!-- Tab 导航 -->
    <div class="tab-container">
      <div class="tab-scroll">
        <div 
          class="tab-item" 
          v-for="tab in tabs" 
          :key="tab.id"
          :class="{ active: activeTab === tab.id }"
          @click="switchTab(tab.id)"
        >
          {{ tab.name }}
        </div>
      </div>
    </div>
    
    <!-- 内容区域 -->
    <div class="content-container">
      <!-- 筛选内容 -->
      <div v-if="activeTab === 'filter'" class="tab-content">
        <span class="content-text">筛选页面内容</span>
      </div>
      
      <!-- 排行榜内容 -->
      <div v-else-if="activeTab === 'ranking'" class="tab-content">
        <span class="content-text">排行榜页面内容</span>
      </div>
      
      <!-- 创作者内容 -->
      <div v-else-if="activeTab === 'creator'" class="tab-content">
        <span class="content-text">创作者页面内容</span>
      </div>
      
      <!-- 上新内容 -->
      <div v-else-if="activeTab === 'new'" class="tab-content">
        <span class="content-text">上新页面内容</span>
      </div>
    </div>
  </div>
</template>

<style scoped>
/* 页面样式 */
.page {
  min-height: 100vh;
  background-color: #FFFFFF;
}

/* 搜索框 */
.search-container {
  padding: 16px;
  background-color: #FFFFFF;
  border-bottom: 1px solid #e8e8e8;
}

.search-box {
  display: flex;
  align-items: center;
  gap: 8px;
  background-color: #F2F2F7;
  padding: 8px 16px;
  border-radius: 9999px;
}

.search-icon {
  width: 24px;
  height: 24px;
  background-color: #6B7280;
  opacity: 0.5;
  border-radius: 50%;
}

.search-placeholder {
  font-size: 14px;
  color: #6B7280;
  flex: 1;
}

/* Tab 导航 */
.tab-container {
  background-color: #FFFFFF;
  border-bottom: 1px solid #e8e8e8;
}

.tab-scroll {
  white-space: nowrap;
  padding: 0 16px;
}

.tab-item {
  display: inline-block;
  padding: 16px 20px;
  font-size: 14px;
  color: #6B7280;
  position: relative;
  cursor: pointer;
}

.tab-item.active {
  color: #FF4757;
  font-weight: 500;
}

.tab-item.active::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 20px;
  right: 20px;
  height: 2px;
  background-color: #FF4757;
  border-radius: 1px;
}

/* 内容区域 */
.content-container {
  min-height: 60vh;
  padding: 16px;
}

.tab-content {
  min-height: 400px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.content-text {
  font-size: 14px;
  color: #6B7280;
}
</style>