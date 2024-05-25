class InvoiceDetailModel {
  Data? data;
  int? responseCode;
  String? message;
  int? totalRecords;
  int? pageSize;
  int? pageIndex;
  int? totalRecordsInResponse;

  InvoiceDetailModel(
      {this.data,
        this.responseCode,
        this.message,
        this.totalRecords,
        this.pageSize,
        this.pageIndex,
        this.totalRecordsInResponse});

  InvoiceDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? documentNumber;
  String? issueDate;
  String? deliveryDate;
  String? notes;
  String? fKCustomerID;
  String? customerName;
  String? customerNameAR;
  int? totalLines;
  int? totalTaxBase;
  double? totalTaxes;
  double? totalWithTaxes;
  double? dueAmount;
  String? fKAssetsID;
  String? buildingNumber;
  String? address;
  String? addressAR;
  String? additionalAddress;
  String? additionalAddressAR;
  String? postCode;
  String? additionalAddressNumber;
  String? vatNumber;
  String? city;
  String? district;
  String? country;
  String? region;
  String? supplierName;
  String? buildingNumberSup;
  String? addressSup;
  String? additionalAddressSup;
  String? citySup;
  String? districtSup;
  String? countrySup;
  String? regionSup;
  String? postCodeSup;
  String? additionalAddressNumberSup;
  String? vatNumberSup;
  int? jobID;
  String? customerOutletID;
  String? customerOutletName;
  List<InvoiceProvisionDetail>? invoiceProvisionDetail;
  String? id;

  Data(
      {this.documentNumber,
        this.issueDate,
        this.deliveryDate,
        this.notes,
        this.fKCustomerID,
        this.customerName,
        this.customerNameAR,
        this.totalLines,
        this.totalTaxBase,
        this.totalTaxes,
        this.totalWithTaxes,
        this.dueAmount,
        this.fKAssetsID,
        this.buildingNumber,
        this.address,
        this.addressAR,
        this.additionalAddress,
        this.additionalAddressAR,
        this.postCode,
        this.additionalAddressNumber,
        this.vatNumber,
        this.city,
        this.district,
        this.country,
        this.region,
        this.supplierName,
        this.buildingNumberSup,
        this.addressSup,
        this.additionalAddressSup,
        this.citySup,
        this.districtSup,
        this.countrySup,
        this.regionSup,
        this.postCodeSup,
        this.additionalAddressNumberSup,
        this.vatNumberSup,
        this.jobID,
        this.customerOutletID,
        this.customerOutletName,
        this.invoiceProvisionDetail,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    documentNumber = json['documentNumber'];
    issueDate = json['issueDate'];
    deliveryDate = json['deliveryDate'];
    notes = json['notes'];
    fKCustomerID = json['fK_Customer_ID'];
    customerName = json['customerName'];
    customerNameAR = json['customerName_AR'];
    totalLines = json['totalLines'];
    totalTaxBase = json['totalTaxBase'];
    totalTaxes = json['totalTaxes'];
    totalWithTaxes = json['totalWithTaxes'];
    dueAmount = json['dueAmount'];
    fKAssetsID = json['fK_Assets_ID'];
    buildingNumber = json['buildingNumber'];
    address = json['address'];
    addressAR = json['address_AR'];
    additionalAddress = json['additionalAddress'];
    additionalAddressAR = json['additionalAddress_AR'];
    postCode = json['postCode'];
    additionalAddressNumber = json['additionalAddressNumber'];
    vatNumber = json['vatNumber'];
    city = json['city'];
    district = json['district'];
    country = json['country'];
    region = json['region'];
    supplierName = json['supplierName'];
    buildingNumberSup = json['buildingNumber_Sup'];
    addressSup = json['address_Sup'];
    additionalAddressSup = json['additionalAddress_Sup'];
    citySup = json['city_Sup'];
    districtSup = json['district_Sup'];
    countrySup = json['country_Sup'];
    regionSup = json['region_Sup'];
    postCodeSup = json['postCode_Sup'];
    additionalAddressNumberSup = json['additionalAddressNumber_Sup'];
    vatNumberSup = json['vatNumber_Sup'];
    jobID = json['jobID'];
    customerOutletID = json['customerOutletID'];
    customerOutletName = json['customerOutletName'];
    if (json['invoiceProvisionDetail'] != null) {
      invoiceProvisionDetail = <InvoiceProvisionDetail>[];
      json['invoiceProvisionDetail'].forEach((v) {
        invoiceProvisionDetail!.add(new InvoiceProvisionDetail.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentNumber'] = this.documentNumber;
    data['issueDate'] = this.issueDate;
    data['deliveryDate'] = this.deliveryDate;
    data['notes'] = this.notes;
    data['fK_Customer_ID'] = this.fKCustomerID;
    data['customerName'] = this.customerName;
    data['customerName_AR'] = this.customerNameAR;
    data['totalLines'] = this.totalLines;
    data['totalTaxBase'] = this.totalTaxBase;
    data['totalTaxes'] = this.totalTaxes;
    data['totalWithTaxes'] = this.totalWithTaxes;
    data['dueAmount'] = this.dueAmount;
    data['fK_Assets_ID'] = this.fKAssetsID;
    data['buildingNumber'] = this.buildingNumber;
    data['address'] = this.address;
    data['address_AR'] = this.addressAR;
    data['additionalAddress'] = this.additionalAddress;
    data['additionalAddress_AR'] = this.additionalAddressAR;
    data['postCode'] = this.postCode;
    data['additionalAddressNumber'] = this.additionalAddressNumber;
    data['vatNumber'] = this.vatNumber;
    data['city'] = this.city;
    data['district'] = this.district;
    data['country'] = this.country;
    data['region'] = this.region;
    data['supplierName'] = this.supplierName;
    data['buildingNumber_Sup'] = this.buildingNumberSup;
    data['address_Sup'] = this.addressSup;
    data['additionalAddress_Sup'] = this.additionalAddressSup;
    data['city_Sup'] = this.citySup;
    data['district_Sup'] = this.districtSup;
    data['country_Sup'] = this.countrySup;
    data['region_Sup'] = this.regionSup;
    data['postCode_Sup'] = this.postCodeSup;
    data['additionalAddressNumber_Sup'] = this.additionalAddressNumberSup;
    data['vatNumber_Sup'] = this.vatNumberSup;
    data['jobID'] = this.jobID;
    data['customerOutletID'] = this.customerOutletID;
    data['customerOutletName'] = this.customerOutletName;
    if (this.invoiceProvisionDetail != null) {
      data['invoiceProvisionDetail'] =
          this.invoiceProvisionDetail!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class InvoiceProvisionDetail {
  String? fKNameofGoodsServicesID;
  String? nameofGoods;
  int? unitPrice;
  int? quantity;
  int? taxableAmount;
  int? taxPercentage;
  double? taxValue;
  double? itemSubTotal;
  String? id;

  InvoiceProvisionDetail(
      {this.fKNameofGoodsServicesID,
        this.nameofGoods,
        this.unitPrice,
        this.quantity,
        this.taxableAmount,
        this.taxPercentage,
        this.taxValue,
        this.itemSubTotal,
        this.id});

  InvoiceProvisionDetail.fromJson(Map<String, dynamic> json) {
    fKNameofGoodsServicesID = json['fK_NameofGoods_Services_ID'];
    nameofGoods = json['nameofGoods'];
    unitPrice = json['unitPrice'];
    quantity = json['quantity'];
    taxableAmount = json['taxableAmount'];
    taxPercentage = json['taxPercentage'];
    taxValue = json['taxValue'];
    itemSubTotal = json['itemSubTotal'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fK_NameofGoods_Services_ID'] = this.fKNameofGoodsServicesID;
    data['nameofGoods'] = this.nameofGoods;
    data['unitPrice'] = this.unitPrice;
    data['quantity'] = this.quantity;
    data['taxableAmount'] = this.taxableAmount;
    data['taxPercentage'] = this.taxPercentage;
    data['taxValue'] = this.taxValue;
    data['itemSubTotal'] = this.itemSubTotal;
    data['id'] = this.id;
    return data;
  }
}