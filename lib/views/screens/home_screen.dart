import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:customers_payments/app_colors.dart';
import 'package:customers_payments/core/app_export.dart';
import 'package:customers_payments/model/transaction_model.dart';
import 'package:customers_payments/views/screens/complaint_list.dart';
import 'package:customers_payments/views/screens/submission_preview.dart';
import 'package:customers_payments/views/utils/functions/functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../../model/customer_detail_model.dart';
import '../../model/image_upload_model.dart';
import '../../services/api_service.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import 'package:http/http.dart' as http;

import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_search_view.dart';

SharedPreferences? prefs;
String? name;
String? email;
String? branch;
String? token;
String imgUrl = 'http://cokerecon.3em.tech/';

typedef void RefreshListCallback();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>  with WidgetsBindingObserver{

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic selectedValueSingleDialog;
  final equipmentDropCtrl = TextEditingController();
  List<Asset> dropdownItems = [];
  List<DropdownMenuItem<Asset>> items = [];
  List<TransactionData> transactions = [
    /*TransactionData(
      fromAccountNumber: 'dsdfsdfsdf',
      dateOfDeposit: 'dfsfsadasd',
      referenceNumber: 'asdasdasdas',
      toAccountNumber: 'pqwoeiuwqoueqwre',
      amount: 123
    )*/
  ];
  int? results;
  String? outletId;
  bool showDetail = false;
  DataC equipmentIdModel = DataC();
  DataImg imgUploadModel = DataImg();



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getSharedPref();
    fetchData().then((data) {
      setState(() {
        name = data; // Set the name when data arrives
      });
    });
    getPartsListData("1");
  }




  Future<String?> fetchData() async {
    // Simulated asynchronous data fetching, replace this with your actual data fetching logic
    await Future.delayed(const Duration(seconds: 2)); // Simulating delay
    return name; // Replace this with your fetched data
  }

  getSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs?.getString('name')!;
    email = prefs?.getString('email')!;
    token = prefs?.getString('token')!;
    log('Id: ${prefs?.getString('userID')}');
  }
  Future<void> getPartsListData(String searchKey) async {
    await EasyLoading.show(status: 'Fetching Data...');
    var url =
    Uri.parse(ApiService().baseUrl + ApiService().sparePartGetEndPoint);
    Map<String, String> headers = {
       //'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var map = <String, dynamic>{};
    map['take'] = '100';
    map['page'] = '1';
    map['pageSize'] = '300';
    map['skip'] = '0';
    map['sort[0][field]'] = 'id';
    map['sort[0][dir]'] = 'asc';
    map['filter[logic]'] = 'or';
    map['filter[filters][0][value]'] = searchKey;
    map['filter[filters][0][field]'] = 'OutletNumber';
    map['filter[filters][0][operator]'] = 'startswith';
    map['filter[filters][0][ignoreCase]'] = 'true';
    map['filter[logic]'] = 'or';
    map['filter[filters][1][value]'] = searchKey;
    map['filter[filters][1][field]'] = 'OutletName';
    map['filter[filters][1][operator]'] = 'startswith';
    final response = await http.post(url, body: map,headers: headers);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> data = responseData['data'];
      int? record = responseData['totalRecordsInResponse'];
      EasyLoading.dismiss();
      setState(() {
        dropdownItems.clear();
        results=record;
        for (var item in data) {
          dropdownItems.add(
            Asset(
              id: item['id'],
              outletName: item['outletName'],
              grdCode: item['grdCode'],
              outletNumber: item['outletNumber'],
            ),
          );
        }
        items = dropdownItems.map((asset) {
          return DropdownMenuItem<Asset>(
            value: asset,
            child: Text(
                '${asset.outletName} - ${asset.outletNumber}'), // Displayed property
          );
        }).toList();
      });
      /* setState(() {
        // Extract the "assetName" field from each item and store in dropdownItems
        dropdownItems = data.map((item) => item['assetName'] as String).toList();
      });*/
    } else {
      EasyLoading.dismiss();
      log('Message: ${response.statusCode}');
      log('Message: ${response.body}');
      throw Exception('Failed to load data');
    }
  }

   Future<void> fetchCustomerById(String id) async {
    await EasyLoading.show(status: 'Fetching Data...');
    final Uri uri = Uri.parse(ApiService().baseUrl +
        ApiService().equipmentByIdEndPoint +
        id); // Replace with your API endpoint
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();

      Map<String, dynamic> jsonMap = json.decode(response.body)['data'];
      DataC singleObjects = DataC.fromJson(jsonMap);
      // DataObj singleObjects = data.map((data) => DataObj.fromJson(data)).toList();
      setState(() {
        showDetail = true;
        //complaintDetailModel = singleObjects ;
        equipmentIdModel = singleObjects;
        fetchDepositSlips(id);
        // equipmentIdModel =  (equipmentData.isNotEmpty ? equipmentData[0] : null)!;
      });
    } else {
      EasyLoading.dismiss();
      throw Exception('Failed to load Equipment');
    }
  }

  void fetchDepositSlips(String? id) async {
    await EasyLoading.show(status: 'Fetching Data...');
    final Uri uri = Uri.parse(ApiService().baseUrl +
        ApiService().complaintListEndPoint); // Replace with your API endpoint
    Map<String, String> headers = {
      //'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var map = <String, dynamic>{};
    map['take'] = '1000';
    map['page'] = '1';
    map['pageSize'] = '1000';
    map['skip'] = '0';
    map['id'] = id;
    final response = await http.post(uri,body: map,headers: headers);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      transactions.clear();
      String msg = json.decode(response.body)['message'];
      if(msg==""){
        Map<String, dynamic> jsonMap = json.decode(response.body)['data'];
        final List<dynamic> jsonData = jsonMap['data'];

        setState(() {
          showDetail = true;
          transactions = jsonData.map((data) => TransactionData.fromJson(data)).toList();
        });
      }
      else{
        Fluttertoast.showToast(
          msg: msg,
        );
      }
    } else {
      EasyLoading.dismiss();
      throw Exception('Failed to load complaints');
    }
  }

  Future<void> imgUpload(String? id,String? imgPath) async {
    await EasyLoading.show(status: 'Fetching Data...');
    final Uri uri = Uri.parse(ApiService().baseUrl +
        ApiService().imgUploadEndPoint); // Replace with your API endpoint
   /* var map = <String, dynamic>{};
    map['CustomerId'] = id;
    map['File'] = imgBinary;*/
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['CustomerId'] = id!;
    request.files.add(await http.MultipartFile.fromPath('File', imgPath!));
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      String msg = json.decode(responsed.body)['message'];
        Map<String, dynamic> jsonMap = json.decode(responsed.body)['data'];
        DataImg singleObjects = DataImg.fromJson(jsonMap);
        setState(() {
          imgUploadModel = singleObjects;
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  SubmissionPreview(
                filePath: imgUploadModel.filePath!, // Provide the file path
                urlOrLocal: true,
                fileName: imgUploadModel.userFileName!,
                //fromAccNo: imgUploadModel.fromAccountNumber!,
               // date: imgUploadModel.dateOfDeposit!,
               // amount: imgUploadModel.amount!.toString(),
               outletId: id,
               edit: false,
               /* beneficiaryAcc: '987654321',
                beneficiary: 'John Doe',
                refNo: 'REF123',
                details: 'Some details',*/
              ),
            ),
          ).then((value) {
            fetchCustomerById(outletId!);
            print("backpressed");
          });
        });
        Fluttertoast.showToast(
          msg: msg,
        );
    } else {
      EasyLoading.dismiss();
      print('body ${responsed.body}');
      print('code ${response.statusCode}');
      throw Exception('Failed to load complaints');
    }
  }

  /*Future<List<int>> convertImageToBytes(XFile imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    return imageBytes;
  }

  void _onProceedButtonPressedForTakeImg(XFile? imageFile) async {
    if (imageFile != null) {
      List<int> bytes = await convertImageToBytes(imageFile);
      // Use the bytes as needed, like sending to an API or storing in a variable
      print('Image converted to bytes: $bytes');
      if(bytes!= null){

      }
    } else {
      print('not converted');
      // Handle if no image is selected
    }
  }
*/


  Future<void> _showOptions(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Picture'),
                onTap: () async {
                  Navigator.pop(context);
                  await _takePicture(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.folder),
                title: const Text('Browse File'),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickFile(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _takePicture(BuildContext context) async {
    XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      showDialog(
        context:  globalNavigatorKey.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Captured Image'),
            content:SizedBox(
              height: 300,
                width: 300,
                child: PhotoView(
                  imageProvider: FileImage(File(pickedImage.path)),
                )
            ),
            /*Image.network(
              pickedImage.path,
              fit: BoxFit.contain,
            ),*/ /*Image.file(
              File(pickedImage.path),
              fit: BoxFit.contain,
            ),*/
            //PhotoView (imageProvider: AssetImage(pickedImage.path),initialScale: 1,),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // TODO: Implement Proceed action
                  // _onProceedButtonPressedForTakeImg(pickedImage);
                  imgUpload(outletId, pickedImage.path);
                },
                child: const Text('Proceed'),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Implement Retake action
                  Navigator.pop(context);
                  _takePicture(context); // Open camera again
                },
                child: const Text('Retake'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      showDialog(
        context: globalNavigatorKey.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Selected File'),
            content: file.path!.endsWith('.pdf')
                ? PdfViewer(filePath: file.path!)
                : SizedBox(
                height: 300,
                width: 300,
                child: PhotoView(
                  imageProvider: FileImage(File(file.path!)),
                )
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // TODO: Implement Proceed action
                  imgUpload(outletId, file.path);
                 /* Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  SubmissionPreview(
                        urlOrLocal: false,
                        filePath: file.path!, // Provide the file path
                        fromAccNo: '123456789',
                        date: '2023-01-01',
                        amount: '100',
                        beneficiaryAcc: '987654321',
                        beneficiary: 'John Doe',
                        refNo: 'REF123',
                        details: 'Some details',
                      ),
                    ),
                  );*/

                },
                child: const Text('Proceed'),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Implement Pick Another action
                  Navigator.pop(context);
                  _pickFile(context); // Open file picker again
                },
                child: const Text('Pick Another'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    fetchDepositSlips(outletId!);
    print("backpressed");
    /*if (state == AppLifecycleState.resumed) {
      // Do something when the app is resumed
      print("App is resumed");
    } else if (state == AppLifecycleState.paused) {
      // Do something when the app is paused
      print("App is paused");
    }*/
  }

 /* @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //do your stuff
      print("backpressed");
      fetchDepositSlips(outletId!);

    }
  }*/


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor:  appTheme.red900, // Set the status bar color
      statusBarIconBrightness: Brightness.light, // Set the icon color to light
    ));

  /*  items = dropdownItems.map((asset) {
      return DropdownMenuItem<Asset>(
        value: asset,
        child: Text(
            '${asset.outletName} - ${asset.outletNumber}'), // Displayed property
      );
    }).toList();
    List<int> searchFn(String keyword, List<DropdownMenuItem<Asset>> items)  {
      List<int> indexes = [];
      for (int index = 0; index < items.length; index++) {
        if (items[index]
            .value!
            .outletName
            .toLowerCase()
            .startsWith(keyword.toLowerCase())) {
          indexes.add(index);
        } else if (items[index]
            .value!
            .outletNumber
            .toLowerCase()
            .startsWith(keyword.toLowerCase())) {
          indexes.add(index);
        }
      }
      if (keyword.toLowerCase().length >= 2) {
         getPartsListData(keyword.toLowerCase())
            .then((data) {
          // You can process the data and find indexes as needed

        })
            .catchError((error) {
          // Handle any errors from getPartsListData function here
          log('Error fetching items: $error');
        });
      }

      return indexes;
    }*/

    return Scaffold(
      key: _scaffoldKey,
        body: Container(
          decoration: AppDecoration.fillGray,
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 23.v),
                        decoration: AppDecoration.gradientRedToRedA,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomAppBar(
                              leadingWidth: 50.h,
                              leading: AppbarImage(
                                svgPath: ImageConstant.imgMenu,
                                margin: EdgeInsets.only(left: 18.h),
                                onTap: () {
                                  _scaffoldKey.currentState?.openDrawer();
                                },
                              ),
                              centerTitle: true,
                             /* actions: [
                                Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        fetchDepositSlips(outletId!);
                                      },
                                      child: const Icon(
                                          color: Colors.white, Icons.refresh),
                                    )),
                              ],*/
                              title: AppbarTitle(
                                text: "lbl_dashboard".tr,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 24.h,
                                top: 27.v,
                                bottom: 20.v,
                              ),
                                child:  name != null
                                    ?  Text(
                                  'Hi, $name'.tr,
                                  style: theme.textTheme.bodyLarge,
                                )
                                    : const CircularProgressIndicator(color: AppColors.secondaryColor,)
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 0.v),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.v, vertical: 5.h),
                              child: SearchChoices<Asset>.single(
                                fieldPresentationFn: (Widget fieldWidget,
                                    {bool? selectionIsValid}) {
                                  return CustomSearchView(
                                      autofocus: false,
                                      controller: equipmentDropCtrl,
                                      hintText: "lbl_search2".tr,
                                      suffix: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: fieldWidget,
                                      ),
                                      suffixConstraints:
                                      BoxConstraints(maxHeight: 54.v));
                                },
                                value: selectedValueSingleDialog,
                                //items: items,
                                hint: "Select Outlet",
                                style: theme.textTheme.bodySmall,
                               // searchFn: searchFn,
                                selectedValueWidgetFn: (item) {

                                  return  Padding(
                                      padding: EdgeInsets.only(left: 5.h),
                                      child: Text( '${item.outletName} - ${item.outletNumber}',
                                        style: theme.textTheme.bodySmall!.copyWith(
                                          height: 3,
                                        ),
                                        textAlign: TextAlign.left,
                                      )) ;
                                },
                                futureSearchRetryButton: (Function onPressed) =>
                                const Column(children: [
                                  SizedBox(height: 15),
                                  Center(
                                    child: Text("Search Part With \"Outlet Name\" or \"Outlet Code\""),
                                  )
                                ]),
                                emptyListWidget: (String keyword) =>
                                "No result with the \"$keyword\" keyword",
                                futureSearchFn: (String? keyword, String? orderBy, bool? orderAsc,
                                    List<Tuple2<String, String>>? filters, int? pageNb) async {

                                  if (keyword!.toLowerCase().length >= 1) {
                                    getPartsListData(keyword.toLowerCase());
                                  }
                                  return Tuple2<List<DropdownMenuItem>, int>(items,results!);
                                },
                                searchHint: "Search Outlet",
                                isExpanded: true,
                                onClear: () {
                                  items.clear();
                                  dropdownItems.clear();
                                  transactions.clear();
                                  equipmentDropCtrl.text = '';
                                  setState(() {
                                    showDetail = false;
                                  });
                                  selectedValueSingleDialog = null;
                                },
                                onChanged: (value) {
                                  outletId = value.id;
                                 // equipmentDropCtrl.text = value;
                                  fetchCustomerById(outletId!);
                                 //fetchComplaints(outletId);
                                 /* Fluttertoast.showToast(
                                    msg: outletId!,
                                  );*/
                                  setState(() {
                                    dropdownItems.clear();
                                    items.clear();
                                    selectedValueSingleDialog = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if(showDetail)Expanded(
                flex: 10,
                child: Column(
                 children: [
                   Card(
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10.0),
                     ),
                     elevation: 0,
                     margin: const EdgeInsets.all(20),
                     child: Padding(
                       padding: const EdgeInsets.all(20),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           _buildDetailRow('Outlet Number', equipmentIdModel.outletNumber!),
                           const SizedBox(height: 10),
                           _buildDetailRow('Outlet Name (ENG)',  equipmentIdModel.outletName!),
                           const SizedBox(height: 10),
                           _buildDetailRow('Outlet Name (AR)', equipmentIdModel.arabicOutletName!),
                           const SizedBox(height: 10),
                           _buildDetailRow('Region (ENG)', equipmentIdModel.region!),
                           const SizedBox(height: 10),
                           _buildDetailRow('Region (AR)', equipmentIdModel.arRegion!),
                         ],
                       ),
                     ),
                   ),
                   SizedBox(height: 6.v),
                   Padding(
                     padding: const EdgeInsets.only(left: 20,right: 20),
                     child: Row(
                       children: [
                         Expanded(
                           flex: 1,
                           child: Padding(
                             padding:
                             EdgeInsets.only(
                               top: 1.v,
                               bottom: 2.v,
                             ),
                             child: Text(
                               "Deposit Slips:",
                               style: GoogleFonts.poppins(
                                 fontSize: 18,
                                 fontWeight: FontWeight.bold,
                                 color: HexColor("#4f4f4f"),
                               ),
                             ),
                           ),
                         ),
                         Expanded(
                           flex: 1,
                           child: CustomElevatedButton(
                             onTap: () {
                               _showOptions(context);
                               // Navigator.pushNamed(context, '/complaint_Details/start_complaint', arguments: complaintDetailModel);
                             },
                             width: 200.h,
                             text: "Deposit Slip".tr,
                             buttonStyle: CustomButtonStyles.outlineBlackTL24,
                             alignment: Alignment.center,
                           ),
                         ),
                       ],
                     ),
                   ),
                   SizedBox(height: 7.v),
                   Expanded(
                     flex: 5,
                         child: TransactionList(transactions: transactions , onUpdate:() =>  fetchDepositSlips(outletId!) ,homeScreenState: HomeScreenState(),)
                   )
                 ],
                             ),
              )
            ],
          ),
        ),
    // Use the StatefulWidget for the drawer content
        drawer: const DrawerWidget(),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('$name'),
            accountEmail: Text('$email'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(CupertinoIcons.person),
            ),
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.home),
            title: const Text('Home'),
            onTap: () {
              // Add your navigation logic here
              Navigator.pop(context); // Closes the Drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Log Out'),
            onTap: () {
              // Add your navigation logic here
              showLogoutConfirmation(context); // Closes the Drawer
            },
          ),
        ],
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  final List<TransactionData> transactions;
  final HomeScreenState homeScreenState;
  final VoidCallback onUpdate;

  const TransactionList({
    Key? key,
    required this.transactions,
    required this.onUpdate,
    required this.homeScreenState,
  }) : super(key: key);
  //final HomeScreenState homeScreenState = HomeScreenState();


  bool isEditable(String? creationDateString) {
    if (creationDateString == null) {
      return false;
    }
    else{
      final DateFormat formatter = DateFormat("yyyy-MM-ddTHH:mm:ss");
      final DateTime creationDate = formatter.parse(creationDateString);
      final now = DateTime.now();
      final difference = now.difference(creationDate).inHours;
      return difference < 24;
    }

  }



  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (BuildContext context, int index) {
        final transaction = transactions[index];
        return  Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0,
            margin: const EdgeInsets.all(20),
            child:ListTile(
                title: Text('From Acc No: ${transaction.fromAccountNumber}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date Of Deposit: ${parseDateTime(transaction.dateOfDeposit)}'),
                    Text('Amount: ${transaction.amount.toString()}'),
                    Text('Beneficiary Account: ${transaction.toAccountNumber}'),
                    Text('Ref No: ${transaction.referenceNumber}'),
                  ],
                ),
                trailing: isEditable(transaction.createdDate)
                    ? IconButton(
                       icon: const Icon(Icons.edit),
                       onPressed: () {
                       Navigator.push(
                       context,
                       MaterialPageRoute(
                        builder: (context) =>  SubmissionPreview(
                          filePath: transaction.filePath!, // Provide the file path
                          fileName: transaction.userFileName!,
                          id: transaction.id!,
                          urlOrLocal: true,
                          fromAccNo: transaction.fromAccountNumber!,
                          date: parseDateTime(transaction.dateOfDeposit),
                          amount: transaction.amount.toString(),
                          beneficiaryAcc: transaction.toAccountNumber!,
                          beneficiary: transaction.toAccountNameEnglish!,
                          refNo: transaction.referenceNumber!,
                          details: transaction.typeOfTransaction!,
                          edit: true,
                          outletId: transaction.fKCustomerID!,
                        ),
                      ),
                    ).then((value) {
                          onUpdate();
                          print("backpressed");
                    });
                    // Handle edit action
                    // You can implement functionality to edit the transaction here
                  },
                ) : null ,
          )
        );
      },
    );
  }
}

void showLogoutConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.secondaryColor,
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Logout'),
            onPressed: () {
              navigateToHome();
            },
          ),
        ],
      );
    },
  );
}

///Handling route based on bottom click actions
String getCurrentRoute(BottomBarEnum type) {
  switch (type) {
    case BottomBarEnum.Home:
      return AppRoutes.dashboardScreen;
    case BottomBarEnum.Complaints:
      return AppRoutes.complaintListScreen;
    default:
      return AppRoutes.dashboardScreen;
  }
}

///Handling page based on route
Widget getCurrentPage(String currentRoute) {
  switch (currentRoute) {
    case AppRoutes.dashboardScreen:
      return const HomeScreen();
    case AppRoutes.complaintListScreen:
      return const ComplaintList();
    default:
      return DefaultWidget();
  }
}

/// Navigates back to the previous screen.
///
/// This function takes a [BuildContext] object as a parameter, which is used
/// to navigate back to the previous screen.
onTapArrowleftone(BuildContext context) {
  Navigator.pop(context);
}

Future<void> navigateToHome() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  Navigator.pushNamedAndRemoveUntil(
      globalNavigatorKey.currentContext as BuildContext,
      "/login",
      (r) => false);
  ScaffoldMessenger.of(globalNavigatorKey.currentContext as BuildContext)
      .showSnackBar(
    const SnackBar(
      content: Text('Logged out successfully!'),
    ),
  );
}


class PdfViewer extends StatelessWidget {
  final String filePath;

  const PdfViewer({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, // Adjust width as needed
      height: 400, // Adjust height as needed
      child: PDFView(
        filePath: filePath,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onError: (error) {
          print(error.toString());
        },
        onViewCreated: (PDFViewController pdfViewController) {},
        onPageChanged: (int? page, int? total) {
          print('page change: $page/$total');
        },
      ),
    );
  }
}

// Image Viewer Widget
class ImageViewer extends StatelessWidget {
  final String imagePath;

  const ImageViewer({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(imagePath),
      fit: BoxFit.contain,
    );
  }
}


Widget _buildDetailRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 3,
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        flex: 5,
        child: Text(value),
      ),
    ],
  );
}

class Asset {
  final String id;
  final String outletName;
  final String outletNumber;
  final String grdCode;

  Asset(
      {required this.id,
        required this.outletName,
        required this.grdCode,
        required this.outletNumber});
}

/*class _ComplaintsData {
  _ComplaintsData(this.name, this.count, [this.color]);

  final String name;
  final double count;
  final Color? color;
}*/

class ChartData {
  ChartData(this.x, this.y, this.value);

  final String x;
  final double y;
  final String value;
}
