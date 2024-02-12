// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:MaaAlankar/class/Colorconstant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<String> notifications = [
    'Notification 1',
    'Notification 2',
    'Notification 3',
    // Add more notifications as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications',style: GoogleFonts.salsa(color: ColorConstant.whiteA700),),
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        backgroundColor: ColorConstant.puregolden,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(border: Border.all(width: 0.1)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(notifications[index]),
            ),
          );
        },
      ),
    );
  }
}
