import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { Ionicons } from '@expo/vector-icons';
import DramaScreen from '../screens/DramaScreen';
import FindDramaScreen from '../screens/FindDramaScreen';
import WelfareScreen from '../screens/WelfareScreen';
import PersonalCenterScreen from '../screens/PersonalCenterScreen';

const Tab = createBottomTabNavigator();

const MainTabNavigator = () => {
  return (
    <Tab.Navigator
      screenOptions={({ route }) => ({
        tabBarIcon: ({ focused, color, size }) => {
          let iconName;

          if (route.name === '刷刷') {
            iconName = focused ? 'play-circle' : 'play-circle-outline';
          } else if (route.name === '找片') {
            iconName = focused ? 'search' : 'search-outline';
          } else if (route.name === '福利') {
            iconName = focused ? 'gift' : 'gift-outline';
          } else if (route.name === '我的') {
            iconName = focused ? 'person' : 'person-outline';
          }

          return <Ionicons name={iconName} size={size} color={color} />;
        },
        tabBarActiveTintColor: '#007AFF',
        tabBarInactiveTintColor: 'gray',
      })}
    >
      <Tab.Screen name="刷刷" component={DramaScreen} options={{ headerShown: false }} />
      <Tab.Screen name="找片" component={FindDramaScreen} options={{ title: '找片' }} />
      <Tab.Screen name="福利" component={WelfareScreen} options={{ title: '福利' }} />
      <Tab.Screen name="我的" component={PersonalCenterScreen} options={{ title: '我的' }} />
    </Tab.Navigator>
  );
};

export default MainTabNavigator;