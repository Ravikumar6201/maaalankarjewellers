// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, sort_child_properties_last, import_of_legacy_library_into_null_safe, use_key_in_widget_constructors, library_private_types_in_public_api, unused_import, unused_element, prefer_interpolation_to_compose_strings, avoid_print, prefer_is_empty, non_constant_identifier_names, use_build_context_synchronously, unused_local_variable, unused_catch_stack, unnecessary_import
// import 'package:custom_switch/custom_switch.dart';
import 'dart:convert';
import 'package:MaaAlankar/Screen/Dashboard/Dashboard.dart';
import 'package:MaaAlankar/Screen/Paymet/PhonePePaymentgetway.dart';
import 'package:MaaAlankar/Screen/Paymet/Rozerpay_Screen.dart';
import 'package:MaaAlankar/Screen/Shop/Shopping.dart';
import 'package:MaaAlankar/Screen/Winners/Winners.dart';
import 'package:MaaAlankar/Screen/support/Supports.dart';
import 'package:MaaAlankar/class/Colorconstant.dart';
import 'package:MaaAlankar/class/gBotton.dart';
import 'package:MaaAlankar/class/gnav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CustomerHome extends StatefulWidget {
  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  @override
  void initState() {}
  getDataString() async {
    setState(() {});
  }

  getDropDownAsync() async {
    setState(() {});
  }
   
  int pageIndex = 0;
  bool isToggled = false;
  @override
  Widget build(BuildContext context) {
    final pages = [
      Dashboard(),
      Rozerpay_Screeen(),
      // PhonePe_Screen(),
      WinnersScreen(),
      SupportScreen(),
      ShoppingScreen(),
      
      // RemainderScreen(""),
      // Call_Log_Screen(),
    ];
    Color blueColor = ColorConstant.themeGradientEnd;
    return Scaffold(
        body: pages[pageIndex],
        bottomNavigationBar: Container(
            decoration: BoxDecoration(color: ColorConstant.puregolden),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 04),
                child: GNav(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 04),
                  // duration: Duration(milliseconds: 100),
                  tabBackgroundColor: ColorConstant.whiteA700,
                  // color: Colors.black,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  tabs: [
                    // if (ecString![0] == '1')
                    GButton(
                      textColor: ColorConstant.lightBlue700,
                      icon: Icons.select_all,
                      iconColor: ColorConstant.lightBlue700,
                      leading: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon(
                            //   Icons.call,
                            //   color: Colors.black,
                            // ),
                            ImageIcon(
                              AssetImage("assets/images/home.png"),
                              color: Colors.black,
                              size: 30,
                            ),
                            Text(
                              "Home",
                              style: GoogleFonts.sura(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
                    GButton(
                      textColor: Colors.black,
                      icon: Icons.select_all,
                      iconColor: Colors.transparent,
                      leading: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              AssetImage("assets/images/payment.png"),
                              color: Colors.black,
                              size: 30,
                            ),
                            Text(
                              'Payment',
                              style: GoogleFonts.sura(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // GButton(
                    //   textColor: Colors.black,
                    //   icon: Icons.select_all,
                    //   iconColor: Colors.black,
                    //   leading: Center(
                    //     child: Column(
                    //       mainAxisSize: MainAxisSize.min,
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         // Icon(
                    //         //   Icons.call,
                    //         //   color: Colors.black,
                    //         // ),
                    //         ImageIcon(
                    //           AssetImage("assets/images/folloup.png"),
                    //           color: Colors.black,
                    //           size: 30,
                    //         ),
                    //         Text(
                    //           "FollowUp",
                    //           style: TextStyle(
                    //               fontSize: 12,
                    //               fontWeight: FontWeight.bold,
                    //               color: Colors.black),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // if (ecString![1] == '1')
                    GButton(
                      textColor: Colors.black,
                      icon: Icons.select_all,
                      iconColor: Colors.transparent,
                      leading: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              AssetImage("assets/images/winner.png"),
                              color: Colors.black,
                              size: 30,
                            ),
                            Text(
                              'Winners',
                              style: GoogleFonts.sura(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // if (ecString![3] == '1')
                    GButton(
                      textColor: Colors.black,
                      icon: Icons.select_all,
                      iconColor: Colors.transparent,
                      leading: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              AssetImage("assets/images/supportss.png"),
                              color: Colors.black,
                              size: 30,
                            ),
                            Text(
                              'Support',
                              style: GoogleFonts.sura(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GButton(
                      textColor: Colors.black,
                      icon: Icons.select_all,
                      iconColor: Colors.transparent,
                      leading: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              AssetImage("assets/images/shope.png"),
                              color: Colors.black,
                              size: 30,
                            ),
                            Text(
                              'Shop',
                              style: GoogleFonts.sura(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                  selectedIndex: pageIndex,
                  onTabChange: (index) {
                    setState(() {
                      pageIndex = index;
                    });
                  },
                ),
              ),
            )));
  }
}
