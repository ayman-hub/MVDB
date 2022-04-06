class RequestLoginModel {
  String? username;
  String? password;
  String? requestToken;

  RequestLoginModel({this.username, this.password, this.requestToken});

  RequestLoginModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    requestToken = json['request_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['request_token'] = requestToken.toString();
    return data;
  }
}
