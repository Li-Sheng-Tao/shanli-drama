import React, { useState } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import HomeScreen from '../screens/HomeScreen';
import MainTabNavigator from './MainTabNavigator';
import SettingsScreen from '../screens/SettingsScreen';
import SplashAd from '../components/ads/SplashAd';

const Stack = createNativeStackNavigator();

const AppNavigator = () => {
  const [splashCompleted, setSplashCompleted] = useState(false);

  const handleSplashComplete = () => {
    setSplashCompleted(true);
  };

  if (!splashCompleted) {
    return <SplashAd onAdComplete={handleSplashComplete} />;
  }

  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="Home">
        <Stack.Screen name="Home" component={HomeScreen} options={{ title: '首页' }} />
        <Stack.Screen name="MainTabs" component={MainTabNavigator} options={{ headerShown: false }} />
        <Stack.Screen name="Settings" component={SettingsScreen} options={{ title: '设置' }} />
      </Stack.Navigator>
    </NavigationContainer>
  );
};

export default AppNavigator;
