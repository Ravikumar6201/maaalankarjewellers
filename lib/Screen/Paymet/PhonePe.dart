// // ignore_for_file: non_constant_identifier_names

// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:crypto/crypto.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

// class PhonePe extends StatefulWidget {
//   const PhonePe({super.key});

//   @override
//   State<PhonePe> createState() => _PhonePeState();
// }

// class _PhonePeState extends State<PhonePe> {
//   String environment = "SANDBOX";
//   String appId = "";
//   String TransictionId = DateTime.now().millisecondsSinceEpoch.toString();
//   String merchantId = "PGTESTPAYUAT";
//   bool enableLogging = true;
//   String checksum = "";
//   String soltKey = "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399";
//   String soltIndex = "1";
//   String callBackutl = "google.com";
//   String body = "";
//   Object? result;
//   String urlendpoint = "";
//   String apiEndPoint = "/pg/v1/pay";

//   void PhonepeInit() {
//     PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
//         .then((val) => {
//               setState(() {
//                 result = 'PhonePe SDK Initialized - $val';
//               })
//             })
//         .catchError((error) {
//       handleError(error);
//       return <dynamic>{};
//     });
//   }

//   // Stert pgtransiction

//   void StartpgTransiction() async {
//     PhonePePaymentSdk.startTransaction(body, callBackutl, checksum, apiEndPoint)
//         .then((response) async {
//       // setState(() {
//       if (response != null) {
//         String status = response['status'].toString();
//         String error = response['error'].toString();
//         if (status == 'SUCCESS') {
//           result = "Flow Status complete Secuss";
//           await CheckStatus();
//           print(status);

//           Text(status.toString());
//           // "Flow Completed - Status: Success!";
//         } else {
//           result = "Flow Status $status And error $error";
//         }
//       } else {
//         // "Flow Incomplete";
//       }
//       // });
//     }).catchError((error) {
//       // handleError(error)
//       return <dynamic>{};
//     });
//   }

//   getCheckSum() {
//     final requestData = {
//       "merchantId": merchantId,
//       "merchantTransactionId": TransictionId,
//       "merchantUserId": "90223250",
//       "amount": 1000,
//       "mobileNumber": "9999999999",
//       "callbackUrl": "https://webhook.site/callback-url",
//       "paymentInstrument": {"type": "PAY_PAGE"},
//       // "deviceContext": {"deviceOS": "ANDROID"}
//     };
//     String base64Body = base64.encode(utf8.encode(json.encode(requestData)));
//     checksum =
//         "${sha256.convert(utf8.encode(base64Body + apiEndPoint + soltKey)).toString()}###$soltIndex";
//     return base64Body;
//   }

//   Future CheckStatus() async {
//     try {
//       String url =
//           "https://api-preprod.phonepe.com/apis/pg-sandbox/pg/v1/status/$merchantId/$TransictionId";
//       String ConcatString =
//           "/pg/v1/status/$merchantId/$TransictionId$soltIndex";
//       var bytes = utf8.encode(ConcatString);
//       var degest = sha256.convert(bytes).toString();

//       String xVerify = "$degest###$soltIndex";
//       final Map<String, String> headers = {
//         'Accept': 'application/json',
//         'X-VERIFY': xVerify,
//         'X-MERCHANT-ID': merchantId,
//       };

//       await http
//           .get(
//         Uri.parse(url),
//         headers: headers,
//       )
//           .then((value) {
//         Map<String, dynamic> res = jsonDecode(value.body);
//         try {
//           if (res["success"] &&
//               res["code"] == "PAYMENT_SUCCESS" &&
//               res["data"]["state"] == "COMPLETED") {
//             Fluttertoast.showToast(msg: res["message"]);
//           } else {
//             Fluttertoast.showToast(msg: "Something Wrong");
//           }
//         } catch (e, _) {
//           Fluttertoast.showToast(msg: "$e");
//         }
//       });
//     } on Exception catch (e) {
//       Fluttertoast.showToast(msg: "$e");
//     }
//   }
//    void handleError(error) {
//     setState(() {
//       result = {"error": error};
//     });
//   }
//   /*Future CheckStatus() async {
//     try {
//       String url =
//           "https://mercury-t2.phonepe.com/v3/transaction/$merchantId/$TransictionId/status";
//       // "https://api-preprod.phonepe.com/apis/pg-sandbox/pg/v1/status/$merchantId/$TransictionId";
//       String ConcatString =
//           "/v3/transaction/$merchantId/$TransictionId/status$soltKey###$soltIndex";
//       // "/pg/v1/status/$merchantId/$TransictionId$soltIndex";
//       var bytes = utf8.encode(ConcatString);
//       var degest = sha256.convert(bytes).toString();

//       String xVerify = "$degest###$soltIndex";
//       final Map<String, String> headers = {
//         'Accept': 'application/json',
//         'X-VERIFY': xVerify,
//         'X-MERCHANT-ID': merchantId,
//       };

//       await http
//           .get(
//         Uri.parse(url),
//         headers: headers,
//       )
//           .then((value) {
//         Map<String, dynamic> res = jsonDecode(value.body);
//         try {
//           if (res["success"] &&
//               res["code"] == "PAYMENT_SUCCESS" &&
//               res["data"]["state"] == "COMPLETED") {
//             Fluttertoast.showToast(msg: res["message"]);
//           } else {
//             Fluttertoast.showToast(msg: "Something Wrong");
//           }
//         } catch (e, _) {
//           Fluttertoast.showToast(msg: "$e");
//         }
//       });
//     } on Exception catch (e) {
//       Fluttertoast.showToast(msg: "$e");
//     }
//   }*/

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     PhonepeInit();
//     body = getCheckSum().toString();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Phone Pe ")),
//       body: Center(
//         child: Column(
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   StartpgTransiction();
//                 },
//                 child: Text("Start Transiction")),
//             const SizedBox(
//               height: 20,
//             ),
//             Text("result = $result"),
//           ],
//         ),
//       ),
//     );
//   }

 
// }
