class LoginModel {
  bool? success;
  String? expiresAt;
  String? requestToken;
  String? sessionID;
  String? accountID;

  LoginModel({this.success, this.expiresAt, this.requestToken,this.sessionID,this.accountID});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    expiresAt = json['expires_at'];
    requestToken = json['request_token'];
    sessionID = json['session_id'];
    accountID = json['account_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['expires_at'] = expiresAt;
    data['request_token'] = requestToken;
    data['session_id'] = sessionID;
    data['account_id'] = accountID;
    return data;
  }
}
