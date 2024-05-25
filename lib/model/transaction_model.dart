class TransactionModel {
  Data? data;
  int? responseCode;
  String? message;
  int? totalRecords;
  int? pageSize;
  int? pageIndex;
  int? totalRecordsInResponse;

  TransactionModel(
      {this.data,
        this.responseCode,
        this.message,
        this.totalRecords,
        this.pageSize,
        this.pageIndex,
        this.totalRecordsInResponse});

  TransactionModel.fromJson(Map<String, dynamic> json) {
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
  List<TransactionData>? data;
  int? responseCode;
  String? message;
  int? totalRecords;
  int? pageSize;
  int? pageIndex;
  int? totalRecordsInResponse;

  Data(
      {this.data,
        this.responseCode,
        this.message,
        this.totalRecords,
        this.pageSize,
        this.pageIndex,
        this.totalRecordsInResponse});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TransactionData>[];
      json['data'].forEach((v) {
        data!.add(new TransactionData.fromJson(v));
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

class TransactionData {
  String? id;
  String? dateOfDeposit;
  String? toAccountNumber;
  String? toAccountNameArabic;
  String? toAccountNameEnglish;
  String? fromAccountNumber;
  String? fromAccountName;
  double? amount;
  String? narration;
  String? referenceNumber;
  String? typeOfTransaction;
  String? filePath;
  String? userFileName;
  String? fileContent;
  String? fKCustomerID;
  String? channel;
  String? createdDate;

  TransactionData(
      {this.id,
        this.dateOfDeposit,
        this.toAccountNumber,
        this.toAccountNameArabic,
        this.toAccountNameEnglish,
        this.fromAccountNumber,
        this.fromAccountName,
        this.amount,
        this.narration,
        this.referenceNumber,
        this.typeOfTransaction,
        this.filePath,
        this.userFileName,
        this.fileContent,
        this.fKCustomerID,
        this.channel,
        this.createdDate});

  TransactionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateOfDeposit = json['dateOfDeposit'];
    toAccountNumber = json['toAccountNumber'];
    toAccountNameArabic = json['toAccountNameArabic'];
    toAccountNameEnglish = json['toAccountNameEnglish'];
    fromAccountNumber = json['fromAccountNumber'];
    fromAccountName = json['fromAccountName'];
    amount = json['amount'];
    narration = json['narration'];
    referenceNumber = json['referenceNumber'];
    typeOfTransaction = json['typeOfTransaction'];
    filePath = json['filePath'];
    userFileName = json['userFileName'];
    fileContent = json['fileContent'];
    fKCustomerID = json['fK_Customer_ID'];
    channel = json['channel'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dateOfDeposit'] = this.dateOfDeposit;
    data['toAccountNumber'] = this.toAccountNumber;
    data['toAccountNameArabic'] = this.toAccountNameArabic;
    data['toAccountNameEnglish'] = this.toAccountNameEnglish;
    data['fromAccountNumber'] = this.fromAccountNumber;
    data['fromAccountName'] = this.fromAccountName;
    data['amount'] = this.amount;
    data['narration'] = this.narration;
    data['referenceNumber'] = this.referenceNumber;
    data['typeOfTransaction'] = this.typeOfTransaction;
    data['filePath'] = this.filePath;
    data['userFileName'] = this.userFileName;
    data['fileContent'] = this.fileContent;
    data['fK_Customer_ID'] = this.fKCustomerID;
    data['channel'] = this.channel;
    data['createdDate'] = this.createdDate;
    return data;
  }
}