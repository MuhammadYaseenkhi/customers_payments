class UserLoginModel {
  Data? data;
  int? responseCode;
  String? message;
  int? totalRecords;
  int? pageSize;
  int? pageIndex;
  int? totalRecordsInResponse;

  UserLoginModel(
      {this.data,
        this.responseCode,
        this.message,
        this.totalRecords,
        this.pageSize,
        this.pageIndex,
        this.totalRecordsInResponse});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    responseCode = json['responseCode'];
    message = json['message'];
    totalRecords = json['totalRecords'];
    pageSize = json['pageSize'];
    pageIndex = json['pageIndex'];
    totalRecordsInResponse = json['totalRecordsInResponse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['responseCode'] = this.responseCode;
    data['message'] = this.message;
    data['totalRecords'] = this.totalRecords;
    data['pageSize'] = this.pageSize;
    data['pageIndex'] = this.pageIndex;
    data['totalRecordsInResponse'] = this.totalRecordsInResponse;
    return data;
  }
}

class Data {
  String? userID;
  String? firstName;
  String? lastName;
  String? email;
  String? error;
  String? token;
  String? userProfilePicUrl;
  String? accountHolderID;
  bool? isActive;

  Data(
      {this.userID,
        this.firstName,
        this.lastName,
        this.email,
        this.error,
        this.token,
        this.userProfilePicUrl,
        this.accountHolderID,
        this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    error = json['error'];
    token = json['token'];
    userProfilePicUrl = json['userProfilePicUrl'];
    accountHolderID = json['accountHolderID'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['error'] = this.error;
    data['token'] = this.token;
    data['userProfilePicUrl'] = this.userProfilePicUrl;
    data['accountHolderID'] = this.accountHolderID;
    data['isActive'] = this.isActive;
    return data;
  }
}