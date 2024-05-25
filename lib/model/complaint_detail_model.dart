class ComplaintDetailModel {
  List<Data>? data;
  int? responseCode;
  String? message;
  int? totalRecords;
  int? pageSize;
  int? pageIndex;
  int? totalRecordsInResponse;

  ComplaintDetailModel(
      {this.data,
      this.responseCode,
      this.message,
      this.totalRecords,
      this.pageSize,
      this.pageIndex,
      this.totalRecordsInResponse});

  ComplaintDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? createdOn;
  String? customerId;
  String? outletId;
  String? createdById;
  String? assetId;
  int? priorityId;
  int? statusId;
  String? otherInfo;
  String? assignedOn;
  List<AssignedPeople>? assigned;
  List<Problems>? problems;
  List<Parts>? parts;
  String? fixWorks;
  String? customer;
  String? outlet;
  String? address;
  String? latitude;
  String? longitude;
  String? route;
  String? status;
  String? priority;
  String? createdBy;
  String? workStart;
  String? workEnd;
  String? updatedOn;
  String? profomaInvoiceId;
  String? invoicedOn;
  int? travelingHour;
  String? approvedById;
  String? approvedBy;
  String? approvedOn;
  int? issueTypeId;
  String? issueType;
  String? workingDetails;

  Data(
      {this.id,
      this.createdOn,
      this.customerId,
      this.outletId,
      this.createdById,
      this.assetId,
      this.priorityId,
      this.statusId,
      this.otherInfo,
      this.assignedOn,
      this.assigned,
      this.problems,
      this.parts,
      this.fixWorks,
      this.customer,
      this.outlet,
      this.address,
      this.latitude,
      this.longitude,
      this.route,
      this.status,
      this.priority,
      this.createdBy,
      this.workStart,
      this.workEnd,
      this.updatedOn,
      this.profomaInvoiceId,
      this.invoicedOn,
      this.travelingHour,
      this.approvedById,
      this.approvedBy,
      this.approvedOn,
      this.issueTypeId,
      this.issueType,
      this.workingDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdOn = json['createdOn'];
    customerId = json['customerId'];
    outletId = json['outletId'];
    createdById = json['createdById'];
    assetId = json['assetId'];
    priorityId = json['priorityId'];
    statusId = json['statusId'];
    otherInfo = json['otherInfo'];
    assignedOn = json['assignedOn'];
    if (json['assigned'] != null) {
      assigned = <AssignedPeople>[];
      json['assigned'].forEach((v) {
        assigned!.add(new AssignedPeople.fromJson(v));
      });
    }
    if (json['problems'] != null) {
      problems = <Problems>[];
      json['problems'].forEach((v) {
        problems!.add(new Problems.fromJson(v));
      });
    }
    if (json['parts'] != null) {
      parts = <Parts>[];
      json['parts'].forEach((v) {
        parts!.add(new Parts.fromJson(v));
      });
    }
    fixWorks = json['fixWorks'];
    customer = json['customer'];
    outlet = json['outlet'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    route = json['route'];
    status = json['status'];
    priority = json['priority'];
    createdBy = json['createdBy'];
    workStart = json['workStart'];
    workEnd = json['workEnd'];
    updatedOn = json['updatedOn'];
    profomaInvoiceId = json['profomaInvoiceId'];
    invoicedOn = json['invoicedOn'];
    travelingHour = json['travelingHour'];
    approvedById = json['approvedById'];
    approvedBy = json['approvedBy'];
    approvedOn = json['approvedOn'];
    issueTypeId = json['issueTypeId'];
    issueType = json['issueType'];
    workingDetails = json['workingDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdOn'] = this.createdOn;
    data['customerId'] = this.customerId;
    data['outletId'] = this.outletId;
    data['createdById'] = this.createdById;
    data['assetId'] = this.assetId;
    data['priorityId'] = this.priorityId;
    data['statusId'] = this.statusId;
    data['otherInfo'] = this.otherInfo;
    data['assignedOn'] = this.assignedOn;
    if (this.assigned != null) {
      data['assigned'] = this.assigned!.map((v) => v.toJson()).toList();
    }
    if (this.problems != null) {
      data['problems'] = this.problems!.map((v) => v.toJson()).toList();
    }
    if (this.parts != null) {
      data['parts'] = this.parts!.map((v) => v.toJson()).toList();
    }
    data['fixWorks'] = this.fixWorks;
    data['customer'] = this.customer;
    data['outlet'] = this.outlet;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['route'] = this.route;
    data['status'] = this.status;
    data['priority'] = this.priority;
    data['createdBy'] = this.createdBy;
    data['workStart'] = this.workStart;
    data['workEnd'] = this.workEnd;
    data['updatedOn'] = this.updatedOn;
    data['profomaInvoiceId'] = this.profomaInvoiceId;
    data['invoicedOn'] = this.invoicedOn;
    data['travelingHour'] = this.travelingHour;
    data['approvedById'] = this.approvedById;
    data['approvedBy'] = this.approvedBy;
    data['approvedOn'] = this.approvedOn;
    data['issueTypeId'] = this.issueTypeId;
    data['issueType'] = this.issueType;
    data['workingDetails'] = this.workingDetails;
    return data;
  }
}

class AssignedPeople {
  int? id;
  int? jobId;
  String? assignedToId;
  String? assignedTo;
  String? assignedOn;
  String? assignedById;
  String? mobileNumber;

  AssignedPeople(
      {this.id,
      this.jobId,
      this.assignedToId,
      this.assignedTo,
      this.assignedOn,
      this.assignedById,
      this.mobileNumber});

  AssignedPeople.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['jobId'];
    assignedToId = json['assignedToId'];
    assignedTo = json['assignedTo'];
    assignedOn = json['assignedOn'];
    assignedById = json['assignedById'];
    mobileNumber = json['mobileNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jobId'] = this.jobId;
    data['assignedToId'] = this.assignedToId;
    data['assignedTo'] = this.assignedTo;
    data['assignedOn'] = this.assignedOn;
    data['assignedById'] = this.assignedById;
    data['mobileNumber'] = this.mobileNumber;
    return data;
  }
}

class Problems {
  int? id;
  int? jobId;
  int? problemId;
  String? problem;

  Problems({this.id, this.jobId, this.problemId, this.problem});

  Problems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['jobId'];
    problemId = json['problemId'];
    problem = json['problem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jobId'] = this.jobId;
    data['problemId'] = this.problemId;
    data['problem'] = this.problem;
    return data;
  }
}

class Parts {
  int? id;
  int? jobId;
  String? partId;
  int? qty;
  num? price;
  String? sparePartNameAR;
  String? sparePartName;
  String? sparePartCode;

  Parts(
      {this.id,
      this.jobId,
      this.partId,
      this.qty,
      this.price,
      this.sparePartNameAR,
      this.sparePartName,
      this.sparePartCode});

  Parts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['jobId'];
    partId = json['partId'];
    qty = json['qty'];
    price = json['price'];
    sparePartNameAR = json['sparePartName_AR'];
    sparePartName = json['sparePartName'];
    sparePartCode = json['sparePartCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jobId'] = this.jobId;
    data['partId'] = this.partId;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['sparePartName_AR'] = this.sparePartNameAR;
    data['sparePartName'] = this.sparePartName;
    data['sparePartCode'] = this.sparePartCode;
    return data;
  }
}
