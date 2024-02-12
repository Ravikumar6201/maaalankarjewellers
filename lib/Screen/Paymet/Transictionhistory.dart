// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:MaaAlankar/Models/Payment.dart';
import 'package:MaaAlankar/class/Colorconstant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class PaymentHistoryPage extends StatefulWidget {
  Paymenthistory paymentHistory;
  @override
  PaymentHistoryPage(this.paymentHistory);
  @override
  _PaymentHistoryPageState createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  @override
  void initState() {
    super.initState();
    // fetchPaymentHistory();
  }

  // Future<void> fetchPaymentHistory() async {
  //   // Replace 'YOUR_API_KEY' and 'API_ENDPOINT' with actual values
  //   final apiKey = 'YOUR_API_KEY';
  //   final apiEndpoint = 'API_ENDPOINT';

  //   final response = await http.get(Uri.parse(apiEndpoint), headers: {
  //     'Authorization': 'Bearer $apiKey',
  //   });

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       paymentHistory = json.decode(response.body);
  //     });
  //   } else {
  //     // Handle error
  //     print('Failed to fetch payment history: ${response.statusCode}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Payment History'),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_sharp)),
          automaticallyImplyLeading: false,
          backgroundColor: ColorConstant.puregolden,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.paymentHistory.payMode != "online")
                Center(
                  child: CircleAvatar(
                    radius: 150,
                    backgroundImage: AssetImage("assets/images/cash.png"),
                  ),
                ),
              if (widget.paymentHistory.payMode == "online")
                Center(
                  child: CircleAvatar(
                    radius: 150,
                    backgroundImage: AssetImage("assets/images/online.png"),
                  ),
                ),
              SizedBox(height: 20),
              // if (widget.paymentHistory.payMode != "online")
              //   Text("Payment Mode : Cash"),
              // if (widget.paymentHistory.payMode == "online")
              Text(
                  "Payment Mode : " + widget.paymentHistory.payMode.toString()),
              SizedBox(
                height: 5,
              ),
              Text("Date " +
                  convertDateFormatAll(
                      widget.paymentHistory.createdAt.toString())),
              SizedBox(
                height: 5,
              ),
              Text("Time " +
                  convertToReadableDateTime(
                      widget.paymentHistory.createdAt.toString())),
              SizedBox(
                height: 5,
              ),
              Text("Amount " + widget.paymentHistory.amount.toString()),
              SizedBox(
                height: 5,
              ),
              Text(
                  "Month Of Payment " + widget.paymentHistory.month.toString()),
            ],
          ),
        ));
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
}
