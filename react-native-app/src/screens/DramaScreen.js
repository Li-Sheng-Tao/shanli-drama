import React, { useState, useRef } from 'react';
import { View, Text, StyleSheet, FlatList, Dimensions, SafeAreaView } from 'react-native';
import VideoPlayer from '../components/VideoPlayer';

const { width, height } = Dimensions.get('window');

// 模拟剧集数据
const dramaEpisodes = [
  {
    id: '1',
    title: '第1集',
    videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    description: '剧情简介：主角开始了他的冒险之旅',
  },
  {
    id: '2',
    title: '第2集',
    videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    description: '剧情简介：主角遇到了新的挑战',
  },
  {
    id: '3',
    title: '第3集',
    videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    description: '剧情简介：主角解决了一个难题',
  },
  {
    id: '4',
    title: '第4集',
    videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    description: '剧情简介：主角发现了一个秘密',
  },
  {
    id: '5',
    title: '第5集',
    videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    description: '剧情简介：主角与朋友团聚',
  },
];

const DramaScreen = () => {
  const [currentEpisode, setCurrentEpisode] = useState(0);

  const handleViewableItemsChanged = useRef(({ viewableItems }) => {
    if (viewableItems.length > 0) {
      setCurrentEpisode(viewableItems[0].index);
    }
  }).current;

  const viewabilityConfig = useRef({
    itemVisiblePercentThreshold: 50,
  }).current;

  const renderItem = ({ item }) => (
    <View style={styles.episodeContainer}>
      <VideoPlayer uri={item.videoUrl} style={styles.videoPlayer} />
      <View style={styles.episodeInfo}>
        <Text style={styles.episodeTitle}>{item.title}</Text>
        <Text style={styles.episodeDescription}>{item.description}</Text>
      </View>
    </View>
  );

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.headerTitle}>刷剧模式</Text>
        <Text style={styles.episodeIndicator}>
          {currentEpisode + 1} / {dramaEpisodes.length}
        </Text>
      </View>
      <FlatList
        data={dramaEpisodes}
        renderItem={renderItem}
        keyExtractor={(item) => item.id}
        horizontal
        pagingEnabled
        showsHorizontalScrollIndicator={false}
        onViewableItemsChanged={handleViewableItemsChanged}
        viewabilityConfig={viewabilityConfig}
        snapToInterval={width}
        decelerationRate="fast"
        snapToAlignment="center"
      />
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#000',
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: 12,
    backgroundColor: 'rgba(0, 0, 0, 0.8)',
  },
  headerTitle: {
    color: '#fff',
    fontSize: 18,
    fontWeight: '600',
  },
  episodeIndicator: {
    color: '#fff',
    fontSize: 14,
    opacity: 0.8,
  },
  episodeContainer: {
    width: width,
    height: height,
  },
  videoPlayer: {
    flex: 1,
  },
  episodeInfo: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    padding: 16,
    backgroundColor: 'rgba(0, 0, 0, 0.7)',
  },
  episodeTitle: {
    color: '#fff',
    fontSize: 18,
    fontWeight: '600',
    marginBottom: 8,
  },
  episodeDescription: {
    color: '#fff',
    fontSize: 14,
    opacity: 0.8,
  },
});

export default DramaScreen;