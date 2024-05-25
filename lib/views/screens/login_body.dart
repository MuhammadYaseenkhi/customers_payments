import 'dart:async';
import 'package:customers_payments/app_colors.dart';
import 'package:customers_payments/core/app_export.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../../model/user_login_model.dart';
import '../../services/api_service.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'home_screen.dart';

class LoginBodyScreen extends StatefulWidget {
  const LoginBodyScreen({super.key});

  @override
  State<LoginBodyScreen> createState() => _LoginBodyScreenState();
}

class _LoginBodyScreenState extends State<LoginBodyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late FocusNode emailFocus,passwordFocus;
  late String emailValue , passwordValue;
  SharedPreferences? prefs ;
  String? userID;
  String? fcmToken;
  bool passwordVisible=false;

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  void initState()  {
    super.initState();
    passwordVisible=true;
    emailFocus = FocusNode();
    passwordFocus = FocusNode();

    // loginCheck();
    // getFirebaseMessagingToken();
  }

  @override
  Widget build(BuildContext context) {
    //Status Bar Color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: AppColors.secondaryColor, // Set the status bar color
      statusBarIconBrightness: Brightness.dark, // Set the icon color to light
    ));
  //  fcmToken = _messagingService.getFCMToken();

    //SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: AppColors.secondaryColor));
    Future<void> validateInputs() async {
      emailValue = emailController.text.trim(); //= 'admin@demo.com' ; // //= 'ahmadraza3207@gmail.com' ;
      passwordValue = passwordController.text; //= 'demo'; // //
      if (emailValue.isEmpty) {
        Fluttertoast.showToast(
          msg: "Email Is Required",
        );
        emailFocus.requestFocus();
        return;
      }
      else if (!EmailValidator.validate(emailValue, true)) {
        Fluttertoast.showToast(
          msg: "Invalid Email Address",
        );
        emailFocus.requestFocus();
        return;
      }
      if (passwordValue.isEmpty) {
        Fluttertoast.showToast(
          msg: "Password Is Required",
        );
        passwordFocus.requestFocus();
        return;
      }
      if(emailValue.isNotEmpty && passwordValue.isNotEmpty) {
       // await EasyLoading.show(status: 'Please Wait...');
        UserLoginModel user = await ApiService().login(emailValue,passwordValue);
        /* Fluttertoast.showToast(
            msg: '${user.message}',
          );*/
        prefs = await SharedPreferences.getInstance();
        if (user.data != null && user.data!.userID != null) {
          prefs?.setString('userID', user.data!.userID!);
          prefs?.setString('token', user.data!.token!);
          prefs?.setString('email', user.data!.email!);
         // prefs?.setString('customer', user.data!.customerName!);
          // prefs?.setString('mobileNumber', user.data!.mobileNumber! as String);
          prefs?.setString('name', '${user.data!.firstName!} ${user.data!.lastName!}');
          userID = prefs?.getString('userID');
          /*Fluttertoast.showToast(
            msg: '${userID}',
          );*/
          ScaffoldMessenger.of(globalNavigatorKey.currentContext as BuildContext)
              .showSnackBar(
            const SnackBar(
              content: Text('Welcome!'),
            ),
          );
        //  EasyLoading.dismiss();
           // updateFCMToken(fcmToken!,user.data?.token);
          if(user.data!.userID != null){
            // ignore: use_build_context_synchronously
           // fcmToken = _messagingService.getFCMToken();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
        }
        //userID = user.data!.userID;
      }
    }


    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: ListView(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          shrinkWrap: true,
          reverse: false,
          children: [
            Form(
              key: _formKey,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 379.v,
                        width: 343.h,
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: CustomImageView(
                                imagePath: ImageConstant.imgVectorRedA700,
                                height: 379.v,
                                width: 327.h,
                                alignment: Alignment.center,
                              ),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgFinalRedLogo,

                              width: 271.h,
                              alignment: Alignment.bottomLeft,
                              margin: EdgeInsets.only(bottom: 59.v),
                            ),
                          ],
                        ),
                      ),
                    ),
                   /* Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 272.h,
                        margin: EdgeInsets.only(
                          left: 18.h,
                          top: 11.v,
                        ),
                        child: Text(
                          "msg_welcome_back_glad".tr,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.headlineSmall,
                        ),
                      ),
                    ),*/
                    CustomTextFormField(
                      controller: emailController,
                      margin: EdgeInsets.only(
                        left: 19.h,
                        top: 33.v,
                        right: 19.h,
                      ),
                      hintText: "msg_enter_your_email".tr,
                      hintStyle: theme.textTheme.bodySmall!,
                      textInputType: TextInputType.emailAddress,
                    ),
                    CustomTextFormField(
                      controller: passwordController,
                      margin: EdgeInsets.only(
                        left: 19.h,
                        top: 33.v,
                        right: 19.h,
                      ),
                      hintText: "msg_enter_you_password".tr,
                      hintStyle: theme.textTheme.bodySmall!,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
                      suffix: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                                () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                      ),
                      filled: true,
                      obscureText: passwordVisible,
                      contentPadding: EdgeInsets.only(
                        left: 18.h,
                        top: 19.v,
                        bottom: 19.v,
                      ),
                    ),
                   /* Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 16.v,
                          right: 19.h,
                        ),
                        child: Text(
                          "msg_forgot_password".tr,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                    ),*/
                    SizedBox(height: 18.v),
                    CustomElevatedButton(
                      onTap: () =>  validateInputs(),
                      width: 135.h,
                      text: "lbl_login".tr,
                      buttonStyle: CustomButtonStyles.redButton,
                    ),
                    SizedBox(height: 5.v),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
