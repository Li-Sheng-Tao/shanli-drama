<template>
  <div class="app">
    <div class="page-content">
      <router-view />
    </div>
    <div class="tabbar">
      <div class="tab-item" :class="{ active: activePage === 'index' }" @click="switchPage('index')">
        <div class="tab-icon tab-icon-brush"></div>
        <span class="tab-text">刷刷</span>
      </div>
      <div class="tab-item" :class="{ active: activePage === 'find' }" @click="switchPage('find')">
        <div class="tab-icon tab-icon-find"></div>
        <span class="tab-text">找片</span>
      </div>
      <div class="tab-item" :class="{ active: activePage === 'welfare' }" @click="switchPage('welfare')">
        <div class="tab-icon tab-icon-welfare"></div>
        <span class="tab-text">福利</span>
      </div>
      <div class="tab-item" :class="{ active: activePage === 'mine' }" @click="switchPage('mine')">
        <div class="tab-icon tab-icon-mine"></div>
        <span class="tab-text">我的</span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'

const router = useRouter()
const route = useRoute()
const activePage = ref('index')

const switchPage = (page) => {
  activePage.value = page
  router.push(`/${page}`)
}

onMounted(() => {
  // 初始化当前页面
  const path = route.path
  if (path.includes('/find')) {
    activePage.value = 'find'
  } else if (path.includes('/welfare')) {
    activePage.value = 'welfare'
  } else if (path.includes('/mine')) {
    activePage.value = 'mine'
  }
})
</script>

<style scoped>
.app {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
  color: #333;
}

.page-content {
  flex: 1;
  overflow-y: auto;
  padding-bottom: 50px;
}

.tabbar {
  display: flex;
  justify-content: space-around;
  align-items: center;
  height: 50px;
  background-color: #fff;
  border-top: 1px solid #e5e5e5;
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: 100;
}

.tab-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  flex: 1;
  height: 100%;
  font-size: 12px;
  color: #999;
}

.tab-item.active {
  color: #ff4d4f;
}

.tab-icon {
  width: 24px;
  height: 24px;
  margin-bottom: 4px;
  background-size: contain;
  background-repeat: no-repeat;
  background-position: center;
}

.tab-icon-brush {
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z" fill="%23999"/></svg>');
}

.tab-item.active .tab-icon-brush {
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z" fill="%23ff4d4f"/></svg>');
}

.tab-icon-find {
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z" fill="%23999"/></svg>');
}

.tab-item.active .tab-icon-find {
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z" fill="%23ff4d4f"/></svg>');
}

.tab-icon-welfare {
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14L2 9.27l6.91-1.01L12 2z" fill="%23999"/></svg>');
}

.tab-item.active .tab-icon-welfare {
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14L2 9.27l6.91-1.01L12 2z" fill="%23ff4d4f"/></svg>');
}

.tab-icon-mine {
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" fill="%23999"/></svg>');
}

.tab-item.active .tab-icon-mine {
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" fill="%23ff4d4f"/></svg>');
}

.tab-text {
  font-size: 12px;
}
</style>