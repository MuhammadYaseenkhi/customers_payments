class ImageUploadModel {
  DataImg? data;
  int? responseCode;
  String? message;
  int? totalRecords;
  int? pageSize;
  int? pageIndex;
  int? totalRecordsInResponse;

  ImageUploadModel(
      {this.data,
        this.responseCode,
        this.message,
        this.totalRecords,
        this.pageSize,
        this.pageIndex,
        this.totalRecordsInResponse});

  ImageUploadModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DataImg.fromJson(json['data']) : null;
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

class DataImg {
  String? id;
  String? fKCustomerID;
  String? dateOfDeposit;
  String? userFileName;
  String? filePath;
  String? toAccountNumber;
  String? toAccountNameArabic;
  String? toAccountNameEnglish;
  String? fromAccountNumber;
  String? fromAccountName;
  int? amount;
  String? narration;
  String? referenceNumber;
  String? typeOfTransaction;
  String? fileContent;
  String? channel;

  DataImg(
      {this.id,
        this.fKCustomerID,
        this.dateOfDeposit,
        this.userFileName,
        this.filePath,
        this.toAccountNumber,
        this.toAccountNameArabic,
        this.toAccountNameEnglish,
        this.fromAccountNumber,
        this.fromAccountName,
        this.amount,
        this.narration,
        this.referenceNumber,
        this.typeOfTransaction,
        this.fileContent,
        this.channel});

  DataImg.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fKCustomerID = json['fK_Customer_ID'];
    dateOfDeposit = json['dateOfDeposit'];
    userFileName = json['userFileName'];
    filePath = json['filePath'];
    toAccountNumber = json['toAccountNumber'];
    toAccountNameArabic = json['toAccountNameArabic'];
    toAccountNameEnglish = json['toAccountNameEnglish'];
    fromAccountNumber = json['fromAccountNumber'];
    fromAccountName = json['fromAccountName'];
    amount = json['amount'];
    narration = json['narration'];
    referenceNumber = json['referenceNumber'];
    typeOfTransaction = json['typeOfTransaction'];
    fileContent = json['fileContent'];
    channel = json['channel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fK_Customer_ID'] = this.fKCustomerID;
    data['dateOfDeposit'] = this.dateOfDeposit;
    data['userFileName'] = this.userFileName;
    data['filePath'] = this.filePath;
    data['toAccountNumber'] = this.toAccountNumber;
    data['toAccountNameArabic'] = this.toAccountNameArabic;
    data['toAccountNameEnglish'] = this.toAccountNameEnglish;
    data['fromAccountNumber'] = this.fromAccountNumber;
    data['fromAccountName'] = this.fromAccountName;
    data['amount'] = this.amount;
    data['narration'] = this.narration;
    data['referenceNumber'] = this.referenceNumber;
    data['typeOfTransaction'] = this.typeOfTransaction;
    data['fileContent'] = this.fileContent;
    data['channel'] = this.channel;
    return data;
  }
}