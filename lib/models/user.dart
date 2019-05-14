
class User {

  final String user;
  final String userId;
  final String enums;
  final String ename;
  final String sessionid;

  User({this.user, this.userId, this.enums, this.ename, this.sessionid});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      user: json['user'],
      userId: json['userId'],
      enums: json['enum'],
      ename: json['ename'],
      sessionid: json['sessionid'],
    );
  }
}