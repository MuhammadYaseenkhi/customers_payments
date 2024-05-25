class CustomerDetailModel {
  DataC? data;
  int? responseCode;
  String? message;
  int? totalRecords;
  int? pageSize;
  int? pageIndex;
  int? totalRecordsInResponse;

  CustomerDetailModel(
      {this.data,
        this.responseCode,
        this.message,
        this.totalRecords,
        this.pageSize,
        this.pageIndex,
        this.totalRecordsInResponse});

  CustomerDetailModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DataC.fromJson(json['data']) : null;
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

class DataC {
  String? id;
  String? region;
  String? arRegion;
  String? location;
  String? arLocation;
  String? route;
  String? outletNumber;
  String? outletName;
  String? arabicOutletName;
  String? address;
  String? arabicAddress;
  String? buildingNo;
  String? postalCode;
  String? districtORCity;
  String? grade;
  String? tradeChannels;
  String? arTradeChannel;
  String? subTradeChannel;
  String? crLimit;
  String? crDays;
  String? crNumber;
  String? vatNumber;
  String? telephone;
  String? exclSName;
  String? exclusivityName;
  String? contracted;
  String? latitude;
  String? longitude;
  String? grdCode;
  String? grdDesc;
  String? segment;
  String? weekNo;
  String? sat;
  String? sun;
  String? mon;
  String? tue;
  String? wed;
  String? thur;
  String? fri;
  String? noDay;
  String? total;
  Null? customerOutletID;

  DataC(
      {this.id,
        this.region,
        this.arRegion,
        this.location,
        this.arLocation,
        this.route,
        this.outletNumber,
        this.outletName,
        this.arabicOutletName,
        this.address,
        this.arabicAddress,
        this.buildingNo,
        this.postalCode,
        this.districtORCity,
        this.grade,
        this.tradeChannels,
        this.arTradeChannel,
        this.subTradeChannel,
        this.crLimit,
        this.crDays,
        this.crNumber,
        this.vatNumber,
        this.telephone,
        this.exclSName,
        this.exclusivityName,
        this.contracted,
        this.latitude,
        this.longitude,
        this.grdCode,
        this.grdDesc,
        this.segment,
        this.weekNo,
        this.sat,
        this.sun,
        this.mon,
        this.tue,
        this.wed,
        this.thur,
        this.fri,
        this.noDay,
        this.total,
        this.customerOutletID});

  DataC.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    region = json['region'];
    arRegion = json['ar_Region'];
    location = json['location'];
    arLocation = json['ar_Location'];
    route = json['route'];
    outletNumber = json['outletNumber'];
    outletName = json['outletName'];
    arabicOutletName = json['arabicOutletName'];
    address = json['address'];
    arabicAddress = json['arabicAddress'];
    buildingNo = json['buildingNo'];
    postalCode = json['postalCode'];
    districtORCity = json['districtORCity'];
    grade = json['grade'];
    tradeChannels = json['tradeChannels'];
    arTradeChannel = json['ar_TradeChannel'];
    subTradeChannel = json['subTradeChannel'];
    crLimit = json['crLimit'];
    crDays = json['crDays'];
    crNumber = json['crNumber'];
    vatNumber = json['vatNumber'];
    telephone = json['telephone'];
    exclSName = json['exclSName'];
    exclusivityName = json['exclusivityName'];
    contracted = json['contracted'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    grdCode = json['grdCode'];
    grdDesc = json['grdDesc'];
    segment = json['segment'];
    weekNo = json['weekNo'];
    sat = json['sat'];
    sun = json['sun'];
    mon = json['mon'];
    tue = json['tue'];
    wed = json['wed'];
    thur = json['thur'];
    fri = json['fri'];
    noDay = json['noDay'];
    total = json['total'];
    customerOutletID = json['customerOutletID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['region'] = this.region;
    data['ar_Region'] = this.arRegion;
    data['location'] = this.location;
    data['ar_Location'] = this.arLocation;
    data['route'] = this.route;
    data['outletNumber'] = this.outletNumber;
    data['outletName'] = this.outletName;
    data['arabicOutletName'] = this.arabicOutletName;
    data['address'] = this.address;
    data['arabicAddress'] = this.arabicAddress;
    data['buildingNo'] = this.buildingNo;
    data['postalCode'] = this.postalCode;
    data['districtORCity'] = this.districtORCity;
    data['grade'] = this.grade;
    data['tradeChannels'] = this.tradeChannels;
    data['ar_TradeChannel'] = this.arTradeChannel;
    data['subTradeChannel'] = this.subTradeChannel;
    data['crLimit'] = this.crLimit;
    data['crDays'] = this.crDays;
    data['crNumber'] = this.crNumber;
    data['vatNumber'] = this.vatNumber;
    data['telephone'] = this.telephone;
    data['exclSName'] = this.exclSName;
    data['exclusivityName'] = this.exclusivityName;
    data['contracted'] = this.contracted;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['grdCode'] = this.grdCode;
    data['grdDesc'] = this.grdDesc;
    data['segment'] = this.segment;
    data['weekNo'] = this.weekNo;
    data['sat'] = this.sat;
    data['sun'] = this.sun;
    data['mon'] = this.mon;
    data['tue'] = this.tue;
    data['wed'] = this.wed;
    data['thur'] = this.thur;
    data['fri'] = this.fri;
    data['noDay'] = this.noDay;
    data['total'] = this.total;
    data['customerOutletID'] = this.customerOutletID;
    return data;
  }
}