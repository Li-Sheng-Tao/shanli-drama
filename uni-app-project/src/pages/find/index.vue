<template>
  <view class="page page-light">
    <!-- 搜索框 -->
    <view class="search-container">
      <view class="search-box">
        <image class="search-icon" src="/static/tabbar/home-active.png" mode="aspectFill" />
        <text class="search-placeholder">搜索剧集、演员、标签</text>
      </view>
    </view>
    
    <!-- Tab 导航 -->
    <view class="tab-container">
      <scroll-view class="tab-scroll" scroll-x>
        <view 
          class="tab-item" 
          v-for="tab in tabs" 
          :key="tab.id"
          :class="{ active: activeTab === tab.id }"
          @click="switchTab(tab.id)"
        >
          {{ tab.name }}
        </view>
      </scroll-view>
    </view>
    
    <!-- 内容区域 -->
    <view class="content-container">
      <!-- 筛选内容 -->
      <view v-if="activeTab === 'filter'" class="tab-content">
        <text class="content-text">筛选页面内容</text>
      </view>
      
      <!-- 排行榜内容 -->
      <view v-else-if="activeTab === 'ranking'" class="tab-content">
        <text class="content-text">排行榜页面内容</text>
      </view>
      
      <!-- 创作者内容 -->
      <view v-else-if="activeTab === 'creator'" class="tab-content">
        <text class="content-text">创作者页面内容</text>
      </view>
      
      <!-- 上新内容 -->
      <view v-else-if="activeTab === 'new'" class="tab-content">
        <text class="content-text">上新页面内容</text>
      </view>
    </view>
  </view>
</template>

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

<style lang="scss" scoped>
.page {
  min-height: 100vh;
  background-color: $color-bg-secondary;
}

.search-container {
  padding: $spacing-base;
  background-color: $color-bg-secondary;
  border-bottom: 1px solid $color-border;
}

.search-box {
  display: flex;
  align-items: center;
  gap: $spacing-sm;
  background-color: $color-bg-input;
  padding: $spacing-sm $spacing-base;
  border-radius: $radius-pill;
}

.search-icon {
  width: 24rpx;
  height: 24rpx;
  opacity: 0.5;
}

.search-placeholder {
  font-size: $font-size-base;
  color: $color-text-muted;
  flex: 1;
}

.tab-container {
  background-color: $color-bg-secondary;
  border-bottom: 1px solid $color-border;
}

.tab-scroll {
  white-space: nowrap;
  padding: 0 $spacing-base;
}

.tab-item {
  display: inline-block;
  padding: $spacing-base $spacing-lg;
  font-size: $font-size-base;
  color: $color-text-muted;
  position: relative;
  cursor: pointer;
  
  &.active {
    color: $color-primary;
    font-weight: $font-weight-medium;
    
    &::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: $spacing-lg;
      right: $spacing-lg;
      height: 2px;
      background-color: $color-primary;
      border-radius: 1px;
    }
  }
}

.content-container {
  min-height: 60vh;
  padding: $spacing-base;
}

.tab-content {
  min-height: 400rpx;
  display: flex;
  align-items: center;
  justify-content: center;
}

.content-text {
  font-size: $font-size-base;
  color: $color-text-muted;
}
</style>