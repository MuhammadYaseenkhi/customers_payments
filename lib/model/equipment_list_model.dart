class EquipmentListModel {
  List<Data>? data;
  int? responseCode;
  String? message;
  int? totalRecords;
  int? pageSize;
  int? pageIndex;
  int? totalRecordsInResponse;

  EquipmentListModel(
      {this.data,
        this.responseCode,
        this.message,
        this.totalRecords,
        this.pageSize,
        this.pageIndex,
        this.totalRecordsInResponse});

  EquipmentListModel.fromJson(Map<String, dynamic> json) {
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
  String? fKAssetsID;
  String? assetName;
  String? serialNumber;
  String? fKCustomerID;
  String? customerName;
  String? customerNameAR;
  int? value;
  String? id;

  Data(
      {this.fKAssetsID,
        this.assetName,
        this.serialNumber,
        this.fKCustomerID,
        this.customerName,
        this.customerNameAR,
        this.value,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    fKAssetsID = json['fK_Assets_ID'];
    assetName = json['assetName'];
    serialNumber = json['serialNumber'];
    fKCustomerID = json['fK_Customer_ID'];
    customerName = json['customerName'];
    customerNameAR = json['customerName_AR'];
    value = json['value'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fK_Assets_ID'] = this.fKAssetsID;
    data['assetName'] = this.assetName;
    data['serialNumber'] = this.serialNumber;
    data['fK_Customer_ID'] = this.fKCustomerID;
    data['customerName'] = this.customerName;
    data['customerName_AR'] = this.customerNameAR;
    data['value'] = this.value;
    data['id'] = this.id;
    return data;
  }
}
