import 'package:customers_payments/core/app_export.dart';
import 'package:customers_payments/views/screens/complaint_list.dart';
import 'package:customers_payments/views/screens/login.dart';
import 'package:floating_bubbles/floating_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/image_constant.dart';
import '../../widgets/custom_image_view.dart';
import 'home_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  SharedPreferences? prefs ;
  String? userID;

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
  //  loginCheck();
    // getFirebaseMessagingToken();
  }

  loginCheck() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
   /* Fluttertoast.showToast(
      msg: '$userID',
    );*/
  }


  @override
  Widget build(BuildContext context) {
    // Add any necessary logic or async tasks here
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor:  appTheme.red900, // Set the status bar color
      statusBarIconBrightness: Brightness.light, // Set the icon color to light
    ));

    // Simulate a delay for demonstration purposes
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    });

    return Stack(
      children: [
        Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: Container(
            width: mediaQueryData.size.width,
            height: mediaQueryData.size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.5, 0),
                end: const Alignment(0.5, 1),
                colors: [
                  appTheme.red900,
                  appTheme.redA700,
                ],
              ),
            ),
            child: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: mediaQueryData.size.height,
                  width: double.maxFinite,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgVector,
                        height: 413.v,
                        width: 308.h,
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(top: 26.v),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgFinallogo1,

                        width: 306.h,
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(top: 298.v),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgMaskgroup,
                        height: 474.v,
                        width: 97.h,
                        alignment: Alignment.bottomRight,
                        margin: EdgeInsets.only(bottom: 18.v),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: SizedBox(
                          height: 651.v,
                          width: 313.h,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgCoke2,
                                height: 612.v,
                                width: 313.h,
                                alignment: Alignment.topCenter,
                              ),
                              CustomImageView(
                                svgPath: ImageConstant.imgCheckmark,
                                height: 51.adaptSize,
                                width: 51.adaptSize,
                                alignment: Alignment.topRight,
                                margin: EdgeInsets.only(
                                  top: 274.v,
                                  right: 67.h,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgMaskgroup111x395,
                        height: 111.v,
                        width: 395.h,
                        alignment: Alignment.topLeft,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: FloatingBubbles(
            noOfBubbles: 50,
            colorsOfBubbles: const [Colors.white],
            sizeFactor: 0.16,
            duration: 120, // 120 seconds.
            opacity: 100,
            paintingStyle: PaintingStyle.fill,
            strokeWidth: 0,
            shape: BubbleShape
                .circle, // circle is the default. No need to explicitly mention if its a circle.
            speed: BubbleSpeed.normal, // normal is the default
          ),
        ),
      ],
    );
  }
}

