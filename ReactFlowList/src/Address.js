import React, { commonent } from 'react'
import{
    StyleSheet,
    Text,
    View
} from 'react-native'


var Address = React.createClass({
    render(){
       return(
        <View style ={styles.container}>
            <Text style={styles.text}>通讯录</Text>
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
module.exports = Address