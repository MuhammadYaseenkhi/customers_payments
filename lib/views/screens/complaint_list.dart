import 'dart:convert';
import 'package:customers_payments/core/app_export.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:customers_payments/model/complaint_list_model.dart';
import 'package:customers_payments/views/utils/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_colors.dart';
import '../../services/api_service.dart';
import '../../theme/app_decoration.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

SharedPreferences? prefs;
String? token;
String? userId;

class ComplaintList extends StatefulWidget {
  const ComplaintList({super.key});

  @override
  ComplaintListState createState() => ComplaintListState();
}

class ComplaintListState extends State<ComplaintList> {

  List<Data> complaints = [];
  String selectedValue = "All";
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "All", child: Text("All Complaints")),
      const DropdownMenuItem(
        value: 'New',
        child: Text("New"),
      ),
      const DropdownMenuItem(
        value: 'Assigned',
        child: Text("Assigned"),
      ),
      const DropdownMenuItem(
        value: 'Work Started',
        child: Text("Work Started"),
      ),
      const DropdownMenuItem(
        value: 'Work Paused',
        child: Text("Work Paused"),
      ),
      const DropdownMenuItem(
        value: 'Work End',
        child: Text("Work End"),
      ),
      const DropdownMenuItem(
        value: 'Approved',
        child: Text("Approved"),
      ),
      const DropdownMenuItem(
        value: 'Rejected',
        child: Text("Rejected"),
      ),
      const DropdownMenuItem(
        value: 'Closed',
        child: Text("Closed"),
      ),
    ];
    return menuItems;
  }

  @override
  initState() {
    super.initState();
    // filteredList.addAll(problemsItems);
   // sharedPref();
  }

  sharedPref() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs?.getString('token')!;
    userId = prefs?.getString('userID')!;
    if (token != '') {
      fetchComplaints(token).then((result) {
        setState(() {
          complaints = result;
        });
      });
    }
  }

  Future<List<Data>> fetchComplaints(String? token) async {
    await EasyLoading.show(status: 'Fetching Data...');
    final Uri uri = Uri.parse(ApiService().baseUrl +
        ApiService().complaintListEndPoint); // Replace with your API endpoint

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      final List<Data> complaints =
      jsonData.map((data) => Data.fromJson(data)).toList();
      return complaints;
    } else {
      EasyLoading.dismiss();
      throw Exception('Failed to load complaints');
    }
  }

  List<bool> isSelected = [true, false, false];
  /*late List<ComplaintListModel> complains =
      ComplaintData.getComplains.cast<ComplaintListModel>();*/

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor:  appTheme.red900, // Set the status bar color
      statusBarIconBrightness: Brightness.light, // Set the icon color to light
    ));
    List<Data> filteredComplaints = complaints;
    if(isSelected[0]){
      selectedValue = 'TO DO';
      filteredComplaints = complaints.where((complaint) =>
      getStatusName(complaint.statusId) == selectedValue,
      ).toList();
    }
    if (isSelected[1]) {
      selectedValue = 'ON GOING';
      List<String> allowedStatuses = ['Work Started', 'ON GOING', 'Work End', 'Dispute'];
      filteredComplaints = complaints.where((complaint) {
        String status = getStatusName(complaint.statusId);
        return allowedStatuses.contains(status);
      }).toList();
    }
    if(isSelected[2]){
      selectedValue = 'SOLVED';
      List<String> allowedStatuses = ['Approved', 'SOLVED'];
      filteredComplaints = complaints.where((complaint) {
        String status = getStatusName(complaint.statusId);
        return allowedStatuses.contains(status);
      }).toList();
    }

    /*if (selectedValue != 'All') {
      filteredComplaints = complaints.where((complaint) =>
        getStatusName(complaint.statusId) == selectedValue,
      ).toList();
    }*/
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
                width: double.maxFinite,
              // color: AppColors.warningColor,
                decoration: AppDecoration.fillGray,
                child: Column(children: [
                  SizedBox(
                      height: 160.v,
                      width: double.maxFinite,
                      child:
                      Stack(alignment: Alignment.bottomCenter, children: [
                        CustomAppBar(
                            height: 120.v,
                            leadingWidth: 56.h,
                            leading: AppbarImage(
                                svgPath: ImageConstant.imgArrowleft,
                                margin: EdgeInsets.only(
                                    left: 16.h, top: 23.v, bottom: 56.v),
                                onTap: () {
                                  onTapArrowleftone(context);
                                }),
                            centerTitle: true,
                            title: AppbarTitle(
                                text: "lbl_all_complaints".tr,
                                margin:
                                EdgeInsets.only(top: 30.v, bottom: 63.v)),
                            styleType: Style.bgGradientnamered900nameredA700),
                        Align(
                          child: Container(
                            height: 60,
                              //width: MediaQuery.of(context).size.width *0.10,
                              margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
                              decoration:
                              AppDecoration.outlineBlack900.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder8,
                              ),
                              child: ToggleButtons(
                                borderRadius: BorderRadiusStyle.roundedBorder8,
                                borderColor: appTheme.whiteA700,
                                isSelected: isSelected,
                                onPressed: (int index) {
                                  setState(() {
                                    // Update the selected option
                                    for (int buttonIndex = 0;
                                    buttonIndex < isSelected.length;
                                    buttonIndex++) {
                                      if (buttonIndex == index) {
                                        isSelected[buttonIndex] = true;
                                      } else {
                                        isSelected[buttonIndex] = false;
                                      }
                                    }
                                  });
                                },
                                children: [
                                  Container(
                                   width: MediaQuery.of(context).size.width *0.3,
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5),
                                      decoration: isSelected[0]
                                          ? AppDecoration.fillRedA.copyWith(
                                          borderRadius: BorderRadiusStyle
                                              .roundedBorder8)
                                          : AppDecoration.fillGray,
                                      child: Stack(children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "lbl_to_do".tr,
                                              style: isSelected[0]
                                                  ? CustomTextStyles
                                                  .bodySmallWhiteA700
                                                  : CustomTextStyles
                                                  .bodySmallBlack900,
                                            )),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            height: 80.v,
                                            width: 50.h,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder8,
                                            ),
                                            child: Transform.translate(
                                              offset: const Offset(20, 10),
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Align(
                                                    alignment:
                                                    Alignment.bottomRight,
                                                    child: Container(
                                                      height: 50.v,
                                                      width: 50.h,
                                                      decoration: BoxDecoration(
                                                        color: appTheme.redA700,
                                                        borderRadius:
                                                        BorderRadiusStyle
                                                            .roundedBorder50,
                                                      ),
                                                    ),
                                                  ),
                                                  CustomImageView(
                                                    svgPath:
                                                    ImageConstant.imgClose,
                                                    height: 100.v,
                                                    width: 100.h,
                                                    radius:
                                                    BorderRadius.circular(
                                                      8.h,
                                                    ),
                                                    alignment: Alignment.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ])),
                                  Container(
                                      width: MediaQuery.of(context).size.width *0.3,
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5),
                                      decoration: isSelected[1]
                                          ? AppDecoration.fillRedA.copyWith(
                                          borderRadius: BorderRadiusStyle
                                              .roundedBorder8)
                                          : AppDecoration.fillGray,
                                      child: Stack(children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "lbl_on_going2".tr,
                                            style: isSelected[1]
                                                ? CustomTextStyles
                                                .bodySmallWhiteA700
                                                : CustomTextStyles
                                                .bodySmallBlack900,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            height: 80.v,
                                            width: 50.h,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder8,
                                            ),
                                            child: Transform.translate(
                                              offset: const Offset(20, 10),
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Align(
                                                    alignment:
                                                    Alignment.bottomRight,
                                                    child: Container(
                                                      height: 50.v,
                                                      width: 50.h,
                                                      decoration: BoxDecoration(
                                                        color: appTheme.redA700,
                                                        borderRadius:
                                                        BorderRadiusStyle
                                                            .roundedBorder50,
                                                      ),
                                                    ),
                                                  ),
                                                  CustomImageView(
                                                    svgPath: ImageConstant
                                                        .imgRefresh,
                                                    height: 100.v,
                                                    width: 100.h,
                                                    radius:
                                                    BorderRadius.circular(
                                                      8.h,
                                                    ),
                                                    alignment: Alignment.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ])),
                                  Container(
                                      width: MediaQuery.of(context).size.width *0.3,
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5),
                                      decoration: isSelected[2]
                                          ? AppDecoration.fillRedA.copyWith(
                                          borderRadius: BorderRadiusStyle
                                              .roundedBorder8)
                                          : AppDecoration.fillGray,
                                      child: Stack(children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "lbl_solved2".tr,
                                            style: isSelected[2]
                                                ? CustomTextStyles
                                                .bodySmallWhiteA700
                                                : CustomTextStyles
                                                .bodySmallBlack900,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            height: 80.v,
                                            width: 50.h,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder8,
                                            ),
                                            child: Transform.translate(
                                              offset: const Offset(20, 10),
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Align(
                                                    alignment:
                                                    Alignment.bottomRight,
                                                    child: Container(
                                                      height: 50.v,
                                                      width: 50.h,
                                                      decoration: BoxDecoration(
                                                        color: appTheme.redA700,
                                                        borderRadius:
                                                        BorderRadiusStyle
                                                            .roundedBorder50,
                                                      ),
                                                    ),
                                                  ),
                                                  CustomImageView(
                                                    svgPath: ImageConstant
                                                        .imgCheckmarkWhiteA700,
                                                    height: 100.v,
                                                    width: 100.h,
                                                    radius:
                                                    BorderRadius.circular(
                                                      8.h,
                                                    ),
                                                    alignment: Alignment.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ])),
                                ],
                              )),
                        )
                      ])),
                  Expanded(
                      child: SizedBox(
                          width: double.maxFinite,
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.h, vertical: 10.v),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    /* Padding(
                                        padding: EdgeInsets.only(left: 1.h),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 4.v),
                                                  child: Text("lbl_total_08".tr,
                                                      style: CustomTextStyles
                                                          .titleMediumGray800)),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 19.h,
                                                      top: 7.v,
                                                      bottom: 6.v),
                                                  child: Text(
                                                      "lbl_out_of_102".tr,
                                                      style: CustomTextStyles
                                                          .labelLargeGray800_1)),
                                              Spacer(),
                                              CustomTextFormField(
                                                  width: 98.h,
                                                  controller: searchController,
                                                  hintText: "lbl_search".tr,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 9.h,
                                                          vertical: 7.v)),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.h,
                                                      top: 8.v,
                                                      bottom: 5.v),
                                                  child: Text("lbl_sort_by".tr,
                                                      style: CustomTextStyles
                                                          .labelLargeGray800)),
                                              CustomImageView(
                                                  svgPath: ImageConstant
                                                      .imgMenuBlack900,
                                                  height: 24.adaptSize,
                                                  width: 24.adaptSize,
                                                  margin: EdgeInsets.only(
                                                      bottom: 3.v))
                                            ])),*/
                                    Expanded(
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 1.h, top: 5.v),
                                            child: RefreshIndicator(
                                              key: _refreshIndicatorKey,
                                              onRefresh: () async {
                                                fetchComplaints(token).then((result) {
                                                  setState(() {
                                                    complaints = result;
                                                  });
                                                });
                                              },
                                              child: ListView.separated(
                                                  physics:
                                                  const BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return SizedBox(height: 12.v);
                                                  },
                                                  itemCount: filteredComplaints.length,
                                                  itemBuilder: (context, index) {
                                                    /*return  ComplaintCard(
                                                      complaintListModel: filteredComplaints[index],
                                                      onTap: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            '/complaint_Details/complaint_tabs',
                                                            arguments: filteredComplaints[index]
                                                                .id.toString())
                                                            .then((value) {
                                                          fetchComplaints(token)
                                                              .then((result) {
                                                            setState(() {
                                                              complaints =
                                                                  result;
                                                              print(
                                                                  "backpressed");
                                                            });
                                                          });
                                                        });
                                                      }
                                                    );*/
                                                  }),
                                            )))
                                  ]))))
                ]
                )
            )
        )
    );
  }
}


/*Expanded(
flex: 1,
child: RefreshIndicator(
key: _refreshIndicatorKey,
onRefresh: () async {
fetchComplaints(token).then((result) {
setState(() {
complaints = result;
});
});
},
child: ListView.builder(
padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
scrollDirection: Axis.vertical,
shrinkWrap: true,
itemCount: filteredComplaints.length,
itemBuilder: (BuildContext context, int index) {
return ComplaintCard(
complaintListModel: filteredComplaints[index],
);
},
),
))*/

onTapArrowleftone(BuildContext context) {
  Navigator.pop(context);
}

