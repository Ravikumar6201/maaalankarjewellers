// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation, avoid_print, non_constant_identifier_names, unnecessary_new, curly_braces_in_flow_control_structures, unused_catch_stack, prefer_collection_literals, prefer_typing_uninitialized_variables, unnecessary_string_interpolations, unused_field, constant_identifier_names, unnecessary_null_comparison
import 'dart:convert';
import 'dart:io';
import 'package:MaaAlankar/Models/Payment.dart';
import 'package:MaaAlankar/Screen/Paymet/NotificationsPay.dart';
import 'package:MaaAlankar/Screen/Paymet/PaymentPage.dart';
import 'package:MaaAlankar/Screen/Paymet/Paytm_PaymentGetway.dart';
import 'package:MaaAlankar/Screen/Paymet/PhonePePaymentgetway.dart';
import 'package:MaaAlankar/Screen/Paymet/QR_CODE.dart';
import 'package:MaaAlankar/Screen/Paymet/Transictionhistory.dart';
import 'package:MaaAlankar/class/constant.dart';
import 'package:crypto/crypto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:MaaAlankar/class/Colorconstant.dart';
import 'package:intl/intl.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Rozerpay_Screeen extends StatefulWidget {
  @override
  _Rozerpay_ScreeenState createState() => _Rozerpay_ScreeenState();
}

class _Rozerpay_ScreeenState extends State<Rozerpay_Screeen> {
  List<Paymenthistory> _paymentHistory = [];
  List<Paymentlist> _paymentList = [];
  List<Paymentremainder> _paymentremainder = [];
  Razorpay _razorpay = Razorpay();
  TextEditingController amtController = TextEditingController();
  String TransictionIds = DateTime.now().millisecondsSinceEpoch.toString();

  // Response codes from platform
  static const _CODE_PAYMENT_SUCCESS = 0;
  static const _CODE_PAYMENT_ERROR = 1;
  static const _CODE_PAYMENT_EXTERNAL_WALLET = 2;

  // Event names
  static const EVENT_PAYMENT_SUCCESS = 'payment.success';
  static const EVENT_PAYMENT_ERROR = 'payment.error';
  static const EVENT_EXTERNAL_WALLET = 'payment.external_wallet';

  // Payment error codes
  static const NETWORK_ERROR = 0;
  static const INVALID_OPTIONS = 1;
  static const PAYMENT_CANCELLED = 2;
  static const TLS_ERROR = 3;
  static const INCOMPATIBLE_PLUGIN = 4;
  static const UNKNOWN_ERROR = 100;
  bool _load = false;
  String? slot;

  void openCheckout(double amount) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? contact = preferences.getString('contact');
    String? token = preferences.getString('token');
    String? email = preferences.getString('email');
    setState(() {
      slot = preferences.getString('slot');
    });
    var options = {
      'key': 'rzp_test_sE877MMJ8mLCzT',
      'amount': amount, // amount in paise
      'name': 'Maa Alankar Jewellers',
      'transictionId': '$TransictionIds',
      'description': 'Game Fee ',
      'prefill': {
        'contact': '$contact',
        'email': '$email',
      },
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  //get response

  // api post
  final razorPayKey = "rzp_test_sE877MMJ8mLCzT";
  final razorPaySecret = "YDu04kiWgaSgOuL1POgaI9ZA";
  var store_api_token, Url = Constant(), balance, credit, cod, total = 0.0;
//1st function

  String paymentId = "";
//3rd function
  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    setState(() {
      paymentId = response.paymentId.toString();
    });

    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      var Insertobj = new Map<String, dynamic>();

      Insertobj["amount"] = 2000;

      final Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final request = http.Request("POST",
          Uri.parse('https://maaalankarjewellers.com/erp/api/makePayment'));

      request.headers.addAll(headers);
      request.body = json.encode(Insertobj);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        dynamic json = jsonDecode(await response.stream.bytesToString());
        if (json["status"] == "secuss") {
          ConfirmPayment(paymentId);
          // return Navigator.pop(context);
        } else
          throw new Exception();
      } else {
        // addData();
      }
      throw new Exception();
    } catch (_, ex) {
      // return false;
    }
  }

  ConfirmPayment(String paymentId) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      String? memberid = preferences.getString('memberid');
      String Online = "online";

      var cunfirmMap = new Map<String, dynamic>();

      cunfirmMap["paymentId"] = paymentId;
      cunfirmMap["member_id"] = memberid.toString();
      cunfirmMap["pay_mode"] = Online.toString();
      cunfirmMap["date"] = DateTime.now().toString();
      // Insertobj["orderId"] = json.;

      final Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final confirmrequest = http.Request("POST",
          Uri.parse('https://maaalankarjewellers.com/erp/api/confirmPayment'));

      confirmrequest.headers.addAll(headers);
      confirmrequest.body = json.encode(cunfirmMap);
      http.StreamedResponse response = await confirmrequest.send();

      if (response.statusCode == 200) {
        dynamic json = jsonDecode(await response.stream.bytesToString());
        if (json["message"] == "Payment confirmed successfully") {
          Fluttertoast.showToast(
            msg: "Payment confirmed successfully",
            toastLength: Toast.LENGTH_SHORT, // Duration of the toast
            gravity: ToastGravity.BOTTOM, // Toast position
            timeInSecForIosWeb: 1, // Duration for iOS
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          await getHistory();
          await getDueList();
          await getDueListChecher();
        } else
          throw new Exception();
      } else {
        // addData();
      }
      throw new Exception();
    } catch (_, ex) {
      // return false;
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Payment error: ${response.code.toString()} - ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External wallet selected: ${response.walletName}');
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getHistory();
    getDueList();
    getDueListChecher();
    PhonepeInit();
    body = getCheckSum().toString();
    // main();
  }

  int test = 14;
  int due = 1;

  // payment list
  // List<bool> installmentPaymentStatusList = List.generate(25, (index) => false);
// timme priod

  bool isActivationPeriod() {
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Check if the current date is between the 15th and 20th of the month
    if (currentDate.day >= 15 && currentDate.day <= 20) {
      return true;
    } else {
      return false;
    }
  }

  // void main() {
  //   // Example usage
  //   if (isActivationPeriod()) {
  //     print("Activation period is active!");
  //   } else {
  //     print("Activation period is not active.");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Filter out items with status 'pending'
    final List<Paymentlist> filteredItems =
        _paymentList.where((item) => item.dueMonth == dueMonth).toList();
    if (test != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Payment',
            style: GoogleFonts.salsa(color: ColorConstant.whiteA700),
          ),
          backgroundColor: ColorConstant.puregolden,
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.notification_add_outlined),
          //     color: Color.fromARGB(255, 0, 0, 0), // Icon color
          //     iconSize: 25.0, // Icon size
          //     splashRadius: 35.0, // Splash radius
          //     padding: EdgeInsets.all(16.0), // Padding around the icon
          //     alignment:
          //         Alignment.center, // Alignment of the icon within the button
          //     tooltip: 'Add', // Tooltip text
          //     splashColor: Colors.green, // Splash color when pressed
          //     highlightColor: Color.fromARGB(255, 44, 51, 238),
          //     onPressed: () async {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => NotificationsScreenPayment(),
          //         ),
          //       ).then((_) async {
          //         // await _firstLoad();
          //         // await _firstLoadSend();
          //       });
          //     },
          //   ),
          // ],
        ),
        // ignore: deprecated_member_use
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (filteredItems.isNotEmpty)
                  Container(
                    height: 80,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Build your list item here using filteredItems[index]
                        return Card(
                            elevation: 2,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Due Amount : ",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              Text(
                                                "₹ " +
                                                    filteredItems[index]
                                                        .amount
                                                        .toString(),
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 0.05,
                                            color: const Color.fromARGB(
                                                255, 23, 23, 23),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Due Month : ",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              Text(
                                                filteredItems[index]
                                                    .dueMonth
                                                    .toString(),
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          // Container(
                                          //   height: 0.05,
                                          //   color:
                                          //       const Color.fromARGB(255, 23, 23, 23),
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     Text(
                                          //       "Date : ",
                                          //       style: TextStyle(fontSize: 16),
                                          //     ),
                                          //     Text(
                                          //       "25/10/2023",
                                          //       style: TextStyle(fontSize: 16),
                                          //     ),
                                          //   ],
                                          // ),
                                          // Container(
                                          //   height: 0.05,
                                          //   color:
                                          //       const Color.fromARGB(255, 23, 23, 23),
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     Text(
                                          //       "Time : ",
                                          //       style: TextStyle(fontSize: 16),
                                          //     ),
                                          //     Text(
                                          //       "03:30 Pm",
                                          //       style: TextStyle(fontSize: 16),
                                          //     ),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    flex: 4,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          // razorPayApi(100);
                                          // openCheckout(2000);
                                          StartpgTransiction();
                                          /*  Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    QR_CODEScreen(
                                                        filteredItems[index]
                                                            .dueMonth
                                                            .toString(),
                                                        filteredItems[index]
                                                            .amount
                                                            .toString())),
                                          ).then((_) async {
                                            getHistory();
                                            getDueList();
                                            getDueListChecher();
                                            // await _firstLoadSend();
                                          });*/
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ColorConstant.golden,
                                        ),
                                        child: Text("Pay Now")))
                              ],
                            ));
                      },
                    ),
                  ),
                if (filteredItems.isEmpty)
                  Card(
                      elevation: 2,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Due Amount : ",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          "₹ 2000",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    // Container(
                                    //   height: 0.05,
                                    //   color:
                                    //       const Color.fromARGB(255, 23, 23, 23),
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       "Due Date : ",
                                    //       style: TextStyle(fontSize: 16),
                                    //     ),
                                    //     Text(
                                    //       "05-03-2024",
                                    //       style: TextStyle(fontSize: 16),
                                    //     ),
                                    //   ],
                                    // ),
                                    Container(
                                      height: 0.05,
                                      color:
                                          const Color.fromARGB(255, 23, 23, 23),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Due Month : ",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          "1st",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    // Container(
                                    //   height: 0.05,
                                    //   color:
                                    //       const Color.fromARGB(255, 23, 23, 23),
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       "Date : ",
                                    //       style: TextStyle(fontSize: 16),
                                    //     ),
                                    //     Text(
                                    //       "25/10/2023",
                                    //       style: TextStyle(fontSize: 16),
                                    //     ),
                                    //   ],
                                    // ),
                                    // Container(
                                    //   height: 0.05,
                                    //   color:
                                    //       const Color.fromARGB(255, 23, 23, 23),
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       "Time : ",
                                    //       style: TextStyle(fontSize: 16),
                                    //     ),
                                    //     Text(
                                    //       "03:30 Pm",
                                    //       style: TextStyle(fontSize: 16),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 4,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    StartpgTransiction();
                                    // razorPayApi(100);
                                    // openCheckout(2000);
                                    /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              QR_CODEScreen("1st", "2000")),
                                    ).then((_) async {
                                      getHistory();
                                      getDueList();
                                      getDueListChecher();
                                      // await _firstLoadSend();
                                    });*/
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorConstant.golden,
                                  ),
                                  child: Text("Pay Now")))
                        ],
                      )),

                SizedBox(
                  height: 5,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     children: [
                //       ElevatedButton(
                //           onPressed: () {
                //             Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => QR_CODEScreen()),
                //             ).then((_) async {

                //               // await _firstLoadSend();
                //             });
                //           },
                //           child: Text("Phone Pe")),
                //       ElevatedButton(
                //           onPressed: () {
                //             Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => PAymentScreen()),
                //             ).then((_) async {
                //               // await _firstLoad();
                //               // await _firstLoadSend();
                //             });
                //           },
                //           child: Text("Paytm")),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 5,
                // ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "History ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  color: const Color.fromARGB(255, 23, 23, 23),
                ),
                SizedBox(
                  height: 5,
                ),
                if (_paymentHistory.isNotEmpty)
                  Container(
                    height: 600,
                    child: ListView.builder(
                      itemCount: _paymentHistory.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentHistoryPage(
                                      _paymentHistory[index])),
                            ).then((_) async {
                              getHistory();
                              getDueList();
                              getDueListChecher();
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1 * 0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: ImageIcon(
                                              AssetImage(
                                                  "assets/images/sends.png"),
                                              color: Color.fromARGB(
                                                  255, 94, 2, 255),
                                              size: 50,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          convertDateFormat(
                                              _paymentHistory[index]
                                                  .createdAt
                                                  .toString()),
                                          // "01 Jan 2024",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                    // Container(
                                    //   height: 0.05,
                                    //   color: const Color.fromARGB(255, 23, 23, 23),
                                    // ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Paid to",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Maa Alankar Jewellers",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                convertToReadableDateTime(
                                                    _paymentHistory[index]
                                                        .createdAt
                                                        .toString()),
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Container(
                                    //   height: 0.05,
                                    //   color: const Color.fromARGB(255, 23, 23, 23),
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       "Date : ",
                                    //       style: TextStyle(fontSize: 16),
                                    //     ),
                                    //     Text(
                                    //       "25/10/2023",
                                    //       style: TextStyle(fontSize: 16),
                                    //     ),
                                    //   ],
                                    // ),)
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "₹ " +
                                              _paymentHistory[index]
                                                  .amount
                                                  .toString(),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Pay Mode",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          _paymentHistory[index]
                                              .payMode
                                              .toString(),
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        if (_paymentHistory[index].status ==
                                            "pending")
                                          Text(
                                            "Status " +
                                                _paymentHistory[index]
                                                    .status
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: ColorConstant.redA700),
                                          ),
                                        if (_paymentHistory[index].status !=
                                            "pending")
                                          Text(
                                            _paymentHistory[index]
                                                    .month
                                                    .toString() +
                                                " Paid",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: ColorConstant.green900),
                                          ),
                                        // Text(
                                        //   _paymentHistory[index]
                                        //       .payMode
                                        //       .toString(),
                                        //   style: TextStyle(fontSize: 10),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 1,
                                color: const Color.fromARGB(255, 23, 23, 23),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                if (_paymentHistory.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Text("No Record"),
                  )
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Rozerpay_Screeen Screen",
          ),
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

//get data from transictionn history

  // get get Price
  Future getHistory() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      final Uri uri = Uri.parse(
          'https://maaalankarjewellers.com/erp/api/getPaymentHistory');

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
          if (jsonData['paymenthistory'] is List) {
            final List<dynamic> userList = jsonData['paymenthistory'];

            // Assuming Updateprice.fromJson is a constructor that takes a Map<String, dynamic>
            List<Paymenthistory> userObjects =
                userList.map((user) => Paymenthistory.fromJson(user)).toList();

            setState(() {
              _paymentHistory = userObjects;
            });
          } else {
            // Handle the case where 'updateprice' is not a List
            print('Updateprice is not a List in JSON.');
          }
        } else {
          print('Data key not found in JSON.');
        }
      }
    } catch (err) {
      print('An error occurred: $err');
    }
  }

  Future getDueList() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      final Uri uri =
          Uri.parse('https://maaalankarjewellers.com/erp/api/getPaymentList');

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
          if (jsonData['paymentlist'] is List) {
            final List<dynamic> userList = jsonData['paymentlist'];

            // Assuming Updateprice.fromJson is a constructor that takes a Map<String, dynamic>
            List<Paymentlist> userObjects =
                userList.map((user) => Paymentlist.fromJson(user)).toList();

            setState(() {
              _paymentList = userObjects;
            });
          } else {
            // Handle the case where 'updateprice' is not a List
            print('Updateprice is not a List in JSON.');
          }
        } else {
          print('Data key not found in JSON.');
        }
      }
    } catch (err) {
      print('An error occurred: $err');
    }
  }

  String dueMonth = "";
  Future getDueListChecher() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      final Uri uri = Uri.parse(
          'https://maaalankarjewellers.com/erp/api/getPaymentRmainder');

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
          final paymentremainder = jsonData['paymentremainder'];

          // if (user is Map && member is Map) {
          Paymentremainder paymentremainderObject =
              Paymentremainder.fromJson(paymentremainder);

          setState(() {
            _paymentremainder = [paymentremainderObject];
            dueMonth = _paymentremainder.first.dueMonth;
            // You can add the memberObject to another list if needed.
          });
          // if (response.statusCode == 200) {
          //   final jsonData = jsonDecode(response.body);
          //   if (jsonData is Map) {
          //     // Check if 'updateprice' is a List
          //     if (jsonData['paymentremainder'] is Map) {
          //       final List<dynamic> userList = jsonData['paymentremainder'];
          //       // Assuming Updateprice.fromJson is a constructor that takes a Map<String, dynamic>
          //       List<Paymentremainder> userObjects = userList
          //           .map((user) => Paymentremainder.fromJson(user))
          //           .toList();
          //       setState(() {
          //         _paymentremainder = userObjects;
          //       });
          //     } else {
          //       // Handle the case where 'updateprice' is not a List
          //       print('Updateprice is not a List in JSON.');
          //     }
          //   } else {
          //     print('Data key not found in JSON.');
        }
      }
    } catch (err) {
      print('An error occurred: $err');
    }
  }

  String convertDateFormat(String originalDate) {
    // Parse the ISO 8601 date string
    DateTime parsedDate = DateTime.parse(originalDate);

    // Get the day of the month
    int day = parsedDate.day;

    // Determine the suffix for the day
    String daySuffix = _getDaySuffix(day);

    // Format the date with the custom suffix
    String formattedDate = DateFormat("dd MMMM yyyy").format(parsedDate);
    // setState(() {
    //   Day = DateFormat("EEEE").format(parsedDate);
    // });

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

  String _addLeadingZero(int number) {
    return number.toString().padLeft(2, '0');
  }

  String convertToReadableDateTime(String originalDateTimeString) {
    DateTime dateTime = DateTime.parse(originalDateTimeString)
        .toLocal(); // Convert to DateTime object
    String amPm = dateTime.hour < 12 ? 'AM' : 'PM';

    String formattedDateTime =
        // "${_addLeadingZero(dateTime.year)}-${_addLeadingZero(dateTime.month)}-${_addLeadingZero(dateTime.day)} "
        "${_addLeadingZero(dateTime.hour)}:${_addLeadingZero(dateTime.minute)}";

//  String convertTo12HourFormat(String inputTime) {
    List<String> timeComponents = formattedDateTime.split(':');
    int hour = int.parse(timeComponents[0]);
    int minute = int.parse(timeComponents[1]);

    String period = (hour >= 12) ? 'PM' : 'AM';
    hour = (hour > 12) ? hour - 12 : hour;
    hour = (hour == 0) ? 12 : hour; // Adjust 0 to 12 for 12-hour format

    return "$hour:${_addLeadingZero(minute)} $period";
  }

  // phone pe payment getway

  //Payment getway
  String environment = "SANDBOX";
  String appId = "";
  String TransictionId = DateTime.now().millisecondsSinceEpoch.toString();
  String merchantId = "PGTESTPAYUAT";
  bool enableLogging = true;
  String checksum = "";
  String soltKey = "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399";
  String soltIndex = "1";
  String callBackutl = "google.com";
  String body = "";
  Object? result;
  String urlendpoint = "";
  String apiEndPoint = "/pg/v1/pay";

  void PhonepeInit() {
    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
              setState(() {
                result = 'PhonePe SDK Initialized - $val';
              })
            })
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }

  // Stert pgtransiction

  void StartpgTransiction() async {
    PhonePePaymentSdk.startTransaction(body, callBackutl, checksum, apiEndPoint)
        .then((response) async {
      // setState(() {
      if (response != null) {
        String status = response['status'].toString();
        String error = response['error'].toString();
        if (status == 'SUCCESS') {
          result = "Flow Status complete Secuss";
          await CheckStatus();
          print(status);

          Text(status.toString());
          // "Flow Completed - Status: Success!";
        } else {
          result = "Flow Status $status And error $error";
        }
      } else {
        // "Flow Incomplete";
      }
      // });
    }).catchError((error) {
      // handleError(error)
      return <dynamic>{};
    });
  }

  getCheckSum() {
    final requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": TransictionId,
      "merchantUserId": "90223250",
      "amount": 2000 * 100,
      "mobileNumber": "9999999999",
      "callbackUrl": "https://webhook.site/callback-url",
      "paymentInstrument": {"type": "PAY_PAGE"},
      // "deviceContext": {"deviceOS": "ANDROID"}
    };
    String base64Body = base64.encode(utf8.encode(json.encode(requestData)));
    checksum =
        "${sha256.convert(utf8.encode(base64Body + apiEndPoint + soltKey)).toString()}###$soltIndex";
    return base64Body;
  }

  Future CheckStatus() async {
    try {
      String url =
          "https://api-preprod.phonepe.com/apis/pg-sandbox/pg/v1/status/merchantId/$TransictionId";
      String ConcatString = "/pg/v1/status/$merchantId/$TransictionId$soltKey";
      var bytes = utf8.encode(ConcatString);
      var degest = sha256.convert(bytes).toString();

      String xVerify = "$degest###$soltIndex";
      final Map<String, String> headers = {
        'Accept': 'application/json',
        'X-VERIFY': xVerify,
        'X-MERCHANT-ID': merchantId,
      };

      await http
          .get(
        Uri.parse(url),
        headers: headers,
      )
          .then((value) {
        Map<String, dynamic> res = jsonDecode(value.body);
        try {
          if (res["success"] &&
              res["code"] == "PAYMENT_SUCCESS" &&
              res["data"]["state"] == "COMPLETED") {
            Fluttertoast.showToast(msg: res["message"]);
          } else {
            Fluttertoast.showToast(msg: "Something Wrong");
          }
        } catch (e, _) {
          Fluttertoast.showToast(msg: "$e");
        }
      });
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: "$e");
    }
  }

  void handleError(error) {
    setState(() {
      result = {"error": error};
    });
  }
}
