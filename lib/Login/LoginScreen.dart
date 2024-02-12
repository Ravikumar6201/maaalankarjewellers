// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_keyColor_in_widget_constructors, prefer_final_fields, unused_field, prefer_const_literals_to_create_immutables, unused_element, file_names, use_build_context_synchronously, avoid_print, non_constant_identifier_names, unnecessary_new, unused_catch_stack, unused_local_variable, sort_child_properties_last, depend_on_referenced_packages, use_key_in_widget_constructors
import 'package:MaaAlankar/Login/Fun_Login/login.dart';
import 'package:MaaAlankar/Login/OtpScreen.dart';
import 'package:MaaAlankar/Models/Login.dart';
import 'package:MaaAlankar/class/Colorconstant.dart';
import 'package:MaaAlankar/class/math_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  // final Color golden = Color(0xFFfeb564);
  // final Color golden = Color.fromARGB(255, 255, 136, 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
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
                ),
                Positioned(
                  bottom: 0,
                  left: 0.1,
                  right: 0.1,
                  child: LoginFormWidget(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginFormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginFormWidgetState();
  }
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  var PhoneController = TextEditingController();
  var sizedbox = SizedBox(
      // height: 60,
      );
  bool valuefirst = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(0, 255, 255, 255),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            sizedbox,
            _buildPhoneField(context),
            _buildLogInButton(context),
            sizedbox,
          ],
        ),
      ),
    );
  }

  _passwordValidation(String value) {
    if (value.isEmpty) {
      return "Please enter password";
    } else {
      return null;
    }
  }

  Widget _buildPhoneField(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
        child:
            // TextField(
            //   controller: PhoneController,
            //   decoration: InputDecoration(
            //       labelText: 'Number',
            //       hintText: '10 Digit Mobile Number',
            //       fillColor: const Color.fromARGB(255, 255, 255, 255),
            //       prefixIcon: Icon(Icons.call),
            //       // suffixIcon: IconButton(
            //       //   icon: Icon(
            //       //     _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            //       //   ),
            //       //   onPressed: () {
            //       //     setState(() {
            //       //       _isPasswordVisible = !_isPasswordVisible;
            //       //     });
            //       //   },
            //       // ),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(
            //             color: const Color.fromARGB(255, 255, 255,
            //                 255)), // Border color when the field is enabled
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(
            //             color: const Color.fromARGB(255, 255, 255,
            //                 255)), // Border color when the field is focused
            //       ),
            //       labelStyle:
            //           TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
            //       hintStyle:
            //           TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
            //       prefixIconColor: Colors.white),
            //   // obscureText: _isPasswordVisible,
            //   keyboardType: TextInputType.text,
            //   onChanged: (text) {
            //     print('Text changed: $text');
            //   },
            //   onSubmitted: (text) {
            //     print('Submitted: $text');
            //   },
            //   maxLength: 10,
            //   maxLines: 1,
            //   autocorrect: true,
            //   textInputAction: TextInputAction.done,
            //   style: TextStyle(fontSize: 16.0),
            // ),
            //   Padding(
            // padding: const EdgeInsets.all(2.0),
            // child:
            // Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       InternationalPhoneNumberInput(
            //         onInputChanged: (PhoneNumber number) {
            //           // Handle input changes
            //         },
            //         inputDecoration: InputDecoration(
            //           labelText: 'Mobile Number',
            //           hintText: 'Enter your mobile number',
            //           prefix: Container(
            //             width: 20,
            //             child: Row(
            //               children: [
            //                 Text('+'),
            //                 SizedBox(width: 1),
            //                 Text('1', style: TextStyle(fontWeight: FontWeight.bold)),
            //               ],
            //             ),
            //           ),
            //           focusedBorder: OutlineInputBorder(
            //             borderSide:
            //                 BorderSide(color: Colors.white), // Set the color to white
            //           ),
            //           enabledBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Colors.white),
            //           ),
            //           errorBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Colors.white),
            //           ),
            //           focusedErrorBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Colors.white),
            //           ),
            //           errorStyle: TextStyle(color: Colors.white),
            //           labelStyle: TextStyle(color: Colors.white),
            //           hintStyle: TextStyle(color: Colors.white),
            //         ),
            //         onInputValidated: (bool value) {
            //           // Handle validation
            //         },
            //         autoValidateMode: AutovalidateMode.onUserInteraction,
            //         inputBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.white),
            //         ),
            //         ignoreBlank: true,
            //         selectorTextStyle: TextStyle(color: Colors.white),
            //         textStyle: TextStyle(color: Colors.white), // Text color
            //       ),
            //     ],
            //   ),
            // ),

            Container(
          decoration: BoxDecoration(color: ColorConstant.golden),
          child: IntlPhoneField(
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: const Color.fromARGB(255, 255, 255,
                        255)), // Border color when the field is enabled
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: const Color.fromARGB(255, 255, 255, 255)),
                // Border color when the field is focused
              ),
              labelStyle:
                  TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
              hintStyle:
                  TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
              prefixIconColor: Colors.white,
              suffixIconColor: Colors.white,
              counterStyle:
                  TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
              fillColor: Colors.white,
              iconColor: Colors.white,
              focusColor: Colors.white,
              hoverColor: Colors.white,
            ),
            controller: PhoneController,
            initialCountryCode: 'IN',
            onChanged: (phone) {
              print(phone.completeNumber);
            },
          ),
        )

        //       TextFormField(
        //     controller: PhoneController,
        //     keyboardType:
        //         TextInputType.phone, // Use TextInputType.phone for a phone number
        //     textInputAction: TextInputAction.next,
        //     validator: (value) {
        //       if (value!.isEmpty) {
        //         return "Mobile number is required";
        //       } else if (value!.length != 10 || !value!.startsWith("9")) {
        //         return "Enter a valid 10-digit mobile number starting with '9'";
        //       }
        //       return null;
        //     },
        //     decoration: InputDecoration(
        //       border: OutlineInputBorder(),
        //       prefixIcon: Icon(Icons.phone_outlined),
        //       labelText: 'Mobile Number',
        //     ),
        //   ),
        );
  }

  String phoneValidation(String value) {
    // Replace this regular expression with the one that matches your phone number format.
    // This example assumes a simple format with digits and optional dashes or spaces.
    RegExp phoneRegExp = RegExp(r'^[0-9\- ]+$');

    if (!phoneRegExp.hasMatch(value)) {
      return "Enter a valid phone number";
    } else {
      return "";
    }
  }

  Widget _buildLogInButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
        child: ElevatedButton(
            child: Center(
                child: Text(
              "LogIn",
              style: TextStyle(color: Colors.black),
            )),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstant.golden,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              padding: EdgeInsets.all(20),
            ),
            onPressed: () async {
              _signUpProcess(context);
            }));
  }

  void _signUpProcess(BuildContext context) async {
    var validate = _formKey.currentState!.validate();
    try {
      print(PhoneController.text);
      MobileVarify? data = await Varify(PhoneController.text.toString()
          // passwordController.text.toString(),
          );
      if (data != null) {
        print(data.timestamp);
        print(data.sessionId);
        if ("success" == data.status) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          preferences.setString('mobileno', PhoneController.text);
          // preferences.setString('password', passwordController.text);
          preferences.setString('timestamp', data.timestamp.toString());
          preferences.setString('sessionId', data.sessionId.toString());
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => OTPValidationPage()),
            (Route<dynamic> route) => false,
          );
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(builder: (context) => HomeScreeen()),
          //   (Route<dynamic> route) => false,
          // );
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
                "Mobile Number Not Matched ",
                textScaleFactor: 1,
              ),
            ],
          )),
        );
      }
    } catch (_, ex) {}
  }

  // getpop(context, MobileVarify? data) {
  //   return showDialog(
  //     barrierColor: Colors.black54,
  //     barrierDismissible: false,
  //     useSafeArea: false,
  //     context: context,
  //     builder: (ctx) => Scaffold(
  //       backgroundColor: Colors.transparent,
  //       body: Center(
  //         child: Container(
  //           decoration: BoxDecoration(
  //               gradient: ColorConstant.appBarGradient,
  //               // color: ColorConstant.cyan301,
  //               borderRadius: BorderRadius.circular(10)),
  //           alignment: Alignment.center,
  //           width: 200,
  //           height: 200,
  //           child: Column(
  //             children: [
  //               // Welcome Text
  //               Container(
  //                 height: 150,
  //                 child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                     children: [
  //                       Text(
  //                         "OTP Send Sucussfully In Your MObile Number",
  //                         textScaleFactor: 1,
  //                         style: TextStyle(
  //                             color: Colors.white,
  //                             fontSize: 24,
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                       // Text(
  //                       //   data!.fName.toString(),
  //                       //   textScaleFactor: 1,
  //                       //   style: TextStyle(
  //                       //       color: ColorConstant.whiteA700,
  //                       //       fontSize: 18,
  //                       //       fontWeight: FontWeight.bold),
  //                       // ),
  //                       // Text(
  //                       //   data.userType.toString(),
  //                       //   textScaleFactor: 1,
  //                       //   style: TextStyle(
  //                       //       color: Colors.white,
  //                       //       fontSize: 12,
  //                       //       fontWeight: FontWeight.w400),
  //                       // ),
  //                     ]),
  //               ),

  //               ///Button
  //               Container(
  //                 width: 80,
  //                 child: ElevatedButton(
  //                     style: ButtonStyle(
  //                         shape:
  //                             MaterialStateProperty.all<RoundedRectangleBorder>(
  //                                 RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(18.0),
  //                                     side: BorderSide(color: Colors.blue)))),
  //                     child: Text("OK",
  //                         textScaleFactor: 1,
  //                         style: TextStyle(color: Colors.white, fontSize: 16)),
  //                     onPressed: () async {
  //                       Navigator.pushAndRemoveUntil(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) => OTPValidationPage()),
  //                         (Route<dynamic> route) => false,
  //                       );
  //                       // Navigator.pushAndRemoveUntil(
  //                       //   context,
  //                       //   MaterialPageRoute(builder: (context) => Dashboard()),
  //                       //   (Route<dynamic> route) => false,
  //                       // );
  //                     }),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
