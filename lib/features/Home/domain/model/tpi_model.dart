class TpiModel {
  String? iD;
  String? userName;

  TpiModel({this.iD, this.userName});

  TpiModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['user_name'] = this.userName;
    return data;
  }
  @override
  String toString() {
    // TODO: implement toString
    return userName.toString();
  }
}