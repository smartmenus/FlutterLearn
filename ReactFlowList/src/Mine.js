import React, { commonent } from 'react'
import{
    StyleSheet,
    Text,
    View
} from 'react-native'


var Mine = React.createClass({
    render(){
       return(
        <View style ={styles.container}>
            <Text style={styles.text}>消息</Text>
        </View>
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
module.exports = Mine