import React, { useState, useEffect } from 'react';
import { StatusBar, AppState, AppStateStatus } from 'expo-status-bar';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import AppNavigator from './src/navigation/AppNavigator';
import UnlockAd from './src/components/ads/UnlockAd';

export default function App() {
  const [appState, setAppState] = useState(AppState.currentState);
  const [showUnlockAd, setShowUnlockAd] = useState(false);

  useEffect(() => {
    const subscription = AppState.addEventListener('change', handleAppStateChange);
    return () => {
      subscription.remove();
    };
  }, []);

  const handleAppStateChange = (nextAppState) => {
    if (
      appState.match(/inactive|background/) &&
      nextAppState === 'active'
    ) {
      // 应用从后台进入前台，显示解锁广告
      setShowUnlockAd(true);
    }
    setAppState(nextAppState);
  };

  const handleUnlockAdComplete = () => {
    setShowUnlockAd(false);
  };

  return (
    <SafeAreaProvider>
      <AppNavigator />
      <StatusBar style="auto" />
      {showUnlockAd && <UnlockAd onAdComplete={handleUnlockAdComplete} />}
    </SafeAreaProvider>
  );
}
