// ignore_for_file: unused_import, non_constant_identifier_names

import 'package:MaaAlankar/Models/Login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<MobileVarify?> Varify(String PhoneNo) async {
  try {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? token = preferences.getString('token');
    final Uri uri =
        Uri.https('www.maaalankarjewellers.com', '/erp/api/Admin_sendOTP');
    final Map<String, dynamic> requestBody = {
      'phoneno': PhoneNo,
      // Other request parameters can be added here
    };

    final Map<String, String> headers = {
      'Host': 'www.maaalankarjewellers.com',
      // Other headers can be added here
    };
    final response = await http.post(uri, body: requestBody, headers: headers);

    // final Map<String, String> headers = {
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer $token',
    //   'Content-Type': 'application/json',
    // };

    // final response = await http.post(
    //   uri,
    //   // headers: headers,
    // );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);

      if (json['status'] == "success") {
        final MobileVarify loginResult = MobileVarify.fromJson(json);
        return loginResult;
      } else {
        throw Exception("Login Failed");
      }
    } else {
      throw Exception("HTTP Error: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
    return null;
  }
}

Future<LoginResponse?> fetchLoginDetails(String OTP) async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? mobileno = preferences.getString('mobileno');
    String? Timestamp = preferences.getString('timestamp');
    String? sessionid = preferences.getString('sessionId');

    final Uri uri =
        Uri.https('www.maaalankarjewellers.com', '/erp/api/Admin_verifyOTP');
    final Map<String, dynamic> requestBody = {
      'phoneno': mobileno,
      'session_id': sessionid,
      'timestamp': Timestamp,
      'otp': OTP,
      // Other request parameters can be added here
    };

    final response = await http.post(
      uri,
      body: requestBody,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);

      if (json['status'] == "success") {
        final LoginResponse loginResult = LoginResponse.fromJson(json);
        return loginResult;
      } else {
        throw Exception("Login Failed");
      }
    } else {
      throw Exception("HTTP Error: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
    return null;
  }
}
