// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:MaaAlankar/class/Colorconstant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paytm/paytm.dart';

class InstalmentPageScreen extends StatefulWidget {
  @override
  _InstalmentPageScreenState createState() => _InstalmentPageScreenState();
}

class _InstalmentPageScreenState extends State<InstalmentPageScreen> {
  String payment_response = "200";

  //Live
  String mid = "SPlocB67800495489509";
  String PAYTM_MERCHANT_KEY = "SPlocB67800495489509";
  String website = "DEFAULT";
  bool testing = false;

  //Testing
  // String mid = "TEST_MID_HERE";
  // String PAYTM_MERCHANT_KEY = "TEST_KEY_HERE";
  // String website = "WEBSTAGING";
  // bool testing = true;

  double amount = 1;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paytm example app'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  'For Testing Credentials make sure appInvokeEnabled set to FALSE or Paytm APP is not installed on the device.'),

              SizedBox(
                height: 10,
              ),

              TextField(
                onChanged: (value) {
                  mid = value;
                },
                decoration: InputDecoration(hintText: "Enter MID here"),
                keyboardType: TextInputType.text,
              ),
              TextField(
                onChanged: (value) {
                  PAYTM_MERCHANT_KEY = value;
                },
                decoration:
                    InputDecoration(hintText: "Enter Merchant Key here"),
                keyboardType: TextInputType.text,
              ),
              TextField(
                onChanged: (value) {
                  website = value;
                },
                decoration: InputDecoration(
                    hintText: "Enter Website here (Probably DEFAULT)"),
                keyboardType: TextInputType.text,
              ),
              TextField(
                onChanged: (value) {
                  try {
                    amount = double.tryParse(value)!;
                  } catch (e) {
                    print(e);
                  }
                },
                decoration: InputDecoration(hintText: "Enter Amount here"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              payment_response != null
                  ? Text('Response: $payment_response\n')
                  : Container(),
              //                loading
              //                    ? Center(
              //                        child: Container(
              //                            width: 50,
              //                            height: 50,
              //                            child: CircularProgressIndicator()),
              //                      )
              //                    : Container(),
              ElevatedButton(
                onPressed: () {
                  //Firstly Generate CheckSum bcoz Paytm Require this
                  generateTxnToken(0);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.golden,
                  // elevation: 3,
                ),
                // color: Colors.blue,
                child: Text(
                  "Pay using Wallet",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  //Firstly Generate CheckSum bcoz Paytm Require this
                  generateTxnToken(1);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.golden,
                  // elevation: 3,
                ),
                // color: Colors.blue,
                child: Text(
                  "Pay using Net Banking",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  //Firstly Generate CheckSum bcoz Paytm Require this
                  generateTxnToken(2);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.golden,
                  // elevation: 3,
                ),
                // color: Colors.blue,
                child: Text(
                  "Pay using UPI",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  //Firstly Generate CheckSum bcoz Paytm Require this
                  generateTxnToken(3);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.golden,
                  // elevation: 3,
                ),
                // color: Colors.blue,
                child: Text(
                  "Pay using Credit Card",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void generateTxnToken(int mode) async {
    setState(() {
      loading = true;
    });
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String callBackUrl = (testing
            ? 'https://securegw-stage.paytm.in'
            : 'https://securegw.paytm.in') +
        '/theia/paytmCallback?ORDER_ID=' +
        orderId;

    //Host the Server Side Code on your Server and use your URL here. The following URL may or may not work. Because hosted on free server.
    //Server Side code url: https://github.com/mrdishant/Paytm-Plugin-Server

    var url = 'https://desolate-anchorage-29312.herokuapp.com/generateTxnToken';

    var body = json.encode({
      "mid": mid,
      "key_secret": PAYTM_MERCHANT_KEY,
      "website": website,
      "orderId": orderId,
      "amount": amount.toString(),
      "callbackUrl": callBackUrl,
      "custId": "122",
      "mode": mode.toString(),
      "testing": testing ? 0 : 1
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {'Content-type': "application/json"},
      );

      print("Response is");
      print(response.body);
      String txnToken = response.body;
      setState(() {
        payment_response = txnToken;
      });

      var paytmResponse = Paytm.payWithPaytm(
          mId: mid,
          orderId: orderId,
          txnToken: txnToken,
          txnAmount: amount.toString(),
          callBackUrl: callBackUrl,
          staging: testing,
          appInvokeEnabled: false);

      paytmResponse.then((value) {
        print(value);
        setState(() {
          loading = false;
          print("Value is ");
          print(value);
          if (value['error']) {
            payment_response = value['errorMessage'];
          } else {
            if (value['response'] != null) {
              payment_response = value['response']['STATUS'];
            }
          }
          payment_response += "\n" + value.toString();
        });
      });
    } catch (e) {
      print(e);
    }
  }
}
























// // ignore_for_file: avoid_print

// import 'package:MaaAlankar/Screen/Instalment/Pay_Secuss.dart';
// import 'package:flutter/material.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:upi_india/upi_india.dart';

// class InstalmentPageScreen extends StatefulWidget {
//   @override
//   _InstalmentPageScreenState createState() => _InstalmentPageScreenState();
// }

// class _InstalmentPageScreenState extends State<InstalmentPageScreen> {
//   final UpiIndia _upiIndia = UpiIndia();
//   final LocalAuthentication _localAuthentication = LocalAuthentication();

//   Future<void> _authenticate() async {
//     try {
//       bool isAuthenticated = await _localAuthentication.authenticate(
//         localizedReason: 'Authenticate to complete payment',
//         // biometricOnly: true, // Use biometric (face/fingerprint) only
//       );

//       if (!isAuthenticated) {
//         // Authentication failed
//         return;
//       }
//     } catch (e) {
//       // Handle authentication errors
//       print('Error during authentication: $e');
//     }
//   }

//   Future<void> _makePayment() async {
//     // try {
//     // List<UpiIndiaApp> apps;
//     // apps = await _upiIndia.getAllUpiApps();

//     // UpiIndiaResponse response = await _upiIndia.startTransaction(
//     //   app: apps[0],
//     //   receiverName: 'Payee Name',
//     //   receiverUpiId: 'payee@upi', // Replace with the actual UPI ID
//     //   transactionRefId: '123456',
//     //   transactionNote: 'Payment for goods/services',
//     //   amount: 100.0,
//     // );

//     // if (response.status == UpiIndiaResponseStatus.success) {
//     // Payment successful
//     //       print('Payment successful');
//     //     } else {
//     //       // Payment failed
//     //       print('Payment failed');
//     //     }
//     //   } catch (e) {
//     //     // Handle payment errors
//     //     print('Error during payment: $e');
//     //   }
//   }
//   bool isToggled = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('UPI Payment Page'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             // Column(
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //   children: [
//             //     ElevatedButton(
//             //       onPressed: () async {
//             //         await _authenticate();
//             //         await _makePayment();
//             //       },
//             //       child: Text('Make UPI Payment (Secure)'),
//             //     ),
//             //   ],
//             // ),
//             Container(
//               padding: EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(
//                     'Amount',
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8.0),
//                   Text(
//                     '₹2000.00', // Replace with the actual amount
//                     style: TextStyle(
//                       fontSize: 24.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => PaymentSuccessPage(),
//                   ),
//                 ).then((_) async {
//                   Navigator.pop(context);
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: (context) => Dashboard(),
//                   //   ),
//                   // );
//                 });
//                 // Add your payment logic here
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.all(16.0),
//                 primary: Colors.blue,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//               child: Text(
//                 'Proceed to Pay',
//                 style: TextStyle(
//                   fontSize: 18.0,
//                 ),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               'Payment Methods',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8.0),
//             // Container(
//             //   decoration: BoxDecoration(
//             //     color: Colors.white,
//             //     borderRadius: BorderRadius.circular(8.0),
//             //     boxShadow: [
//             //       BoxShadow(
//             //         color: Colors.grey.withOpacity(0.5),
//             //         spreadRadius: 2,
//             //         blurRadius: 5,
//             //         offset: Offset(0, 3),
//             //       ),
//             //     ],
//             //   ),
//             //   child: ListTile(
//             //     leading: Icon(Icons.credit_card),
//             //     title: Text('Credit/Debit Card'),
//             //     onTap: () {
//             //       // Add your card payment logic here
//             //     },
//             //   ),
//             // ),
//             SizedBox(height: 8.0),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ListTile(
//                     leading: Icon(Icons.phone_android),
//                     title: Text('UPI'),
//                     onTap: () {
//                       // Add your UPI payment logic here
//                     },
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         isToggled = !isToggled;
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: CircleBorder(),
//                       padding: EdgeInsets.all(24.0),
//                       primary: isToggled ? Colors.green : Colors.grey,
//                     ),
//                     child: Icon(
//                       Icons.circle,
//                       size: 48.0,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
