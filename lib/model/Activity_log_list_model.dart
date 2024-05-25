class ActivityLogListModel {
  List<Data>? data;
  int? responseCode;
  String? message;
  int? totalRecords;
  int? pageSize;
  int? pageIndex;
  int? totalRecordsInResponse;

  ActivityLogListModel(
      {this.data,
        this.responseCode,
        this.message,
        this.totalRecords,
        this.pageSize,
        this.pageIndex,
        this.totalRecordsInResponse});

  ActivityLogListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
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
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
  int? id;
  int? jobId;
  String? createdOn;
  String? createdById;
  String? createdBy;
  int? activityTypeId;
  String? activityLogType;
  String? detail;
  String? workStart;
  String? workEnd;

  Data(
      {this.id,
        this.jobId,
        this.createdOn,
        this.createdById,
        this.createdBy,
        this.activityTypeId,
        this.activityLogType,
        this.detail,
        this.workStart,
        this.workEnd});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['jobId'];
    createdOn = json['createdOn'];
    createdById = json['createdById'];
    createdBy = json['createdBy'];
    activityTypeId = json['activityTypeId'];
    activityLogType = json['activityLogType'];
    detail = json['detail'];
    workStart = json['workStart'];
    workEnd = json['workEnd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jobId'] = this.jobId;
    data['createdOn'] = this.createdOn;
    data['createdById'] = this.createdById;
    data['createdBy'] = this.createdBy;
    data['activityTypeId'] = this.activityTypeId;
    data['activityLogType'] = this.activityLogType;
    data['detail'] = this.detail;
    data['workStart'] = this.workStart;
    data['workEnd'] = this.workEnd;
    return data;
  }
}