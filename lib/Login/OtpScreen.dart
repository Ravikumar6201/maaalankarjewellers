// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_catch_stack, unused_field, avoid_unnecessary_containers, avoid_print
import 'package:MaaAlankar/Login/Fun_Login/login.dart';
import 'package:MaaAlankar/Models/Login.dart';
import 'package:MaaAlankar/Screen/Dashboard/HomeScreen.dart';
import 'package:MaaAlankar/class/Colorconstant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPValidationPage extends StatefulWidget {
  @override
  _OTPValidationPageState createState() => _OTPValidationPageState();
}

class _OTPValidationPageState extends State<OTPValidationPage> {
  String enteredOTP = '';
  final _formKey = GlobalKey<FormState>();
  var OTPController = TextEditingController();

  // void validateOTPAndShowDialog() {
  //   bool isValid = validateOTP(enteredOTP);
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         // title: Text('OTP Validation'),
  //         content: Text(isValid ? 'OTP is valid' : 'OTP is invalid'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  bool validateOTP(String enteredOTP) {
    // Replace '123456' with the expected OTP value.
    return enteredOTP == '1234';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('OTP Validation'),
      // ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                      padding: EdgeInsets.only(top: 100.0),
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage("assets/images/otplog.jpg"),
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                          ),
                          // Text(
                          //   "Business Clusture Of India",
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(
                          //       color: ColorConstant.green900,
                          //       fontSize: 20,
                          //       fontWeight: FontWeight.w500),
                          // )
                        ],
                      ))),
              SizedBox(height: 20),
              Text(
                'Enter OTP:',
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: PinCodeTextField(
                  appContext: context,
                  controller: OTPController,
                  length: 6,
                  cursorColor: ColorConstant.ForntColor,
                  onChanged: (value) {
                    // Handle OTP input changes
                    print(value);
                  },
                  onCompleted: (value) {
                    // Handle OTP input completion
                    print("Completed: $value");
                  },
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: ColorConstant.golden,
                    inactiveFillColor: ColorConstant.golden,
                    selectedFillColor: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _signUpProcess(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.golden,
                  // elevation: 3,
                ),
                child: Text(
                  'Verify OTP',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUpProcess(BuildContext context) async {
    // var validate = _formKey.currentState!.validate();
    try {
      print(OTPController.text);
      LoginResponse? data =
          await fetchLoginDetails(OTPController.text.toString()
              // passwordController.text.toString(),
              );
      if (data != null) {
        print(data.token);
        if ("success" == data.status) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString('email', OTPController.text);
          // preferences.setString('password', passwordController.text);
          preferences.setString('token', data.token);
          preferences.setInt('userid', data.userId);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreeen()),
            (Route<dynamic> route) => false,
          );
          // getpop(context, data);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Wrong Cradentials ",
                  textScaleFactor: 1,
                ),
              ],
            )),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "OTP Not Matched ",
                textScaleFactor: 1,
              ),
            ],
          )),
        );
      }
    } catch (_, ex) {}
  }
}
