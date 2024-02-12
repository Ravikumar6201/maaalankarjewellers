// ignore_for_file: prefer_const_constructor, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors
import 'package:MaaAlankar/class/Colorconstant.dart';
import 'package:MaaAlankar/class/math_utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  void initState() {
    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(
                0.5,
                -3.0616171314629196e-17,
              ),
              end: Alignment(
                0.5,
                0.9999999999999999,
              ),
              colors: [
                ColorConstant.blue100,
                ColorConstant.lightBlue700,
              ],
            ),
          ),
          child: Image.asset(
            "assets/images/flashscreen.jpeg",
            height: getVerticalSize(
              126.00,
            ),
            width: getHorizontalSize(
              186.00,
            ),
            fit: BoxFit.fill,
          ),
          // child: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Expanded(
          //       child: Align(
          //         alignment: Alignment.centerLeft,
          //         child: SingleChildScrollView(
          //           child: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Align(
          //                 alignment: Alignment.centerLeft,
          //                 child: Padding(
          //                   padding: EdgeInsets.only(
          //                     top: getVerticalSize(
          //                       99.00,
          //                     ),
          //                   ),
          //                   child: Column(
          //                     mainAxisSize: MainAxisSize.min,
          //                     crossAxisAlignment: CrossAxisAlignment.center,
          //                     mainAxisAlignment: MainAxisAlignment.start,
          //                     children: [
          //                       /// Company Logo
          //                       Padding(
          //                         padding: EdgeInsets.only(
          //                           left: getHorizontalSize(
          //                             18.00,
          //                           ),
          //                           right: getHorizontalSize(
          //                             18.00,
          //                           ),
          //                         ),
          //                         // child: Image.asset(
          //                         //   ImageConstant.imgLogoresize1,
          //                         //   height: getVerticalSize(
          //                         //     126.00,
          //                         //   ),
          //                         //   width: getHorizontalSize(
          //                         //     186.00,
          //                         //   ),
          //                         //   fit: BoxFit.fill,
          //                         // ),
          //                       ),

          //                       ///Image set
          //                       Container(
          //                         height: getVerticalSize(
          //                           243.96,
          //                         ),
          //                         width: getHorizontalSize(
          //                           326.00,
          //                         ),
          //                         margin: EdgeInsets.only(
          //                           left: getHorizontalSize(
          //                             18.00,
          //                           ),
          //                           top: getVerticalSize(
          //                             47.00,
          //                           ),
          //                           right: getHorizontalSize(
          //                             16.00,
          //                           ),
          //                         ),

          //                         ///Polygon Image
          //                         child: Stack(
          //                           alignment: Alignment.bottomLeft,
          //                           children: [
          //                             ///Right
          //                             Align(
          //                               alignment: Alignment.bottomRight,
          //                               child: Padding(
          //                                 padding: EdgeInsets.only(
          //                                   left: getHorizontalSize(
          //                                     10.00,
          //                                   ),
          //                                   top: getVerticalSize(
          //                                     10.00,
          //                                   ),
          //                                   bottom: getVerticalSize(
          //                                     0.00,
          //                                   ),
          //                                 ),
          //                                 // child: Image.asset(
          //                                 //   ImageConstant.imgPolygon3,
          //                                 //   height: getSize(
          //                                 //     138.00,
          //                                 //   ),
          //                                 //   width: getSize(
          //                                 //     138.00,
          //                                 //   ),
          //                                 //   fit: BoxFit.fill,
          //                                 // ),
          //                               ),
          //                             ),

          //                             ///Left
          //                             Align(
          //                               alignment: Alignment.bottomLeft,
          //                               child: Padding(
          //                                 padding: EdgeInsets.only(
          //                                   top: getVerticalSize(
          //                                     10.00,
          //                                   ),
          //                                   right: getHorizontalSize(
          //                                     10.00,
          //                                   ),
          //                                   bottom: getVerticalSize(
          //                                     1.00,
          //                                   ),
          //                                 ),
          //                                 // child: Image.asset(
          //                                 //   ImageConstant.imgPolygon2,
          //                                 //   height: getVerticalSize(
          //                                 //     120.00,
          //                                 //   ),
          //                                 //   width: getHorizontalSize(
          //                                 //     138.00,
          //                                 //   ),
          //                                 //   fit: BoxFit.fill,
          //                                 // ),
          //                               ),
          //                             ),

          //                             ///top
          //                             Align(
          //                               alignment: Alignment.topCenter,
          //                               child: Padding(
          //                                 padding: EdgeInsets.only(
          //                                   left: getHorizontalSize(
          //                                     91.39,
          //                                   ),
          //                                   right: getHorizontalSize(
          //                                     91.39,
          //                                   ),
          //                                   bottom: getVerticalSize(
          //                                     10.00,
          //                                   ),
          //                                 ),
          //                                 // ignore: prefer_const_constructors
          //                                 child: Align(
          //                                     alignment: Alignment.topCenter,
          //                                     child: Padding(
          //                                         padding:
          //                                             EdgeInsets.only(top: 125),
          //                                         child: Column(
          //                                           children: [
          //                                             // Image(
          //                                             //   image: AssetImage(
          //                                             //       "assets/images/bcilogo.png"),
          //                                             //   height: 150,
          //                                             //   // width: 400,
          //                                             // ),
          //                                           ],
          //                                         ))),
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),

          //                       ///App Details
          //                       Padding(
          //                         padding: EdgeInsets.only(
          //                           left: getHorizontalSize(
          //                             18.00,
          //                           ),
          //                           top: getVerticalSize(
          //                             34.04,
          //                           ),
          //                           right: getHorizontalSize(
          //                             18.00,
          //                           ),
          //                         ),
          //                         child: FittedBox(
          //                           child: Text(
          //                             "Maa Alankar Jewellers",
          //                             textScaleFactor: 1,
          //                             overflow: TextOverflow.ellipsis,
          //                             softWrap: true,
          //                             textAlign: TextAlign.center,
          //                             style: TextStyle(
          //                               color: ColorConstant.golden,
          //                               fontSize: getFontSize(
          //                                 22,
          //                               ),
          //                               fontFamily: 'Inter',
          //                               fontWeight: FontWeight.bold,
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                       Padding(
          //                         padding: EdgeInsets.only(
          //                           left: getHorizontalSize(
          //                             18.00,
          //                           ),
          //                           top: getVerticalSize(
          //                             5.00,
          //                           ),
          //                           right: getHorizontalSize(
          //                             18.00,
          //                           ),
          //                         ),
          //                         // child: Text(
          //                         //   "BCI",
          //                         //   textScaleFactor: 1,
          //                         //   overflow: TextOverflow.ellipsis,
          //                         //   textAlign: TextAlign.center,
          //                         //   style: TextStyle(
          //                         //     color: ColorConstant.whiteA700,
          //                         //     fontSize: getFontSize(
          //                         //       18,
          //                         //     ),
          //                         //     fontFamily: 'Inter',
          //                         //     fontWeight: FontWeight.bold,
          //                         //   ),
          //                         // ),
          //                       ),
          //                       // Padding(
          //                       //   padding: EdgeInsets.only(
          //                       //     left: getHorizontalSize(
          //                       //       18.00,
          //                       //     ),
          //                       //     top: getVerticalSize(
          //                       //       4.00,
          //                       //     ),
          //                       //     right: getHorizontalSize(
          //                       //       18.00,
          //                       //     ),
          //                       //   ),
          //                       //   child: Text(
          //                       //     "Version 0.1",
          //                       //     textScaleFactor: 1,
          //                       //     overflow: TextOverflow.ellipsis,
          //                       //     textAlign: TextAlign.center,
          //                       //     style: TextStyle(
          //                       //       color: ColorConstant.black900,
          //                       //       fontSize: getFontSize(
          //                       //         12,
          //                       //       ),
          //                       //       fontFamily: 'Inter',
          //                       //       fontWeight: FontWeight.w400,
          //                       //     ),
          //                       //   ),
          //                       // ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
