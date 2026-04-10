import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  FlatList,
  TouchableOpacity,
  TextInput,
  ScrollView,
  SafeAreaView,
  Dimensions,
} from 'react-native';
import { useNavigation } from '@react-navigation/native';

const { width } = Dimensions.get('window');
const ITEM_WIDTH = (width - 36) / 2; // 两列布局，考虑间距

// 模拟剧集数据
const mockDramas = [
  {
    id: '1',
    title: '都市爱情故事',
    cover: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=modern%20city%20romance%20drama%20poster&image_size=square',
    category: '都市',
    subcategory: '爱情',
    popularity: 9876,
    status: '连载中',
  },
  {
    id: '2',
    title: '古装武侠传',
    cover: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=ancient%20chinese%20wuxia%20drama%20poster&image_size=square',
    category: '古装',
    subcategory: '武侠',
    popularity: 8765,
    status: '完结',
  },
  {
    id: '3',
    title: '悬疑探案录',
    cover: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=mystery%20detective%20drama%20poster&image_size=square',
    category: '悬疑',
    subcategory: '探案',
    popularity: 7654,
    status: '连载中',
  },
  {
    id: '4',
    title: '甜宠小确幸',
    cover: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=sweet%20romance%20drama%20poster&image_size=square',
    category: '都市',
    subcategory: '甜宠',
    popularity: 6543,
    status: '完结',
  },
  {
    id: '5',
    title: '穿越时空记',
    cover: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=time%20travel%20drama%20poster&image_size=square',
    category: '古装',
    subcategory: '穿越',
    popularity: 5432,
    status: '连载中',
  },
  {
    id: '6',
    title: '逆袭人生',
    cover: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=underdog%20success%20story%20drama%20poster&image_size=square',
    category: '都市',
    subcategory: '逆袭',
    popularity: 4321,
    status: '完结',
  },
];

// 分类数据
const categories = [
  { id: 'all', name: '全部' },
  { id: '都市', name: '都市' },
  { id: '古装', name: '古装' },
  { id: '悬疑', name: '悬疑' },
  { id: '甜宠', name: '甜宠' },
  { id: '穿越', name: '穿越' },
];

// 排序选项
const sortOptions = [
  { id: 'popularity', name: '最热' },
  { id: 'latest', name: '最新' },
  { id: 'rating', name: '评分最高' },
];

const FindDramaScreen = () => {
  const navigation = useNavigation();
  const [searchText, setSearchText] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('all');
  const [selectedSort, setSelectedSort] = useState('popularity');
  const [filteredDramas, setFilteredDramas] = useState(mockDramas);

  // 筛选和排序逻辑
  useEffect(() => {
    let result = [...mockDramas];

    // 搜索筛选
    if (searchText) {
      result = result.filter(drama =>
        drama.title.toLowerCase().includes(searchText.toLowerCase())
      );
    }

    // 分类筛选
    if (selectedCategory !== 'all') {
      result = result.filter(drama => drama.category === selectedCategory);
    }

    // 排序
    switch (selectedSort) {
      case 'popularity':
        result.sort((a, b) => b.popularity - a.popularity);
        break;
      case 'latest':
        // 模拟最新排序
        result.sort((a, b) => b.id - a.id);
        break;
      case 'rating':
        // 模拟评分排序
        result.sort((a, b) => (b.popularity % 100) - (a.popularity % 100));
        break;
      default:
        break;
    }

    setFilteredDramas(result);
  }, [searchText, selectedCategory, selectedSort]);

  // 渲染剧集卡片
  const renderDramaCard = ({ item }) => (
    <TouchableOpacity style={styles.dramaCard} activeOpacity={0.7}>
      <View style={styles.coverContainer}>
        <View style={styles.coverWrapper}>
          <Text style={styles.coverPlaceholder}>封面</Text>
        </View>
        <View style={styles.statusBadge}>
          <Text style={styles.statusText}>{item.status}</Text>
        </View>
      </View>
      <Text style={styles.dramaTitle} numberOfLines={2}>
        {item.title}
      </Text>
      <View style={styles.dramaInfo}>
        <Text style={styles.categoryText}>{item.category}</Text>
        <Text style={styles.popularityText}>{item.popularity}</Text>
      </View>
    </TouchableOpacity>
  );

  return (
    <SafeAreaView style={styles.container}>
      {/* 顶部搜索栏 */}
      <View style={styles.searchBar}>
        <View style={styles.searchInputContainer}>
          <Text style={styles.searchIcon}>🔍</Text>
          <TextInput
            style={styles.searchInput}
            placeholder="搜索剧集"
            placeholderTextColor="#999"
            value={searchText}
            onChangeText={setSearchText}
          />
        </View>
        <TouchableOpacity style={styles.filterButton}>
          <Text style={styles.filterButtonText}>筛选</Text>
        </TouchableOpacity>
      </View>

      {/* 分类导航 */}
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        style={styles.categoryContainer}
      >
        {categories.map(category => (
          <TouchableOpacity
            key={category.id}
            style={[
              styles.categoryButton,
              selectedCategory === category.id && styles.categoryButtonActive,
            ]}
            onPress={() => setSelectedCategory(category.id)}
          >
            <Text
              style={[
                styles.categoryButtonText,
                selectedCategory === category.id && styles.categoryButtonTextActive,
              ]}
            >
              {category.name}
            </Text>
          </TouchableOpacity>
        ))}
      </ScrollView>

      {/* 排序选项 */}
      <View style={styles.sortContainer}>
        {sortOptions.map(option => (
          <TouchableOpacity
            key={option.id}
            style={[
              styles.sortButton,
              selectedSort === option.id && styles.sortButtonActive,
            ]}
            onPress={() => setSelectedSort(option.id)}
          >
            <Text
              style={[
                styles.sortButtonText,
                selectedSort === option.id && styles.sortButtonTextActive,
              ]}
            >
              {option.name}
            </Text>
          </TouchableOpacity>
        ))}
      </View>

      {/* 剧集列表 */}
      <FlatList
        data={filteredDramas}
        renderItem={renderDramaCard}
        keyExtractor={(item) => item.id}
        numColumns={2}
        columnWrapperStyle={styles.row}
        contentContainerStyle={styles.listContent}
        showsVerticalScrollIndicator={false}
        ListEmptyComponent={
          <View style={styles.emptyContainer}>
            <Text style={styles.emptyText}>没有找到相关剧集</Text>
          </View>
        }
      />
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  searchBar: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: 12,
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  searchInputContainer: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#f0f0f0',
    borderRadius: 20,
    paddingHorizontal: 12,
    marginRight: 12,
  },
  searchIcon: {
    marginRight: 8,
    fontSize: 16,
  },
  searchInput: {
    flex: 1,
    height: 40,
    fontSize: 14,
    color: '#333',
  },
  filterButton: {
    paddingHorizontal: 12,
    paddingVertical: 8,
    backgroundColor: '#007AFF',
    borderRadius: 16,
  },
  filterButtonText: {
    color: '#fff',
    fontSize: 14,
    fontWeight: '500',
  },
  categoryContainer: {
    backgroundColor: '#fff',
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  categoryButton: {
    paddingHorizontal: 16,
    paddingVertical: 6,
    marginHorizontal: 4,
    borderRadius: 16,
    backgroundColor: '#f0f0f0',
  },
  categoryButtonActive: {
    backgroundColor: '#007AFF',
  },
  categoryButtonText: {
    fontSize: 14,
    color: '#333',
  },
  categoryButtonTextActive: {
    color: '#fff',
    fontWeight: '500',
  },
  sortContainer: {
    flexDirection: 'row',
    paddingHorizontal: 16,
    paddingVertical: 12,
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  sortButton: {
    marginRight: 16,
  },
  sortButtonActive: {
    borderBottomWidth: 2,
    borderBottomColor: '#007AFF',
  },
  sortButtonText: {
    fontSize: 14,
    color: '#666',
  },
  sortButtonTextActive: {
    color: '#007AFF',
    fontWeight: '500',
  },
  listContent: {
    padding: 12,
  },
  row: {
    justifyContent: 'space-between',
    marginBottom: 12,
  },
  dramaCard: {
    width: ITEM_WIDTH,
    backgroundColor: '#fff',
    borderRadius: 8,
    overflow: 'hidden',
    elevation: 2,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 4,
  },
  coverContainer: {
    position: 'relative',
    width: '100%',
    height: ITEM_WIDTH * 1.4,
    backgroundColor: '#f0f0f0',
  },
  coverWrapper: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  coverPlaceholder: {
    fontSize: 14,
    color: '#999',
  },
  statusBadge: {
    position: 'absolute',
    bottom: 8,
    right: 8,
    paddingHorizontal: 8,
    paddingVertical: 4,
    backgroundColor: 'rgba(0, 0, 0, 0.6)',
    borderRadius: 4,
  },
  statusText: {
    color: '#fff',
    fontSize: 12,
  },
  dramaTitle: {
    fontSize: 14,
    fontWeight: '500',
    color: '#333',
    padding: 8,
  },
  dramaInfo: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingHorizontal: 8,
    paddingBottom: 8,
  },
  categoryText: {
    fontSize: 12,
    color: '#666',
  },
  popularityText: {
    fontSize: 12,
    color: '#999',
  },
  emptyContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingVertical: 60,
  },
  emptyText: {
    fontSize: 16,
    color: '#999',
  },
});

export default FindDramaScreen;