// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, avoid_unnecessary_containers, non_constant_identifier_names, avoid_print, invalid_return_type_for_catch_error, unused_element
import 'dart:convert';
import 'package:MaaAlankar/Screen/Paymet/NotificationsPay.dart';
import 'package:MaaAlankar/Screen/Paymet/Rozerpay_Screen.dart';
import 'package:MaaAlankar/Screen/Paymet/Transictionhistory.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:MaaAlankar/class/Colorconstant.dart';

class PhonePe_Screen extends StatefulWidget {
  @override
  _PhonePe_ScreenState createState() => _PhonePe_ScreenState();
}

class _PhonePe_ScreenState extends State<PhonePe_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PhonepeInit();
    body = getCheckSum().toString();
  }

  int test = 14;
  int due = 1;
  @override
  Widget build(BuildContext context) {
    if (test != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Payment',
            style: GoogleFonts.salsa(color: ColorConstant.whiteA700),
          ),
          backgroundColor: ColorConstant.puregolden,
          actions: [
            IconButton(
              icon: Icon(Icons.notification_add_outlined),
              color: Color.fromARGB(255, 0, 0, 0), // Icon color
              iconSize: 25.0, // Icon size
              splashRadius: 35.0, // Splash radius
              padding: EdgeInsets.all(16.0), // Padding around the icon
              alignment:
                  Alignment.center, // Alignment of the icon within the button
              tooltip: 'Add', // Tooltip text
              splashColor: Colors.green, // Splash color when pressed
              highlightColor: Color.fromARGB(255, 44, 51, 238),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationsScreenPayment(),
                  ),
                ).then((_) async {
                  // await _firstLoad();
                  // await _firstLoadSend();
                });
              },
            ),
          ],
        ),
        // ignore: deprecated_member_use
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (due != null)
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
                                    Container(
                                      height: 0.05,
                                      color:
                                          const Color.fromARGB(255, 23, 23, 23),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Due Date : ",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          "05-03-2024",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
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
                                          "March",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
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
                                    // ),
                                    // Container(
                                    //   height: 0.05,
                                    //   color: const Color.fromARGB(255, 23, 23, 23),
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
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         Rozerpay_Screeen(),
                                    //   ),
                                    // ).then((_) async {
                                    //   // await _firstLoad();
                                    //   // await _firstLoadSend();
                                    // });
                                    // StartpgTransiction();

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => PhonePe(),
                                    //   ),
                                    // ).then((_) async {
                                    //   // await _firstLoad();
                                    //   // await _firstLoadSend();
                                    // });

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         PhonePe_ScreenPageScreen(),
                                    //   ),
                                    // ).then((_) async {
                                    //   // await _firstLoad();
                                    //   // await _firstLoadSend();
                                    // });
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
                Container(
                  height: 550,
                  child: ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => PaymentHistoryPage()),
                          // ).then((_) async {
                          //   // await _firstLoad();
                          //   // await _firstLoadSend();
                          // });
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: ImageIcon(
                                            AssetImage(
                                                "assets/images/sends.png"),
                                            color:
                                                Color.fromARGB(255, 94, 2, 255),
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "01 Jan 2024",
                                        style: TextStyle(fontSize: 12),
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
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                          "Sahil",
                                          style: TextStyle(fontSize: 16),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "₹ 500",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "phone pe",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          ImageIcon(
                                            AssetImage(
                                                "assets/images/Phonepe.png"),
                                            color:
                                                Color.fromARGB(255, 94, 2, 255),
                                            size: 15,
                                          ),
                                        ],
                                      ),
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
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "PhonePe_Screen Screen",
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
