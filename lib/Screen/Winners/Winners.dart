// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use, avoid_unnecessary_containers, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:MaaAlankar/Models/Winner.dart';
import 'package:MaaAlankar/Screen/Winners/Winner_Details.dart';
import 'package:MaaAlankar/Screen/Winners/notifications.dart';
import 'package:MaaAlankar/class/Colorconstant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WinnersScreen extends StatefulWidget {
  const WinnersScreen({super.key});

  @override
  State<WinnersScreen> createState() => _WinnersScreenState();
}

class _WinnersScreenState extends State<WinnersScreen> {
  @override
  void initState() {
    super.initState();
    getWinnerList();
  }

  List<Winner> _winnerList = [];
  int test = 1;
  @override
  Widget build(BuildContext context) {
    if (_winnerList.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Winners",
            style: GoogleFonts.salsa(color: ColorConstant.whiteA700),
          ),
          backgroundColor: ColorConstant.golden,
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
                    builder: (context) => NotificationsScreen(),
                  ),
                ).then((_) async {
                  await getWinnerList();
                  // await _firstLoadSend();
                });
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: _winnerList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WinnerDetailsScreen(_winnerList[index]),
                  ),
                ).then((_) async {
                  await getWinnerList();
                  // await _firstLoadSend();
                });
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container(
                        //   height: 0.05,
                        //   color: const Color.fromARGB(255, 23, 23, 23),
                        // ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: 80,
                                  color: ColorConstant.amber501,
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/profilepic.png', // Replace with the path to your image in the assets folder
                                      fit: BoxFit
                                          .contain, // Choose the BoxFit that suits your needs
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "2nd Winner 🎉",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Row(
                                      children: [
                                        // Text("Winner Name : "),
                                        Text(_winnerList[index]
                                            .winnerName
                                            .toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        // Text("Date : "),
                                        Text(_winnerList[index]
                                            .winnermnth
                                            .toString()),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 1 * 0,
                                  child: Text(
                                    "→",
                                    style: TextStyle(
                                        fontSize: 35,
                                        color: ColorConstant.bluegray400),
                                  ))
                            ],
                          ),
                        ),
                        // Text("data"),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              ),
            );
          },
        ),
      );
    } else if (_winnerList.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Winner",
            style: GoogleFonts.salsa(color: ColorConstant.whiteA700),
          ),
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
                    builder: (context) => NotificationsScreen(),
                  ),
                ).then((_) async {
                  // await _firstLoad();
                  // await _firstLoadSend();
                });
              },
            ),
          ],
          backgroundColor: ColorConstant.golden,
        ),
        body: Center(
            child: Text(
          "No Record",
          style: TextStyle(fontSize: 20),
        )),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Winner",
            style: GoogleFonts.salsa(color: ColorConstant.whiteA700),
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
            backgroundColor: ColorConstant.golden,
            title: Text(
              'Exit App',
              style: TextStyle(color: ColorConstant.whiteA700),
            ),
            // content: Text('Do you want to exit the app?'),
            content: Container(
              width: 300.0, // Set the width of the content
              height: 40.0, // Set the height of the content
              decoration: BoxDecoration(),
              child: Text(
                'Do you want to exit the app?',
                style: TextStyle(color: ColorConstant.whiteA700),
              ),
            ),
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

  Future getWinnerList() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      final Uri uri =
          Uri.parse('https://maaalankarjewellers.com/erp/api/winnerlistapi');

      final Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData is Map) {
          // Check if 'updateprice' is a List
          if (jsonData['winner'] is List) {
            final List<dynamic> userList = jsonData['winner'];

            // Assuming Updateprice.fromJson is a constructor that takes a Map<String, dynamic>
            List<Winner> userObjects =
                userList.map((user) => Winner.fromJson(user)).toList();

            setState(() {
              _winnerList = userObjects;
            });
          } else {
            // Handle the case where 'updateprice' is not a List
            print('Updateprice is not a List in JSON.');
          }
        } else {
          print('Data key not found in JSON.');
        }
      }
    } catch (err) {
      print('An error occurred: $err');
    }
  }
}
