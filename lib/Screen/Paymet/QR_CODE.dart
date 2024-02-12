// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, sized_box_for_whitespace, avoid_unnecessary_containers, unused_import, unused_local_variable, unnecessary_new, prefer_collection_literals, non_constant_identifier_names, use_build_context_synchronously
import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_advanced_networkimage_2/zoomable.dart';
import 'package:http/http.dart' as http;
import 'package:MaaAlankar/class/Colorconstant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QR_CODEScreen extends StatefulWidget {
  String dueMonth;
  String amount;
  @override
  QR_CODEScreen(this.dueMonth, this.amount);

  @override
  State<QR_CODEScreen> createState() => _QR_CODEScreenState();
}

class _QR_CODEScreenState extends State<QR_CODEScreen> {
  // final FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  // TextEditingController TransictionId = TextEditingController();
  // TextEditingController Purpose = TextEditingController();
  // TextEditingController Putpose = TextEditingController();
  // TextEditingController Address = TextEditingController();
  // TextEditingController duration = TextEditingController();

  final ImagePicker picker = ImagePicker();
  XFile? image;
  Uint8List? imagebytearray;

  Future getImage(
    ImageSource media,
  ) async {
    var img = await picker.pickImage(source: media, imageQuality: 30);
    var byte = await img!.readAsBytes();

    setState(() {
      // image = img;
      image = img;
      imagebytearray = byte;
      // hasData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QR Payment',
          style: GoogleFonts.salsa(color: ColorConstant.whiteA700),
        ),
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        backgroundColor: ColorConstant.golden,
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  _qrImage(context);
                },
                child: Container(
                  height: 550,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Image.asset(
                      'assets/images/qrcode.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // border: Border.all(width: 0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),

                            // TextFormField(
                            //   controller: TransictionId,
                            //   decoration: InputDecoration(
                            //     labelText: 'Enter Transiction Id',
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.all(
                            //         Radius.circular(10.0),
                            //       ),
                            //     ),
                            //   ),
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'Transiction Id cannot be empty';
                            //     }
                            //     return null;
                            //   },
                            // ),
                            // SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Atteched Payment Screenshort"),
                                      ),
                                      image != null
                                          ? InkWell(
                                              onTap: () {
                                                _showZoomableImage(context);
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder: (context) =>
                                                //         FullScreenImageView(
                                                //             imageByteArray:
                                                //                 imagebytearray),
                                                //   ),
                                                // );
                                              },
                                              child: Image.memory(
                                                imagebytearray!,
                                                width: 200,
                                                height: 200,
                                              ),
                                            )
                                          : Text('No image selected'),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              getImage(ImageSource.gallery);
                                              // pickImage(ImageSource.gallery);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  ColorConstant.lightBlue701,
                                              elevation: 3,
                                            ),
                                            child: Text(
                                              'Gallery',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          // ElevatedButton(
                                          //   onPressed: () {
                                          //     getImage(ImageSource.camera);
                                          //     // pickImage(ImageSource.camera);
                                          //   },
                                          //   style: ElevatedButton.styleFrom(
                                          //     backgroundColor:
                                          //         ColorConstant.lightBlue701,
                                          //     elevation: 3,
                                          //   ),
                                          //   child: Text(
                                          //     'Camara',
                                          //     style: TextStyle(
                                          //         color: Colors.white),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  )),
            )
            // AssetImage(Image())
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(color: ColorConstant.golden),
          width: double.infinity,
          // height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // if (_formKey.currentState!.validate()) {
                  // sentPayment(TransictionId.text);
                  if (image == null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Image Is Required',
                            style: TextStyle(color: Colors.red),
                          ),
                          content: Text('Please Atteched Image'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    await sentPayment("online", widget.dueMonth, widget.amount);
                  }

                  // } else {}
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.lightBlue701,
                  elevation: 3,
                ),
                child: Text(
                  'Submit Payment',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future sentPayment(pay_mode, month, amount) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? memberid = preferences.getString('memberid');
      String? token = preferences.getString('token');
      String TransictionId = DateTime.now().millisecondsSinceEpoch.toString();
      DateTime currect_Date = DateTime.now();
      // Read the image bytes
      Uint8List imageBytes = await image!.readAsBytes();
      // Convert bytes to base64
      String base64Image = base64Encode(imageBytes);
      var Insertobj = new Map<String, dynamic>();
      // Insertobj["memberone"] = transictionid;
      Insertobj["member_id"] = memberid.toString();
      Insertobj["pay_mode"] = pay_mode;
      Insertobj["month"] = month;
      Insertobj["amount"] = amount;
      Insertobj["status"] = "pending";
      Insertobj["razorpay_payment_id"] = TransictionId.toString();
      Insertobj["currency"] = "IND";
      Insertobj["date"] = currect_Date.toString();
      Insertobj["image"] = base64Image;

      final Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final request = http.Request("POST",
          Uri.parse('https://maaalankarjewellers.com/erp/api/qrpayment_post'));

      request.headers.addAll(headers);
      request.body = json.encode(Insertobj);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        dynamic json = jsonDecode(await response.stream.bytesToString());
        _showSnackbar(context);
        sentPaymentRemainder(month);
      } else {
        // addData();
      }
      throw new Exception();
    } catch (_, ex) {
      return false;
    }
  }

  List DueMonth = [
    "1st",
    "2nd",
    "3rd",
    "4th",
    "5th",
    "6th",
    "7th",
    "8th",
    "9th",
    "10th",
    "11th",
    "12th",
    "13th",
    "14th",
    "15th",
    "16th",
    "17th",
    "18th",
    "19th",
    "20th",
    "21st",
    "22nd",
    "23rd",
    "24th",
    "25th",
  ];
  String nextDueMonth = "";
  Future sentPaymentRemainder(paid_month) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? memberid = preferences.getString('memberid');
      String? token = preferences.getString('token');
      // Read the image bytes
      Uint8List imageBytes = await image!.readAsBytes();
      // Convert bytes to base64
      String base64Image = base64Encode(imageBytes);

      int index = DueMonth.indexWhere((item) => item == paid_month);

      if (index != -1 && index + 1 < DueMonth.length) {
        setState(() {
          nextDueMonth = DueMonth[index + 1].toString();
          print('Next due month is: $nextDueMonth');
        });
      } else {
        print('Paid month not found or last element.');
      }

      var Insertobj = new Map<String, dynamic>();
      // Insertobj["memberone"] = transictionid;
      Insertobj["memberid"] = memberid.toString();
      Insertobj["amount"] = "2000";
      Insertobj["due_month"] = nextDueMonth.toString();
      Insertobj["paid_month"] = paid_month.toString();
      Insertobj["booking_slot"] = "1";
      Insertobj["status"] = "secuss";

      final Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final request = http.Request(
          "POST",
          Uri.parse(
              'https://maaalankarjewellers.com/erp/api/paymetRemainder_post'));

      request.headers.addAll(headers);
      request.body = json.encode(Insertobj);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        dynamic json = jsonDecode(await response.stream.bytesToString());
        _showSnackbar(context);
        Navigator.pop(context);
      } else {
        // addData();
      }
      throw new Exception();
    } catch (_, ex) {
      return false;
    }
  }

  void _showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Secussfully Send Payment'),
        duration: Duration(seconds: 3), // Adjust the duration as needed
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            // Add action when the "UNDO" button is pressed
          },
        ),
      ),
    );
  }

  void _qrImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 400.0,
            width: 400, // Set the height as needed
            child: ZoomableWidget(
              maxScale: 5.0,
              minScale: 0.5,
              multiFingersPan: false,
              autoCenter: true,
              child: Image.asset(
                'assets/images/qrcode.jpg',
                fit: BoxFit.cover,
              ),
              // Image(image: NetworkImage(widget.Memeberdetails.photo)),
            ),
          ),
        );
      },
    );
  }

  void _showZoomableImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 700.0,
            width: 400, // Set the height as needed
            child: ZoomableWidget(
              maxScale: 5.0,
              minScale: 0.5,
              multiFingersPan: false,
              autoCenter: true,
              child: Image.memory(
                imagebytearray!,
                height: 700,
                width: 400,
                fit: BoxFit.cover,
              ),
              // Image(image: NetworkImage(widget.Memeberdetails.photo)),
            ),
          ),
        );
      },
    );
  }
}
