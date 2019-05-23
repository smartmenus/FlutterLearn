import React, { Component }  from 'react'
import {View, StyleSheet, Text} from 'react-native'

var BASE_URL = 'http://cmp.xspinfo.com:90/jsonServer.php';

// var FlowList = React.createClass({
//     render(){
//         return(
//             <View>
//                 <Text>流程</Text>
//             </View>
//         );
//     },

//     componentDidMount() {
//         this.loginServer();
//     },

//     async loginServer(){
//          fetch(BASE_URL, {
//             method: 'POST',
//             headers: {
//              'Accept': 'application/json',
//              'Content-Type': 'application/json',
//            },
//            body: JSON.stringify({'action': 'Login',
//            'cid': '6',
//            'jsonstr': '{"clientVersion":"2.0","souse":"Eomp","pwd":"PPaZJ992560","user":"Pp"}',
//            'stamp': getTimeStamp(),
//            })
//         }).then((response) => response.json()).then((resonponseJson) => resonponseJson.json).then((responseData) =>{
//             console.log(responseData)
//         })  
//      },
 
//      getTimeStamp(){
//          const date = new Date();
//          const currentTimestamp = date.getTime(); //获取当前时间的时间戳
//          timestamp_sc = currentTimestamp + "_SPCMP"
//          var Buffer = require('buffer').Buffer
//          var base64Str= new Buffer(new Buffer(timestamp_sc).toString('utf-8')).toString('base64')
//          console.log(base64Str)
//          return base64Str
//      },
 
// })

var FlowList = React.createClass({
    render(){
       return(
        <View style ={styles.container}>
            <Text style={styles.text}>我</Text>
        </View>
       );
    },
    componentDidMount() {
        this.loginServer();
    },
    async loginServer(){
        console.log('获取数据')
         fetch(BASE_URL, {
            method: 'POST',
            headers: {
             'Accept': 'application/json',
             'Content-Type': 'application/json',
           },
           body: JSON.stringify({'action': 'Login',
           'cid': '6',
           'jsonstr': '{"clientVersion":"2.0","souse":"Eomp","pwd":"PPaZJ992560","user":"Pp"}',
           'stamp': getTimeStamp(),
           })
        }).then((response) => response.json()).then((resonponseJson) => resonponseJson.json).then((responseData) =>{
            console.log(responseData)
        })  
     },
     getTimeStamp(){
        const date = new Date();
        const currentTimestamp = date.getTime(); //获取当前时间的时间戳
        timestamp_sc = currentTimestamp + "_SPCMP"
        var Buffer = require('buffer').Buffer
        var base64Str= new Buffer(new Buffer(timestamp_sc).toString('utf-8')).toString('base64')
        console.log(base64Str)
        return base64Str
    },
    
})

//输出
module.exports = FlowList
