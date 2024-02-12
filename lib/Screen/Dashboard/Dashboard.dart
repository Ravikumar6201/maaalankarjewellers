// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, prefer_const_constructors_in_immutables, unused_element, non_constant_identifier_names, use_build_context_synchronously, avoid_print, sized_box_for_whitespace, unnecessary_import, unused_field, prefer_final_fields, prefer_adjacent_string_concatenation, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, unnecessary_new, prefer_collection_literals
import 'dart:convert';
import 'package:MaaAlankar/Fun/Notification_Services/Notifications_Service.dart';
import 'package:MaaAlankar/Login/LoginScreen.dart';
import 'package:MaaAlankar/Models/Dashboard.dart';
import 'package:MaaAlankar/Models/Game.dart';
import 'package:MaaAlankar/Models/Image_benner.dart';
import 'package:MaaAlankar/Screen/Paymet/PhonePePaymentgetway.dart';
import 'package:MaaAlankar/Screen/LatestProduct/LatestProducts.dart';
import 'package:MaaAlankar/Screen/Paymet/Rozerpay_Screen.dart';
import 'package:MaaAlankar/Screen/Privecy/Privacy_Policy.dart';
import 'package:MaaAlankar/Screen/Privecy/Return_Policy.dart';
import 'package:MaaAlankar/Screen/Privecy/Shipping_Policy.dart';
import 'package:MaaAlankar/Screen/Profile/Profile.dart';
import 'package:MaaAlankar/Screen/Shop/Shopping.dart';
import 'package:MaaAlankar/Screen/Winners/Winners.dart';
import 'package:MaaAlankar/Screen/gold_silver/gold.dart';
import 'package:MaaAlankar/Screen/gold_silver/silver.dart';
import 'package:MaaAlankar/Screen/support/Supports.dart';
import 'package:MaaAlankar/class/Colorconstant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_slide_drawer/flutter_slide_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  NotificationServices notificationServices = NotificationServices();
  // List<BannerModel> Benner = [];
  // List<LetestProduct> Products = [];

  @override
  void initState() {
    super.initState();
    LoadApis();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.setupInteractBirth_Aniv(context);

    notificationServices.isTokenRefresh();

    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
        StoreDeviceToken(value);
      }
    });
    // MobileVarify? data = await Varify(PhoneController.text.toString()
    //       // passwordController.text.toString(),
    //       );

    print('FCM============================================================');
    FirebaseMessaging.instance
        .getToken(
            vapidKey:
                'BOVsVElecSRuWSXP2sX-273wdMckHwqxvRJJmrEn8PherIJnW-xmb_73PjBLQaUSD6m646bamE6zQQWzYSS23eA')
        .then((token) {
      //
      setToken(token ?? ' ');
    });
  }

  void setToken(String token) {
    print('FCM Token: $token');
    postToken(token);
    // addTokenApi(token);
  }

  Future StoreDeviceToken(String DeviceToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('deviceToken', DeviceToken.toString());
  }

  // Example: Define some state variables
  int itemCount = 0;
  double totalRevenue = 0.0;
  String meetingurl = 'https://meet.google.com/your-meeting-code';
  int _currentIndex = 0;
  CarouselController _carouselController = CarouselController();

  List<User> _DisplayListUser = [];
  List<Member> _DisplayListMember = [];
  List<Bannerimage> Bennerlist = [];
  List<Latestproduct> Latestproductlist = [];
  List<Upcoming> GameComming = [];
  List<Updateprice> priceGoldSiliver = [];

// User profile
  Future LoadApis() async {
    await _firstLoad();
    await GetBenner();
    await getLetestProduct();
    await GetUpcommingGame();
    await getPrice();
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    await _firstLoad();
    await GetBenner();
    await getLetestProduct();
    await GetUpcommingGame();
    await getPrice();
  }

  final GlobalKey<SliderDrawerWidgetState> drawerKey = GlobalKey();
  bool toggleBackgroundState = false;

  @override
  Widget build(BuildContext context) {
    if (_DisplayListUser.isNotEmpty &&
        _DisplayListMember.isNotEmpty &&
        priceGoldSiliver.isNotEmpty) {
      // return SliderDrawerWidget(
      //   key: drawerKey,
      // option: SliderDrawerOption(
      //   backgroundImage: toggleBackgroundState
      //       ? Image.asset("assets/sample_background.jpg")
      //       : Image.asset("assets/sample_background2.jpg"),
      //   backgroundColor: Colors.black,
      //   sliderEffectType: SliderEffectType.Rounded,
      //   upDownScaleAmount: 50,
      //   radiusAmount: 50,
      //   direction: SliderDrawerDirection.LTR,
      // ),
      // drawer: CustomDrawer(),
      // body: Scaffold(
      //   appBar: AppBar(
      //     leading: GestureDetector(
      //       onTap: () {
      //         drawerKey.currentState!.toggleDrawer();
      //       },
      //       child: Icon(Icons.menu),
      //     ),
      //     actions: [
      //       GestureDetector(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) =>
      //                   ProfileScreen(_DisplayListMember.first),
      //             ),
      //           ).then((_) async {
      //             // await _firstLoad();
      //             // await _firstLoadSend();
      //           });
      //         },
      //         child: Padding(
      //           padding: const EdgeInsets.all(15.0),
      //           child: Icon(Icons.person_2),
      //         ),
      //       ),
      //     ],
      //   ),
      return Scaffold(
        drawer: Drawer(
            elevation: 10.0,
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstant
                    .whiteA700, // Set the background color of the drawer
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                      decoration:
                          BoxDecoration(color: ColorConstant.lightBlue701),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                                height: 100,
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    "assets/images/maalogo.jpg",
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ),
                          Text("Maa Alankar Jewellers",
                              style: GoogleFonts.salsa(color: Colors.white))
                        ],
                      )),
                  ListTile(
                    title: InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        _firstLoad();
                      },
                      child: Row(
                        children: [
                          ImageIcon(
                            AssetImage("assets/images/home.png"),
                            color: Colors.black,
                            size: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Home",
                              style: GoogleFonts.sura(
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: InkWell(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Rozerpay_Screeen()
                              // PhonePe_Screen(),
                              ),
                        ).then((_) async {
                          Navigator.pop(context);
                          await LoadApis();
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.payment_outlined,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Payment',
                              style: GoogleFonts.sura(
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => WinnersScreen(),
                        ))
                            .then((_) async {
                          Navigator.pop(context);
                          await LoadApis();
                          ;
                        });
                      },
                      child: Row(
                        children: [
                          ImageIcon(
                            AssetImage("assets/images/winner.png"),
                            color: Colors.black,
                            size: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Winners",
                              style: GoogleFonts.sura(
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => ShoppingScreen(),
                        ))
                            .then((_) async {
                          Navigator.pop(context);
                          await LoadApis();
                        });
                      },
                      child: Row(
                        children: [
                          ImageIcon(
                            AssetImage("assets/images/shope.png"),
                            color: Colors.black,
                            size: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Shop",
                              style: GoogleFonts.sura(
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => SupportScreen(),
                        ))
                            .then((_) async {
                          Navigator.pop(context);
                          await LoadApis();
                        });
                      },
                      child: Row(
                        children: [
                          ImageIcon(
                            AssetImage("assets/images/supportss.png"),
                            color: Colors.black,
                            size: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Support",
                              style: GoogleFonts.sura(
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => Privacy_PolicyScreen(),
                        ))
                            .then((_) async {
                          Navigator.pop(context);
                          await LoadApis();
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.policy_outlined,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Privacy Policy",
                              style: GoogleFonts.sura(
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => Return_PolicyScreen(),
                        ))
                            .then((_) async {
                          Navigator.pop(context);
                          await LoadApis();
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.policy_outlined,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Return Policy",
                              style: GoogleFonts.sura(
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => Shipping_PolicyScreen(),
                        ))
                            .then((_) async {
                          Navigator.pop(context);
                          await LoadApis();
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.policy_outlined,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Shipping Policy",
                              style: GoogleFonts.sura(
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Center(
                      child: ElevatedButton(
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false,
                      );

                      // Add the action you want when the logout icon is pressed
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.lightBlue701,
                    ),
                    child: Text(
                      "Log Out",
                      style: GoogleFonts.sura(color: Colors.white),
                    ),
                  )),
                  // version maintain
                  // Center(child: Text("Version  0.1")),
                ],
              ),
            )),

        appBar: AppBar(
          title: Text(
            'Maa Alankar Jewellers',
            style: GoogleFonts.salsa(color: ColorConstant.whiteA700),
          ),
          actions: [
            Row(
              children: [
                // Text(
                //   "Profile",
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                IconButton(
                  icon: Icon(Icons.person_2_outlined),
                  color: Color.fromARGB(255, 0, 0, 0), // Icon color
                  iconSize: 25.0, // Icon size
                  splashRadius: 35.0, // Splash radius
                  padding: EdgeInsets.all(16.0), // Padding around the icon
                  alignment: Alignment
                      .center, // Alignment of the icon within the button
                  tooltip: 'Add', // Tooltip text
                  splashColor: Colors.green, // Splash color when pressed
                  highlightColor: Color.fromARGB(255, 44, 51, 238),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ),
                    ).then((_) async {
                      await _firstLoad();
                      // await _firstLoadSend();
                    });
                  },
                ),
              ],
            ),
          ],
          backgroundColor: ColorConstant.puregolden,
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: WillPopScope(
              onWillPop: () => _onWillPop(context),
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent
                    // image: DecorationImage(
                    // image: AssetImage(
                    //     'assets/images/flashscreen.jpg'), // Replace with your image asset path
                    // fit: BoxFit.cover,
                    // ),
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //profile
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Welcome ",
                                  style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      color: ColorConstant.cyan302),
                                ),
                                Text(
                                  _DisplayListMember.first.proprietername
                                      .toString(),
                                  style: GoogleFonts.tauri(
                                      fontSize: 18,
                                      color: ColorConstant.black900),
                                ),
                              ],
                            ),
                            Text(
                              _DisplayListMember.first.lucky ?? "",
                              style: GoogleFonts.tauri(
                                  fontSize: 18, color: ColorConstant.black900),
                            ),
                          ],
                        ),
                      ),
                      //Banner
                      CarouselSlider.builder(
                        itemCount: Bennerlist.length,
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          if (Bennerlist.isNotEmpty) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                Bennerlist[index].banner.toString(),
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            );
                          } else {
                            return Center(
                                child: CircularProgressIndicator(
                              // value: 0.7,

                              backgroundColor: Color.fromARGB(255, 247, 222, 5),
                              color: Colors.red[200],
                              strokeWidth: 5.0,
                            ));
                          }
                        },
                        options: CarouselOptions(
                          height: 180,
                          enlargeCenterPage: true,
                          autoPlayAnimationDuration: Duration(seconds: 4),
                          // autoPlayInterval: Duration(seconds: 15),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          // autoPlayCurve = Curves.fastOutSlowIn,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                        ),
                      ),
                      SizedBox(height: 10),
                      // gold sliver prices
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            GoldScreen(
                                                priceGoldSiliver.first)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(width: 0.5)),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Today's Gold Price",
                                        style: GoogleFonts.lato(fontSize: 15),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          height: 100,
                                          width: 150,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.asset(
                                              "assets/images/gold.png",
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 150,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "₹ " +
                                                  priceGoldSiliver
                                                      .first.goldprice
                                                      .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    convertDateFormat(
                                                        priceGoldSiliver
                                                            .first.date
                                                            .toString()),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  Text(
                                                    "$Day",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Text(
                                            //   "$Day",
                                            //   style: GoogleFonts.montserrat(
                                            //     fontSize: 10,
                                            //   ),
                                            // ),
                                            // Expanded(
                                            //     child: Text(
                                            //   "This Product is in my shop and best offer for a time priode",
                                            //   style: TextStyle(fontSize: 12),
                                            // )),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "View more >>",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            /*  Container(
                              decoration: BoxDecoration(
                                  // boxShadow: [
                                  // BoxShadow(
                                  //   color:
                                  //       const Color.fromARGB(255, 72, 71, 71)
                                  //           .withOpacity(0.5),
                                  //   spreadRadius: 2,
                                  //   blurRadius: 0,
                                  //   offset: Offset(0, 0),
                                  // ),
                                  // ],
                                  border: Border.all(width: 0.1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          convertDateFormat(priceGoldSiliver
                                              .first.date
                                              .toString()),
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          "$Day",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(2),
                                    child: Text(
                                      "Gold Price",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(2),
                                    child: Text(
                                      "₹" +
                                          priceGoldSiliver.first.goldprice
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                         */
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SilverScreen(
                                                priceGoldSiliver.first)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(width: 0.5)),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Today's Silver Price",
                                        style: GoogleFonts.lato(fontSize: 15),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          height: 100,
                                          width: 150,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.asset(
                                              "assets/images/silver.jpg",
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 150,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "₹ " +
                                                  priceGoldSiliver
                                                      .first.silverprice
                                                      .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    convertDateFormat(
                                                        priceGoldSiliver
                                                            .first.date
                                                            .toString()),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  Text(
                                                    "$Day",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Expanded(
                                            //     child: Text(
                                            //   "This Product is in my shop and best offer for a time priode",
                                            //   style: TextStyle(fontSize: 12),
                                            // )),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "View more >>",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            /*  Container(
                              decoration: BoxDecoration(
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color:
                                  //         const Color.fromARGB(255, 72, 71, 71)
                                  //             .withOpacity(0.5),
                                  //     spreadRadius: 2,
                                  //     blurRadius: 0,
                                  //     offset: Offset(0, 0),
                                  //   ),
                                  // ],
                                  border: Border.all(width: 0.1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          convertDateFormat(priceGoldSiliver
                                              .first.date
                                              .toString()),
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          "$Day",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(2),
                                    child: Text(
                                      " Silver Price",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(2),
                                    child: Text(
                                      "₹" +
                                          priceGoldSiliver.first.silverprice
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          
                          */
                          ),
                        ],
                      ),

                      //winner list
                      /*  SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Winner",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              height: 0.05,
                              color: const Color.fromARGB(255, 23, 23, 23),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "1st Winner 🎉",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Row(
                                    children: [
                                      Text("Winner Name : "),
                                      Text("Mohan"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Date : "),
                                      Text("01/02/2024"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
*/
                      //upcomming game
                      SizedBox(
                        height: 5,
                      ),
                      if (GameComming.isNotEmpty)
                        Builder(builder: (context) {
                          if (GameComming.isNotEmpty) {
                            return Container(
                              // decoration: BoxDecoration(
                              //     border: Border.all(width: 0.1),
                              //     borderRadius: BorderRadius.circular(10),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.5),
                                  borderRadius: BorderRadius.circular(20)),

                              // ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      "Next Game",
                                      style: GoogleFonts.lato(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    height: 0.5,
                                    color:
                                        const Color.fromARGB(255, 23, 23, 23),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Venue : ",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              GameComming.first.venue!,
                                              style: GoogleFonts.lato(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Container(
                                        //   height: 0.05,
                                        //   color: const Color.fromARGB(
                                        //       255, 23, 23, 23),
                                        // ),
                                        //  Row(
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //   children: [
                                        //     Text(
                                        //       "Group : ",
                                        //       style: TextStyle(fontSize: 20),
                                        //     ),
                                        //     Text(
                                        //       GameComming.first.gamedate!,
                                        //       style: TextStyle(fontSize: 20),
                                        //     ),
                                        //   ],
                                        // ),
                                        Container(
                                          height: 0.05,
                                          color: const Color.fromARGB(
                                              255, 23, 23, 23),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Date : ",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              convertDateFormatAll(
                                                  GameComming.first.gamedate!),
                                              style: GoogleFonts.lato(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 0.05,
                                          color: const Color.fromARGB(
                                              255, 23, 23, 23),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Time : ",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              convertTo12HourFormat(
                                                  GameComming.first.gametime!),
                                              style: GoogleFonts.lato(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Row(
                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                        //   children: [
                                        //     Text(
                                        //       "Vanue : ",
                                        //       style: TextStyle(fontSize: 20),
                                        //     ),
                                        //     Text(
                                        //       "Online",
                                        //       style: TextStyle(fontSize: 20),
                                        //     ),
                                        //   ],
                                        // ),
                                        Container(
                                          height: 0.05,
                                          color: const Color.fromARGB(
                                              255, 23, 23, 23),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Meeting Link : ",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  _launchInBrowser(meetingurl);
                                                },
                                                child: Text(
                                                  "$meetingurl",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      color: Colors.blue),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Center(
                                child: CircularProgressIndicator(
                              // value: 0.7,
                              backgroundColor: Colors.grey[200],
                              color: Colors.blue,
                              strokeWidth: 5.0,
                              semanticsLabel: 'Loading...',
                            ));
                          }
                        }),
                      if (GameComming.isEmpty)
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 0.5)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "Next Game",
                                  style: GoogleFonts.lato(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                height: 0.5,
                                color: const Color.fromARGB(255, 23, 23, 23),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 35.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Next Game update Soon",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                      ),
                                    ),
                                    // Row(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: [
                                    //     Text(
                                    //       "Venue : ",
                                    //       style: GoogleFonts.montserrat(
                                    //         fontSize: 16,
                                    //       ),
                                    //     ),
                                    //     Text(
                                    //       "",
                                    //       style: GoogleFonts.lato(
                                    //         fontSize: 16,
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // // Container(
                                    // //   height: 0.05,
                                    // //   color: const Color.fromARGB(
                                    // //       255, 23, 23, 23),
                                    // // ),
                                    // //  Row(
                                    // //   crossAxisAlignment:
                                    // //       CrossAxisAlignment.start,
                                    // //   children: [
                                    // //     Text(
                                    // //       "Group : ",
                                    // //       style: TextStyle(fontSize: 20),
                                    // //     ),
                                    // //     Text(
                                    // //       GameComming.first.gamedate!,
                                    // //       style: TextStyle(fontSize: 20),
                                    // //     ),
                                    // //   ],
                                    // // ),
                                    // Container(
                                    //   height: 0.05,
                                    //   color:
                                    //       const Color.fromARGB(255, 23, 23, 23),
                                    // ),
                                    // Row(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: [
                                    //     Text(
                                    //       "Date : ",
                                    //       style: GoogleFonts.montserrat(
                                    //         fontSize: 16,
                                    //       ),
                                    //     ),
                                    //     Text(
                                    //       "",
                                    //       // convertDateFormatAll(""),
                                    //       style: GoogleFonts.lato(
                                    //         fontSize: 16,
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // Container(
                                    //   height: 0.05,
                                    //   color:
                                    //       const Color.fromARGB(255, 23, 23, 23),
                                    // ),
                                    // Row(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: [
                                    //     Text(
                                    //       "Time : ",
                                    //       style: GoogleFonts.montserrat(
                                    //         fontSize: 16,
                                    //       ),
                                    //     ),
                                    //     Text(
                                    //       "",
                                    //       // convertTo12HourFormat(""),
                                    //       style: GoogleFonts.lato(
                                    //         fontSize: 16,
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // // Row(
                                    // //   crossAxisAlignment: CrossAxisAlignment.start,
                                    // //   children: [
                                    // //     Text(
                                    // //       "Vanue : ",
                                    // //       style: TextStyle(fontSize: 20),
                                    // //     ),
                                    // //     Text(
                                    // //       "Online",
                                    // //       style: TextStyle(fontSize: 20),
                                    // //     ),
                                    // //   ],
                                    // // ),
                                    // Container(
                                    //   height: 0.05,
                                    //   color:
                                    //       const Color.fromARGB(255, 23, 23, 23),
                                    // ),
                                    // Row(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: [
                                    //     Text(
                                    //       "Meeting Link : ",
                                    //       style: GoogleFonts.montserrat(
                                    //         fontSize: 16,
                                    //       ),
                                    //     ),
                                    //     Expanded(
                                    //       child: InkWell(
                                    //         onTap: () {
                                    //           // _launchInBrowser(meetingurl);
                                    //         },
                                    //         child: Text(
                                    //           "",
                                    //           style: GoogleFonts.montserrat(
                                    //               fontSize: 12,
                                    //               color: Colors.blue),
                                    //         ),
                                    //       ),
                                    //     ),
                                    // ],
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                      SizedBox(
                        height: 5.0,
                      ),
                      // latest product
                      /*   Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Latest Products",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          CarouselSlider.builder(
                            itemCount: Latestproductlist.length,
                            itemBuilder: (BuildContext context, int index,
                                int realIndex) {
                              if (Latestproductlist.isNotEmpty) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsScreen(
                                                Latestproductlist[index]),
                                      ),
                                    ).then((_) async {
                                      // await _firstLoad();
                                      // await _firstLoadSend();
                                    });
                                  },
                                  child: Image.network(
                                    Latestproductlist[index].latestProduct!,
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator(
                                  // value: 0.7,

                                  backgroundColor:
                                      Color.fromARGB(255, 247, 222, 5),
                                  color: Colors.red[200],
                                  strokeWidth: 5.0,
                                ));
                              }
                            },
                            options: CarouselOptions(
                              height: 120,
                              enlargeCenterPage: true,
                              autoPlayAnimationDuration: Duration(seconds: 4),
                              // autoPlayInterval: Duration(seconds: 15),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              // autoPlayCurve = Curves.fastOutSlowIn,
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                            ),
                          ),
                        ],
                      ),
                      // Card(
                      //   elevation: 10,
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         border: Border.all(width: 0.5),
                      //         borderRadius: BorderRadius.circular(10)),
                      //     child: Column(
                      //       children: [
                      //         Container(
                      //           width: double.infinity,
                      //           // height: double.infinity,
                      //           decoration: BoxDecoration(
                      //               color: Colors.amber[100],
                      //               border: Border.all(width: 0.5),
                      //               borderRadius: BorderRadius.only(
                      //                 topLeft: Radius.circular(10.0),
                      //                 topRight: Radius.circular(10.0),
                      //               )),
                      //           child: Center(
                      //             child: Text(
                      //               "Latest Products",
                      //               style: TextStyle(fontSize: 20),
                      //             ),
                      //           ),
                      //         ),
                      //         // Container(
                      //         //   height: 0.05,
                      //         //   color: const Color.fromARGB(255, 23, 23, 23),
                      //         // ),
                      //         Padding(
                      //           padding: const EdgeInsets.only(top: 8.0),
                      //           child: Container(
                      //             height: 400,
                      //             child: ListView.builder(
                      //               itemCount: Latestproductlist.length,
                      //               shrinkWrap: true,
                      //               itemBuilder: (context, index) {
                      //                 if (Latestproductlist.isNotEmpty) {
                      //                   return Padding(
                      //                     padding:
                      //                         const EdgeInsets.only(top: 8.0),
                      //                     child: Column(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.start,
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [
                      //                         Container(
                      //                           decoration: BoxDecoration(
                      //                               border:
                      //                                   Border.all(width: 0.5),
                      //                               borderRadius:
                      //                                   BorderRadius.circular(
                      //                                       30)),
                      //                           height: 200,
                      //                           // color: ColorConstant.golden,
                      //                           child: Image.network(
                      //                             Latestproductlist[index]
                      //                                 .latestProduct
                      //                                 .toString(),
                      //                             height: double.infinity,
                      //                             width: double.infinity,
                      //                             fit: BoxFit.cover,
                      //                           ),
                      //                         )
                      //                       ],
                      //                     ),
                      //                   );
                      //                 } else {
                      //                   return Center(
                      //                       child: CircularProgressIndicator(
                      //                     // value: 0.7,
                      //                     backgroundColor:
                      //                         Color.fromARGB(255, 199, 253, 49),
                      //                     color: Colors.blue,
                      //                     strokeWidth: 5.0,
                      //                     semanticsLabel: 'Loading...',
                      //                   ));
                      //                 }
                      //               },
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // )
*/
                      // test latets product
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Latestproductlist.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ProductDetailsScreen(
                                                    Latestproductlist[index])));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(width: 0.5)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              height: 100,
                                              width: 150,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  Latestproductlist[index]
                                                      .latestProduct!,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.all(8.0),
                                          //   child: Container(
                                          //     height: 50,
                                          //     width: 150,
                                          //     child: Column(
                                          //       crossAxisAlignment:
                                          //           CrossAxisAlignment.start,
                                          //       children: [
                                          //         Text("₹ 5400"),
                                          //         Expanded(
                                          //             child: Text(
                                          //           "This Product is in my shop and best offer for a time priode",
                                          //           style:
                                          //               TextStyle(fontSize: 12),
                                          //         )),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Maa Alankar Jewellers',
            style: GoogleFonts.salsa(color: ColorConstant.whiteA700),
          ),
          actions: [
            Row(
              children: [
                // Text(
                //   "Profile",
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                IconButton(
                  icon: Icon(Icons.person_2),
                  color: Color.fromARGB(255, 0, 0, 0), // Icon color
                  iconSize: 25.0, // Icon size
                  splashRadius: 35.0, // Splash radius
                  padding: EdgeInsets.all(16.0), // Padding around the icon
                  alignment: Alignment
                      .center, // Alignment of the icon within the button
                  tooltip: 'Add', // Tooltip text
                  splashColor: Colors.green, // Splash color when pressed
                  highlightColor: Color.fromARGB(255, 44, 51, 238),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ),
                    ).then((_) async {
                      await _firstLoad();
                      // await _firstLoadSend();
                    });
                  },
                ),
              ],
            ),
          ],
          backgroundColor: ColorConstant.golden,
        ),
        body: Center(
            child: CircularProgressIndicator(
          // value: 0.7,
          backgroundColor: Colors.grey[200],
          color: Colors.blue,
          strokeWidth: 5.0,
          semanticsLabel: 'Loading...',
        )),
      );
    }
  }

//permission hendler

  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit the app?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _launchInBrowser(String url) async {
    Uri Url = Uri.parse(url);
    if (!await launchUrl(
      Url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

// get user info list
  Future _firstLoad() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      setState(() {
        // username = preferences.getString('username');
      });

      final Uri uri =
          Uri.parse('https://maaalankarjewellers.com/erp/api/logged_user');

      final Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData is Map) {
          final user = jsonData['user'];
          final member = jsonData['member'];

          // if (user is Map && member is Map) {
          User userObject = User.fromJson(user);
          Member memberObject = Member.fromJson(member);

          setState(() {
            _DisplayListUser = [userObject];

            _DisplayListMember = [memberObject];
            // You can add the memberObject to another list if needed.
          });

          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString(
              'username', _DisplayListMember.first.proprietername!);
          preferences.setString('memberid', _DisplayListMember.first.memberid!);
          preferences.setString('contact', _DisplayListMember.first.phone!);
          preferences.setString('email', _DisplayListMember.first.proemail!);
          preferences.setString('slot', _DisplayListMember.first.slot!);

          // } else {
          //   print('User or Member key not found in JSON.');
          // }
        } else {
          print('Data key not found in JSON.');
        }
      } else {
        print('HTTP request failed with status: ${response.statusCode}');
      }
    } catch (err) {
      print('An error occurred: $err');
    }
  }

  //get benner list
  
  Future<void> GetBenner() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      final Uri uri = Uri.parse(
          'https://maaalankarjewellers.com/erp/api/add_bannerlistapi');

      final Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 200) {
        try {
          final jsonData = jsonDecode(response.body);

          // Check if 'bannerimage' key exists
          if (jsonData.containsKey('bannerimage')) {
            final bannerImage = jsonData['bannerimage'];

            // Check if it's a List
            if (bannerImage is List) {
              List<Bannerimage> bannerImages = [];

              for (var bannerData in bannerImage) {
                bannerImages.add(Bannerimage.fromJson(bannerData));
              }

              setState(() {
                Bennerlist = bannerImages;
              });
            } else {
              print('Invalid JSON format: bannerimage is not a list.');

              // Handle the case when 'bannerimage' is not a list
              // You can add your own logic here or set Bennerlist to an empty list, for example
              setState(() {
                Bennerlist = [];
              });
            }
          } else {
            print('Invalid JSON format: bannerimage key is missing.');

            // Handle the case when 'bannerimage' key is missing
            // You can add your own logic here or set Bennerlist to an empty list, for example
            setState(() {
              Bennerlist = [];
            });
          }
        } catch (e) {
          print('Error decoding JSON: $e');
        }
      } else {
        print('HTTP request failed with status: ${response.statusCode}');
      }
    } catch (err) {
      print('An error occurred: $err');
    }
  }

// get latest product list
  Future getLetestProduct() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      final Uri uri = Uri.parse(
          'https://maaalankarjewellers.com/erp/api/add_latestproductapi');

      final Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData is Map) {
          final getlstestproduct = jsonData['latestproduct'];

          List<Latestproduct> bannerImages = [];

          for (var bannerData in getlstestproduct) {
            bannerImages.add(Latestproduct.fromJson(bannerData));
          }

          setState(() {
            Latestproductlist = bannerImages;
          });
        } else {
          print('Data key not found in JSON.');
        }
      } else {
        print('HTTP request failed with status: ${response.statusCode}');
      }
    } catch (err) {
      print('An error occurred: $err');
    }
  }

  // get latest product list
  Future GetUpcommingGame() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      final Uri uri =
          Uri.parse('https://maaalankarjewellers.com/erp/api/upcominggame_api');

      final Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData is Map<String, dynamic>) {
          if (jsonData.containsKey('upcoming')) {
            final upcomingList = jsonData['upcoming'];

            if (upcomingList is List<dynamic>) {
              List<Upcoming> upcomingObjects = [];

              for (var upcomingData in upcomingList) {
                if (upcomingData is Map<String, dynamic>) {
                  upcomingObjects.add(Upcoming.fromJson(upcomingData));
                } else {
                  print('Invalid data format in the upcoming list.');
                }
              }

              setState(() {
                GameComming = upcomingObjects;
              });
            } else {
              print('Invalid JSON format: upcoming key is not a list.');
            }
          } else {
            print('upcoming key not found in JSON.');
          }
        } else {
          print('Invalid JSON format: JSON is not a Map.');
        }
      } else {
        print('HTTP request failed with status: ${response.statusCode}');
      }
    } catch (err) {
      print('An error occurred: $err');
    }
  }

  // get get Price
  Future getPrice() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      final Uri uri =
          Uri.parse('https://maaalankarjewellers.com/erp/api/updateprice_api');

      final Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData is Map) {
          // Check if 'updateprice' is a List
          if (jsonData['updateprice'] is List) {
            final List<dynamic> userList = jsonData['updateprice'];

            // Assuming Updateprice.fromJson is a constructor that takes a Map<String, dynamic>
            List<Updateprice> userObjects =
                userList.map((user) => Updateprice.fromJson(user)).toList();

            setState(() {
              priceGoldSiliver = userObjects;
            });
          } else {
            // Handle the case where 'updateprice' is not a List
            print('Updateprice is not a List in JSON.');
          }
        } else {
          print('Data key not found in JSON.');
        }
      }

      // if (response.statusCode == 200) {
      //   final jsonData = jsonDecode(response.body);
      //   if (jsonData is Map) {
      //     final user = jsonData['updateprice'];

      //     // if (user is Map && member is Map) {
      //     Updateprice userObject = Updateprice.fromJson(user);

      //     setState(() {
      //       priceGoldSiliver = [userObject];
      //       // You can add the memberObject to another list if needed.
      //     });
      //     // });
      //   } else {
      //     print('Data key not found in JSON.');
      //   }
      // } else {
      //   print('HTTP request failed with status: ${response.statusCode}');
      // }
    } catch (err) {
      print('An error occurred: $err');
    }
  }

  //post  token
  Future postToken(fncToken) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      // String? memberid = preferences.getString('memberid');
      String? token = preferences.getString('token');

      var Insertobj = new Map<String, dynamic>();

      // Insertobj["member_id"] = memberid;
      Insertobj["device_id"] = fncToken;

      final Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final request = http.Request("POST",
          Uri.parse('https://maaalankarjewellers.com/erp/api/deviceID'));

      request.headers.addAll(headers);
      request.body = json.encode(Insertobj);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        dynamic json = jsonDecode(await response.stream.bytesToString());
        // if (json["Status"] == "Ok") {
        // return Navigator.pop(context);
        // } else
        //   throw new Exception();
      } else {
        // addData();
      }
      throw new Exception();
    } catch (_, ex) {
      return false;
    }
  }

  String Day = "";
  //date And Time
  String convertDateFormat(String originalDate) {
    // Parse the ISO 8601 date string
    DateTime parsedDate = DateTime.parse(originalDate);

    // Get the day of the month
    int day = parsedDate.day;

    // Determine the suffix for the day
    String daySuffix = _getDaySuffix(day);

    // Format the date with the custom suffix
    String formattedDate =
        DateFormat("d'$daySuffix' MMMM yyyy").format(parsedDate);
    setState(() {
      Day = DateFormat("EEEE").format(parsedDate);
    });

    return formattedDate;
  }

  String convertDateFormatAll(String originalDate) {
    // Parse the ISO 8601 date string
    DateTime parsedDate = DateTime.parse(originalDate);

    // Get the day of the month
    int day = parsedDate.day;

    // Determine the suffix for the day
    String daySuffix = _getDaySuffix(day);

    // Format the date with the custom suffix
    String formattedDate =
        DateFormat("d'$daySuffix' MMMM yyyy").format(parsedDate);
    return formattedDate;
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
  //time converter

  String extractDate(String timestamp) {
    DateTime parsedDateTime = DateTime.parse(timestamp);
    String formattedTime = "${parsedDateTime.hour}:${parsedDateTime.minute}";
    String amPm = parsedDateTime.hour < 12 ? 'AM' : 'PM';
    if (parsedDateTime.hour == 0) {
      formattedTime = "12:${parsedDateTime.minute}";
    } else if (parsedDateTime.hour > 12) {
      formattedTime = "${parsedDateTime.hour - 12}:${parsedDateTime.minute}";
    }
    return "${parsedDateTime.day}/${parsedDateTime.month}/${parsedDateTime.year} ";
  }

  String convertTo12HourFormat(String inputTime) {
    List<String> timeComponents = inputTime.split(':');
    int hour = int.parse(timeComponents[0]);
    int minute = int.parse(timeComponents[1]);

    String period = (hour >= 12) ? 'PM' : 'AM';
    hour = (hour > 12) ? hour - 12 : hour;
    hour = (hour == 0) ? 12 : hour; // Adjust 0 to 12 for 12-hour format

    return "$hour:${_addLeadingZero(minute)} $period";
  }

  String _addLeadingZero(int number) {
    return number.toString().padLeft(2, '0');
  }

  String getCurrentDateTime(String period) {
    DateTime now = DateTime.now();
    period = now.hour >= 12 ? 'PM' : 'AM';
    int hour = now.hour > 12 ? now.hour - 12 : now.hour;

    String formattedDateTime = " $hour:${_addLeadingZero(now.minute)} $period";
    return formattedDateTime;
  }
}
