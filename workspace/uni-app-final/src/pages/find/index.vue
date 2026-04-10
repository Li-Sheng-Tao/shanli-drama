<template>
  <div class="find-page">
    <div class="search-bar">
      <div class="search-input">
        <div class="search-icon"></div>
        <span class="search-placeholder">搜索你想看的内容</span>
      </div>
    </div>
    <div class="tab-navigation">
      <div class="tab-item active">推荐</div>
      <div class="tab-item">电影</div>
      <div class="tab-item">电视剧</div>
      <div class="tab-item">动漫</div>
    </div>
    <div class="content">
      <div class="drama-item">
        <img class="drama-poster" src="https://via.placeholder.com/120x160" alt="测试剧集">
        <span class="drama-title">测试剧集</span>
      </div>
      <div class="drama-item">
        <img class="drama-poster" src="https://via.placeholder.com/120x160" alt="测试剧集">
        <span class="drama-title">测试剧集</span>
      </div>
      <div class="drama-item">
        <img class="drama-poster" src="https://via.placeholder.com/120x160" alt="测试剧集">
        <span class="drama-title">测试剧集</span>
      </div>
      <div class="drama-item">
        <img class="drama-poster" src="https://via.placeholder.com/120x160" alt="测试剧集">
        <span class="drama-title">测试剧集</span>
      </div>
    </div>
  </div>
</template>

<script setup>
// 找片页面
</script>

<style scoped>
.find-page {
  padding: 10px;
  background-color: #f5f5f5;
  min-height: 100vh;
}

.search-bar {
  margin-bottom: 15px;
}

.search-input {
  display: flex;
  align-items: center;
  background-color: #e5e5e5;
  border-radius: 20px;
  padding: 10px 15px;
}

.search-icon {
  width: 16px;
  height: 16px;
  margin-right: 10px;
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z" fill="%23999"/></svg>');
  background-size: contain;
  background-repeat: no-repeat;
  background-position: center;
}

.search-placeholder {
  color: #999;
  font-size: 14px;
}

.tab-navigation {
  display: flex;
  background-color: #fff;
  border-radius: 8px;
  padding: 10px;
  margin-bottom: 15px;
}

.tab-item {
  flex: 1;
  text-align: center;
  padding: 8px 0;
  font-size: 14px;
  color: #666;
  border-radius: 4px;
}

.tab-item.active {
  color: #ff4d4f;
  font-weight: bold;
  background-color: #fff0f0;
}

.content {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 10px;
}

.drama-item {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.drama-poster {
  width: 100%;
  aspect-ratio: 3/4;
  border-radius: 4px;
  margin-bottom: 5px;
}

.drama-title {
  font-size: 12px;
  color: #333;
  text-align: center;
  line-height: 1.3;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>