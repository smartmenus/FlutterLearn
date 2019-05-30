/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View, Image} from 'react-native';
import {createStackNavigator, createAppContainer} from 'react-navigation'
import Home from './src/Home'
import Work from './src/Work'

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

const dataSource = [
  {icon:require('./images/tabbar-xiaoxi-normal.png'), selectedIcon:require('./images/tabbar-xiaoxi-selected.png'), tabPage:'Home', tabName:'消息', component:Home},
  {icon:require('./images/tabbar-yingyong-normal.png'), selectedIcon:require('./images/tabbar-yingyong-normal.png'), tabPage:'Work', tabName:'工作', component:Work}
]

var navigation = null

const RootStack = createStackNavigator({
  Home: {
    screen: Home,
  },
  Details: {
    screen: Work,
  },
}, {
    initialRouteName: 'Home',
});

const AppContainer = createAppContainer(RootStack);


type Props = {};
export default class App extends Component<Props> {
  render(){
    return <AppContainer />
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  tabIcon:{
    width:23,
    height:23,
  }
});
