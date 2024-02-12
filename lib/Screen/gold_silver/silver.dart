// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:MaaAlankar/Models/Dashboard.dart';
import 'package:MaaAlankar/class/Colorconstant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SilverScreen extends StatefulWidget {
  Updateprice silverlist;
  SilverScreen(this.silverlist);

  @override
  State<SilverScreen> createState() => _SilverScreenState();
}

class _SilverScreenState extends State<SilverScreen> {
  String price = "";
  String date = "";
  @override
  void initState() {
    super.initState();
    widget.silverlist;
    price = widget.silverlist.silverprice.toString();
    date = widget.silverlist.date.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todat Silver Price',
          style: GoogleFonts.salsa(color: ColorConstant.whiteA700),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_sharp)),
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstant.puregolden,
      ),
      body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Unlocking Today's Silver Prices with Maa Alankar Jewellers",
                      style: GoogleFonts.heebo(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: ColorConstant.black900B2,
                    ),
                    Text(
                        "Welcome to Maa Alankar Jewellers, your trusted destination for exquisite jewelry. In today's blog, we delve into the ever-changing landscape of Silver prices to help you make informed decisions and stay updated on the latest trends. Let's navigate through the currents of the Silver market and discover the value of your precious metal today.")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Understanding Silver Prices:",
                      style: GoogleFonts.heebo(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: ColorConstant.black900B2,
                    ),
                    Text(
                        "Silver prices are influenced by various factors, including global economic conditions, geopolitical events, and currency fluctuations. At Maa Alankar Jewellers, we understand the significance of staying current with these trends to provide you with the best possible value for your investments.")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Unlocking Today's Silver Prices with Maa Alankar Jewellers",
                      style: GoogleFonts.heebo(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: ColorConstant.black900B2,
                    ),
                    Text(
                        "Welcome to Maa Alankar Jewellers, your trusted destination for exquisite jewelry. In today's blog, we delve into the ever-changing landscape of Silver prices to help you make informed decisions and stay updated on the latest trends. Let's navigate through the currents of the Silver market and discover the value of your precious metal today."),
                    Text(
                        "As of $date, the Silver market reflects $price. At Maa Alankar Jewellers, we believe in transparency, and our commitment to fair pricing ensures that you get the most accurate reflection of the market value when you engage with us.")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Today's Silver Prices:",
                      style: GoogleFonts.heebo(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: ColorConstant.black900B2,
                    ),
                    Text(
                        "Without further ado, let's explore the current Silver prices at Maa Alankar Jewellers. As of $date, the price per gram for  stands at $price. This information serves as a valuable reference for those considering purchasing jewelry or investing in Silver."),
                    Text(
                        "It's essential to note that Silver prices can fluctuate throughout the day based on market conditions. To get the most accurate and up-to-date information, we recommend contacting our dedicated team at Maa Alankar Jewellers or visiting our store for real-time pricing.")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Why Choose Maa Alankar Jewellers:",
                      style: GoogleFonts.heebo(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: ColorConstant.black900B2,
                    ),
                    Text(
                        "Beyond the numbers, what sets Maa Alankar Jewellers apart is our unwavering commitment to quality craftsmanship, unique designs, and exceptional customer service. Our skilled artisans work tirelessly to create pieces that reflect both tradition and innovation, making your purchase at Maa Alankar Jewellers a truly memorable experience."),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Conclusion:",
                      style: GoogleFonts.heebo(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: ColorConstant.black900B2,
                    ),
                    Text(
                        "In conclusion, navigating the world of Silver prices requires staying informed and choosing a trusted partner. Maa Alankar Jewellers is your beacon in this journey, offering not only competitive prices but also an unparalleled commitment to excellence. Connect with us today to explore our collection and make the most of today's Silver prices."),
                  ],
                ),
              ),
            ],
          )),
    );
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
