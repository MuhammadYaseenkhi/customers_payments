import 'dart:convert';

import 'package:customers_payments/model/user_login_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://api.cokerecon.3em.tech/api'; //DEBUG
  //final String baseUrl = 'https://api.cms.coca-cola.com.sa:8335/api'; //PRODUCTION


  //API ENDPOINT
  final String loginEndPoint = '/Account/Login';
  final String addNewAccountEndPoint = '/DepositSlip/AddNew';
  final String updateAccountEndPoint = '/DepositSlip/Update';
  final String complaintListEndPoint = '/DepositSlip/GetAll';
  final String beneficiaryListEndPoint = '/BankAccount/GetAll';
  final String equipmentByIdEndPoint = '/Customer/GetById?id=';
  final String sparePartGetEndPoint = '/Customer/GetDD';
  final String imgUploadEndPoint = '/DepositSlip/ImageUpload';

  Future<UserLoginModel> login(String email, String password) async {
    await EasyLoading.show(status: 'Please Wait...');
    var jsonData;
    var url = Uri.parse(baseUrl + loginEndPoint);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };
    String requestBodyJson = jsonEncode(requestBody);
    var response = await http.post(
      url,
      headers: headers,
      body: requestBodyJson,
    );
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      jsonData = jsonDecode(response.body);
      Fluttertoast.showToast(
          msg: '${UserLoginModel.fromJson(jsonData).message}');
      return UserLoginModel.fromJson(jsonData);
    } else {
      EasyLoading.dismiss();
      throw Exception('Failed to get user');
    }
  }
}
