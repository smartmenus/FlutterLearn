import React,{ Component } from 'react';
import {View, Text} from 'react-native'
type props = {}

export default class Work extends Component<props>{
    constructor(props){
        super(props)
    }

    render(){
        return(
            <View>
                <Text>工作中心</Text>
            </View>
        )
    }
}