import 'dart:convert';
import 'dart:io';
import 'package:customers_payments/core/app_export.dart';
import 'package:customers_payments/model/beneficiary_account_model.dart';
import 'package:customers_payments/views/utils/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/api_service.dart';
import '../../widgets/custom_elevated_button.dart';
import '../pdf_veiwer.dart';
import 'package:http/http.dart' as http;

SharedPreferences? prefs;
String? token;
String? userId;
String imgUrl = 'http://cokerecon.3em.tech/';

class SubmissionPreview extends StatefulWidget {
  final String filePath;
  final String fileName;
  final String fromAccNo;
  final String date;
  final String amount;
  final String beneficiaryAcc;
  final String beneficiary;
  final String refNo;
  final String details;
  final String outletId;
  final String id;
  final bool urlOrLocal;
  final bool edit;
  final VoidCallback onClosed;

  const SubmissionPreview({super.key,
    required this.onClosed,
    required this.filePath,
    this.fileName = '',
    required this.urlOrLocal,
    this.fromAccNo = '',
    this.id = '',
    this.date = '',
    this.amount = '',
    this.beneficiaryAcc = '',
    this.beneficiary = '',
    this.refNo = '',
    this.details = '',
    this.outletId = '',
    required this.edit
  });

  @override
  _SubmissionPreviewState createState() => _SubmissionPreviewState();
}

class _SubmissionPreviewState extends State<SubmissionPreview> {
  TextEditingController dateController = TextEditingController();
  TextEditingController fromAccController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController beneficiaryController = TextEditingController();
  TextEditingController refController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  BeneficiaryModel? selectedBeneficiaryAccount ; // Selected beneficiary account
  List<BeneficiaryModel> beneficiaryAccounts = [];
  String? selectedBAccount;
  String? avlDate;
  DateTime? selectedDate;
  void voidCallback ;



  Future<void> addNew(String outletId) async {
   // String formattedDateString = selectedDate!.toUtc().toIso8601String();
    if(selectedBAccount!.isEmpty){
      Fluttertoast.showToast(
          msg: 'Please Select Beneficiary Account');
      return;
    }
    if(amountController.text.isEmpty){
      Fluttertoast.showToast(
          msg: 'Please Set Amount');
      return;
    }
    if(avlDate == null){
      Fluttertoast.showToast(
          msg: 'Please select Date');
      return;
    }
    await EasyLoading.show(status: 'Please Wait...');
    var jsonData;
    //DateTime originalDate = DateTime.parse(dateController.text);

    var url = Uri.parse(ApiService().baseUrl + ApiService().addNewAccountEndPoint);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final Map<String, dynamic> requestBody = {
      "fK_Customer_ID": outletId,
      "dateOfDeposit": avlDate,
      "userFileName": widget.fileName,
      "filePath": widget.filePath,
      "toAccountNumber":selectedBAccount,
      "fromAccountNumber": fromAccController.text,
      "amount": amountController.text,
      "referenceNumber": refController.text,
      "typeOfTransaction": detailController.text,
      "toAccountNameEnglish": beneficiaryController.text
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      jsonData = jsonDecode(response.body);
      if(jsonData['message'] == "Record added successfully.") {
        Fluttertoast.showToast(
            msg: jsonData['message']);
        Navigator.pop(context);
      }
    } else {
      EasyLoading.dismiss();
      print("${response.statusCode}");
      Fluttertoast.showToast(
          msg: jsonData['message']);
      throw Exception('Failed to get user');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = DateTime(picked.year, picked.month, picked.day);
        avlDate = "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> update(String outletId) async {
    if(selectedBAccount!.isEmpty){
      Fluttertoast.showToast(
          msg: 'Please Select Beneficiary Account');
      return;
    }
    if(fromAccController.text.isEmpty){
      Fluttertoast.showToast(
          msg: 'Please input From Account No');
      return;
    }
    if(amountController.text.isEmpty){
      Fluttertoast.showToast(
          msg: 'Please Set Amount');
      return;
    }
    if(avlDate!.isEmpty){
      Fluttertoast.showToast(
          msg: 'Please select Date');
      return;
    }
    await EasyLoading.show(status: 'Please Wait...');
    var jsonData;
   // DateTime originalDate = DateTime.parse(dateController.text);

    var url = Uri.parse(ApiService().baseUrl + ApiService().updateAccountEndPoint);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final Map<String, dynamic> requestBody = {
      "fK_Customer_ID": outletId,
      "dateOfDeposit": avlDate,
      "userFileName": widget.fileName,
      "id": widget.id,
      "filePath": widget.filePath,
      "toAccountNumber":selectedBAccount,
      "fromAccountNumber": fromAccController.text,
      "amount": amountController.text,
      "referenceNumber": refController.text,
      "typeOfTransaction": detailController.text,
      "toAccountNameEnglish": beneficiaryController.text
    };
    final response = await http.put(
      url,
      headers:headers,
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      jsonData = jsonDecode(response.body);
      if(jsonData['message'] == "Record updated successfully.") {
        Fluttertoast.showToast(
            msg: jsonData['message']);
        Navigator.pop(context,);
        voidCallback;
      }
      else{
        Fluttertoast.showToast(
            msg: jsonData['message']);
      }
    } else {
      EasyLoading.dismiss();
     /* Fluttertoast.showToast(
          msg: jsonData['message']);*/
      throw Exception('Failed to get data');

    }
  }


  Future<void> getBeneficiary() async {
    await EasyLoading.show(status: 'Fetching Data...');
    final Uri uri = Uri.parse(ApiService().baseUrl +
        ApiService().beneficiaryListEndPoint); // Replace with your API endpoint
    Map<String, String> headers = {
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(uri,headers: headers);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      setState(() {
        beneficiaryAccounts = jsonData.map((data) => BeneficiaryModel.fromJson(data)).toList();
      });
    }
     else {
      EasyLoading.dismiss();
      throw Exception('Failed to load complaints');
    }
  }

  sharedPref() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs?.getString('token')!;
    userId = prefs?.getString('userID')!;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPref();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
   // fromAccController.text = widget.fromAccNo;
    voidCallback =  widget.onClosed();
    amountController.text = widget.amount;
    beneficiaryController.text = widget.beneficiary;
    refController.text = widget.refNo;
    detailController.text = widget.details;
    dateController.text = widget.date;
    getBeneficiary();
    selectedBAccount = widget.beneficiaryAcc;
    if(widget.edit){
      String dateString = widget.date;
      // Parse the string to DateTime
      selectedDate = DateTime.parse(dateString);
      // Format the DateTime to get only the date
       avlDate = "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";

      dateController.text = avlDate!;
      print("Original String: $dateString");
      print("Formatted Date: $avlDate");
     // selectedDate = DateTime.now();
    }

   // selectedDate = DateTime.tryParse(widget.date);
    // Set a default beneficiary if one is provided
    //BeneficiaryModel defaultBeneficiary = BeneficiaryModel(accountNumber: widget.beneficiaryAcc);  // Replace with your actual default value
    //selectedBeneficiaryAccount =  beneficiaryAccounts.contains(defaultBeneficiary) ? defaultBeneficiary : null;
    // Find the corresponding BeneficiaryModel based on the account number
   // selectedBeneficiaryAccount =  beneficiaryAccounts.contains(defaultBeneficiary) ? defaultBeneficiary : null;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

/*  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    )) ?? DateTime.now();

    if (pickedDate != null && pickedDate != dateController.text) {
      setState(() {
        dateController.text = pickedDate.toString();
      });
    }
  }*/
  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (!widget.urlOrLocal) {
      imageWidget = Image.file(
        File(widget.filePath),
        fit: BoxFit.contain,
      );
    } else if (widget.urlOrLocal) {
      imageWidget = PhotoView(imageProvider: NetworkImage(imgUrl + widget.filePath,));
          /*Image.network(
       imgUrl + widget.filePath,
        scale: 1,
        fit: BoxFit.contain,
      );*/
    } else {
      imageWidget = Container(); // Placeholder if both paths are empty
    }
    // Check if selectedBAccount is not null or emptys
    if (selectedBAccount != null && selectedBAccount!.isNotEmpty) {
      // Find the matching account based on account number
      BeneficiaryModel? matchingAccount = beneficiaryAccounts.firstWhere(
            (account) => account.accountNumber == selectedBAccount,
        orElse: () => BeneficiaryModel(accountNumber: selectedBAccount),);

      // Set the matching account as the initial selected value
      if (matchingAccount != null) {
        selectedBeneficiaryAccount = matchingAccount;
      }
    }
    return Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20,top: 50,bottom: 20), // Adding padding around the image
              child: Container(
                child: widget.filePath.endsWith('.pdf')
                    ? PdfViewer(filePath:  imgUrl+widget.filePath)
                    : PhotoView(imageProvider: NetworkImage(imgUrl + widget.filePath,scale: 1),gaplessPlayback: true,),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,top: 50,bottom: 20),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'From Acc No.',
                      border: OutlineInputBorder(),
                    ),
                    controller: fromAccController,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: selectedDate != null
                          ? "${selectedDate?.toLocal()}".split(' ')[0]
                          :  dateController.text,
                    ),
                        onTap: () => _selectDate(context),
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                    controller:amountController,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: DropdownButton<BeneficiaryModel>(
                      value: selectedBeneficiaryAccount,
                      hint: const Text('Select Beneficiary Account'),
                      onChanged: (BeneficiaryModel? newValue) {
                        setState(() {
                          selectedBeneficiaryAccount = newValue!;
                          selectedBAccount = newValue.accountNumber;
                        });
                      },
                      items: beneficiaryAccounts
                          .map((BeneficiaryModel account) =>
                          DropdownMenuItem<BeneficiaryModel>(
                            value: account,
                            key: UniqueKey(), // Add a unique key to each DropdownMenuItem
                            child: Text(account.bankName!),
                          ))
                          .toList(),
                    )
                  ),

                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Beneficiary',
                      border: OutlineInputBorder(),
                    ),
                    controller: beneficiaryController,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Ref No.',
                      border: OutlineInputBorder(),
                    ),
                    controller:refController,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Details',
                      border: OutlineInputBorder(),
                    ),
                    controller:detailController,
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    onTap: () {
                      if(!widget.edit) {
                        addNew(widget.outletId);
                      }else{
                        update(widget.outletId);
                      }
                      // Navigator.pushNamed(context, '/complaint_Details/start_complaint', arguments: complaintDetailModel);
                    },
                    width: 135.h,
                    text: "Submit".tr,
                    buttonStyle: CustomButtonStyles.redButton,
                    alignment: Alignment.center,
                  ),
                ],
              ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
