class EquipmentByIdModel {
  DataObj? data;
  int? responseCode;
  String? message;
  int? totalRecords;
  int? pageSize;
  int? pageIndex;
  int? totalRecordsInResponse;

  EquipmentByIdModel(
      {this.data,
        this.responseCode,
        this.message,
        this.totalRecords,
        this.pageSize,
        this.pageIndex,
        this.totalRecordsInResponse});

  EquipmentByIdModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  DataObj.fromJson(json['data']) : null;
    responseCode = json['responseCode'];
    message = json['message'];
    totalRecords = json['totalRecords'];
    pageSize = json['pageSize'];
    pageIndex = json['pageIndex'];
    totalRecordsInResponse = json['totalRecordsInResponse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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

class DataObj {
  String? fKAssetsID;
  String? assetName;
  String? serialNumber;
  String? fKCustomerID;
  String? customerName;
  String? customerNameAR;
  num? value;
  int? assetOwnerShip;
  List<dynamic>? sparePartDetailD;
  String? id;

  DataObj(
      {this.fKAssetsID,
        this.assetName,
        this.serialNumber,
        this.fKCustomerID,
        this.customerName,
        this.customerNameAR,
        this.value,
        this.assetOwnerShip,
        this.sparePartDetailD,
        this.id});

  DataObj.fromJson(Map<String, dynamic> json) {
    fKAssetsID = json['fK_Assets_ID'];
    assetName = json['assetName'];
    serialNumber = json['serialNumber'];
    fKCustomerID = json['fK_Customer_ID'];
    customerName = json['customerName'];
    customerNameAR = json['customerName_AR'];
    value = json['value'];
    assetOwnerShip = json['assetOwnerShip'];
   /* if (json['sparePartDetailD'] != null) {
      sparePartDetailD = <dynamic>[];
      json['sparePartDetailD'].forEach((v) {
        sparePartDetailD!.add(fromJson(v));
      });
    }*/
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
    data['assetOwnerShip'] = this.assetOwnerShip;
    if (this.sparePartDetailD != null) {
      data['sparePartDetailD'] =
          this.sparePartDetailD!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}