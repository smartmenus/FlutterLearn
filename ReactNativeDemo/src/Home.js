import React, { Component } from 'react'
import {
    StyleSheet,
    Text,
    View
} from 'react-native'

type props = {}
export default class Home extends Component <props>{

    render(){
       return(
        <View style = {styles.container}>
            <Text style ={styles.text}>消息中心</Text>
        </View>
       )
    }
}

const styles = StyleSheet.create({
    container:{
      flex:1,
      justifyContent:'center',
      alignItems:'center',
      backgroundColor:'grey'
    },
    text:{
      fontSize:30,
      color:'black'
    }
});
