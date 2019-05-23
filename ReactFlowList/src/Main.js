import React, { commonent } from 'react'
import{
    StyleSheet,
    Text,
    View,
    TabBarIOS,
    NavigatorIOS
} from 'react-native'

var Message = require('../src/Message')
var Work = require('../src/Work')
var Address = require('../src/Address')
var Mine = require('../src/Mine')
var FlowList = require('../src/FlowList')

var Main = React.createClass({
    
    
    getInitialState(){
        return{
            //设置选中
            selectedItem: 'message'   //默认消息被选中
        }
    },
    render(){
       return(
            <TabBarIOS>
                 {/* 消息 */}
                 <TabBarIOS.Item
                 title='消息'
                 selected = {this.state.selectedItem == 'home'}
                 onPress = {()=>{this.setState({selectedItem: 'home'})}}
                 >   
                     <NavigatorIOS
                     style = {{flex: 1}}
                      initialRoute = {
                        {
                          title: '消息',
                          component: FlowList
                        }
                      }
                     ></NavigatorIOS>
                 </TabBarIOS.Item >
                 {/* 工作 */}
                 <TabBarIOS.Item
                 title='工作'
                 selected = {this.state.selectedItem == 'work'}
                 onPress = {()=>{this.setState({selectedItem: 'work'})}}
                 >
                     <NavigatorIOS
                      style = {{flex: 1}}
                      initialRoute = {
                        {
                          title: '工作',
                          component: Work
                        }
                      }
                     ></NavigatorIOS> 
                 </TabBarIOS.Item>
                 {/* 通讯录 */}
                 <TabBarIOS.Item
                 title='通讯录'
                 selected = {this.state.selectedItem == 'address'}
                 onPress = {()=>{this.setState({selectedItem: 'address'})}}
                 >
                     <NavigatorIOS
                      style = {{flex: 1}}
                      initialRoute = {
                        {
                          title: '通讯录',
                          component: Address
                        }
                      }
                     ></NavigatorIOS> 
                 </TabBarIOS.Item>
                 {/* 我的 */}
                 <TabBarIOS.Item
                 title = '我的'
                 selected = {this.state.selectedItem == 'mine'}
                 onPress = {()=>{this.setState({selectedItem:'mine'})}}
                 >
                     <NavigatorIOS
                      style = {{flex: 1}}
                      initialRoute = {
                        {
                          title: '我的',
                          component: Mine
                        }
                      }
                     ></NavigatorIOS>
                 </TabBarIOS.Item>
            </TabBarIOS>
       );
    }
})

const styles = StyleSheet.create({
    container: {
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center',
      backgroundColor: '#F5FCFF',
    },
   text:{
       fontSize:30
   }
  });

//输出
module.exports = Main