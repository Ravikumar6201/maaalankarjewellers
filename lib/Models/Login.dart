// ignore_for_file: file_names, unnecessary_this

class MobileVarify {
  dynamic status;
  dynamic sessionId;
  dynamic timestamp;

  MobileVarify({this.status, this.sessionId, this.timestamp});

  MobileVarify.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sessionId = json['session_id'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['session_id'] = this.sessionId;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class LoginResponse {
  dynamic token;
  dynamic userId;
  dynamic profileStatus;
  dynamic message;
  dynamic status;

  LoginResponse(
      {this.token, this.userId, this.profileStatus, this.message, this.status});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['user_id'];
    profileStatus = json['profile_status'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['user_id'] = this.userId;
    data['profile_status'] = this.profileStatus;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
