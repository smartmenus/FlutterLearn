

class FlowList{

  final String msgId;
  final String tableId;
  final String recordId;
  final String flowId;
  final String msgTitleShort;
  final String msgTitle;
  final String msgReceiver;
  final String msgSender;
  final String msgTime;
  final String flowName;
  final String isRandomFlow;

  FlowList({this.msgId, this.tableId, this.recordId, this.flowId,
            this.msgTitleShort, this.msgTitle, this.msgReceiver,
            this.msgTime, this.msgSender, this.flowName, this.isRandomFlow
  });

  factory FlowList.fromJson(Map<String, dynamic> json){
    return FlowList(
      msgId: json['msgid'],
      tableId: json['tableid'],
      recordId: json['recordid'],
      flowId: json['flowid'],
      msgTitleShort: json['msgtitleshort'],
      msgTitle: json['msgtitle'],
      msgReceiver: json['msgreceiver'],
      msgSender: json['msgsender'],
      msgTime: json['msgtime'],
      flowName: json['flowName'],
      isRandomFlow: json['isRandomFlow'].toString(),
    );
  }
}
