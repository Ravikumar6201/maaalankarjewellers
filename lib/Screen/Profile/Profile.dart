// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, use_key_in_widget_constructors, prefer_final_fields, avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';

import 'package:MaaAlankar/Login/LoginScreen.dart';
import 'package:MaaAlankar/Models/Dashboard.dart';
import 'package:MaaAlankar/Screen/Profile/EditPRofile.dart';
import 'package:MaaAlankar/class/Colorconstant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  // Member _member;
  // ProfileScreen(this._member);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<User> _DisplayListUser = [];
  List<Member> _DisplayListMember = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    if (_DisplayListMember.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: GoogleFonts.salsa(color: ColorConstant.whiteA700),
          ),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_sharp)),
          automaticallyImplyLeading: false,
          actions: [
            Row(
              children: [
                Text(
                  "Log Out",
                  style: GoogleFonts.salsa(
                      fontSize: 16, color: ColorConstant.redA700),
                ),
                IconButton(
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    await preferences.clear();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: Icon(Icons.exit_to_app_sharp),
                  color: ColorConstant.redA700,
                ),
              ],
            )
          ],
          backgroundColor: ColorConstant.puregolden,
        ),
        body: new Container(
          child: new Stack(
            children: <Widget>[
              new Align(
                alignment: Alignment.center,
                child: new Padding(
                  padding: new EdgeInsets.only(top: _height / 15),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (_DisplayListMember.first.photo != null)
                        Column(
                          children: [
                            if (_DisplayListMember.first.photo == null)
                              CircularProgressIndicator(
                                // value: 0.7,
                                backgroundColor: Colors.grey[200],
                                color: Colors.blue,
                                strokeWidth: 5.0,
                                semanticsLabel: 'Loading...',
                              ),
                            if (_DisplayListMember.first.photo != null)
                              GestureDetector(
                                onTap: () {
                                  _showImageFullScreen(
                                      context,
                                      _DisplayListMember.first.photo
                                          .toString());
                                },
                                child: Hero(
                                  tag: 'profileImage',
                                  child: CircleAvatar(
                                    backgroundImage:
                                        _DisplayListMember.first.photo != null
                                            ? NetworkImage(_DisplayListMember
                                                .first.photo
                                                .toString())
                                            : null,
                                    radius:
                                        MediaQuery.of(context).size.height / 10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      if (_DisplayListMember.first.photo == null)
                        IconButton(
                          onPressed: () {},
                          color: Color.fromARGB(255, 0, 0, 0), // Icon color
                          iconSize: 48.0, // Icon size
                          splashRadius: 24.0, // Splash radius
                          padding:
                              EdgeInsets.all(16.0), // Padding around the icon
                          alignment: Alignment
                              .center, // Alignment of the icon within the button
                          tooltip: 'Add', // Tooltip text
                          splashColor:
                              Colors.green, // Splash color when pressed
                          highlightColor:
                              Colors.red, // Highlight color when pressed
                          icon: Icon(
                            Icons.person_2,
                            size: 200,
                            // color: ColorConstant.black900,
                          ),
                        ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProfileEditScreen(_DisplayListMember.first),
                            ),
                          ).then((_) async {
                            _firstLoad();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.cyan300,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          padding: EdgeInsets.only(left: 15, right: 15),
                        ),
                        label: Text(
                          "Edit",
                          style: GoogleFonts.salsa(
                            color: ColorConstant.whiteA700,
                          ),
                        ),
                        icon: Icon(
                          Icons.edit,
                          color: ColorConstant.whiteA700,
                        ),
                      ),
                      // new SizedBox(
                      //   height: _height / 30,
                      // ),
                      // new Text(
                      //   'Sadiq Mehdi',
                      //   style: new TextStyle(
                      //       fontSize: 18.0,
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.bold),
                      // )
                    ],
                  ),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(top: _height / 2.2),
                child: new Container(
                  color: Colors.white,
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(
                    top: _height / 3.0, left: _width / 20, right: _width / 20),
                child: new Column(
                  children: <Widget>[
                    // new Container(
                    //   decoration: new BoxDecoration(
                    //       color: Colors.white,
                    //       boxShadow: [
                    //         new BoxShadow(
                    //             color: Colors.black45,
                    //             blurRadius: 2.0,
                    //             offset: new Offset(0.0, 2.0))
                    //       ]),
                    // child: new Padding(
                    //   padding: new EdgeInsets.all(_width / 20),
                    //   child: new Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: <Widget>[
                    //         headerChild('Photos', 114),
                    //         headerChild('Followers', 1205),
                    //         headerChild('Following', 360),
                    //       ]),
                    // ),
                    // ),
                    new Padding(
                      padding: new EdgeInsets.only(top: _height / 20),
                      child: new Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                new Icon(Icons.person_2_outlined),
                                new SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: new Text(
                                    _DisplayListMember.first.proprietername
                                        .toString(),
                                    style: GoogleFonts.salsa(
                                        fontSize: 14.0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                new Icon(Icons.group_add),
                                new SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: new Text(
                                    _DisplayListMember.first.groupname
                                        .toString(),
                                    style: GoogleFonts.salsa(
                                        fontSize: 14.0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                new Icon(Icons.person_add),
                                new SizedBox(
                                  width: 8.0,
                                ),
                                Text("Booking Slot "),
                                Expanded(
                                  child: new Text(
                                    _DisplayListMember.first.slot.toString(),
                                    style: GoogleFonts.salsa(
                                        fontSize: 14.0,
                                        color: Color.fromARGB(255, 26, 6, 248),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                new Icon(Icons.shield_moon),
                                new SizedBox(
                                  width: 8.0,
                                ),
                                Text("Lucky Number "),
                                Expanded(
                                  child: new Text(
                                    _DisplayListMember.first.lucky ?? "0",
                                    style: GoogleFonts.salsa(
                                        fontSize: 14.0,
                                        color: Color.fromARGB(255, 26, 6, 248),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Row(
                          //     children: [
                          //       new Icon(Icons.location_city),
                          //       new SizedBox(
                          //         width: 8.0,
                          //       ),
                          //       Expanded(
                          //         child: new Text(
                          //           widget._member.address,
                          //           style: new TextStyle(
                          //               fontSize: 14.0,
                          //               color: Color.fromARGB(255, 0, 0, 0),
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                new Icon(Icons.email),
                                new SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: new Text(
                                    _DisplayListMember.first.proemail ??
                                        "update your Email",
                                    style: GoogleFonts.salsa(
                                        fontSize: 14.0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                new Icon(Icons.call),
                                new SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: new Text(
                                    _DisplayListMember.first.phone.toString(),
                                    style: GoogleFonts.salsa(
                                        fontSize: 14.0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        // floatingActionButton: Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     FloatingActionButton(
        //       onPressed: () {
        //         _launchCaller(widget.Memeberdetails.phoneno);
        //       },
        //       child: Icon(Icons.call),
        //     ),
        //     SizedBox(height: 16.0), // Add some spacing between the buttons
        //     FloatingActionButton(
        //       onPressed: () {
        //         Whatapps(widget.Memeberdetails.phoneno);
        //       },
        //       child: ImageIcon(
        //         AssetImage("assets/images/whatapp.png"),
        //         color: Colors.black,
        //         size: 30,
        //       ),
        //     ),
        //   ],
        // ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Whatapps(widget.Memeberdetails.phoneno);
        //   },
        //   child: ImageIcon(
        //     AssetImage("assets/images/whatapp.png"),
        //     color: Colors.black,
        //     size: 30,
        //   ),
        // ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Whatapps(widget.Memeberdetails.phoneno);
        //   },
        //   child: ImageIcon(
        //     AssetImage("assets/images/whatapp.png"),
        //     color: Colors.black,
        //     size: 30,
        //   ),
        // ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: GoogleFonts.salsa(color: ColorConstant.whiteA700),
          ),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_sharp)),
          automaticallyImplyLeading: false,
          backgroundColor: ColorConstant.puregolden,
          actions: [
            Row(
              children: [
                Text(
                  "Log Out",
                  style: GoogleFonts.salsa(
                      fontSize: 16, color: ColorConstant.redA700),
                ),
                IconButton(
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    await preferences.clear();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: Icon(Icons.exit_to_app_sharp),
                  color: ColorConstant.redA700,
                ),
              ],
            )
          ],
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

  Future _firstLoad() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      setState(() {
        // username = preferences.getString('username');
      });

      final Uri uri =
          Uri.parse('https://maaalankarjewellers.com/erp/api/logged_user');

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
          final user = jsonData['user'];
          final member = jsonData['member'];

          // if (user is Map && member is Map) {
          User userObject = User.fromJson(user);
          Member memberObject = Member.fromJson(member);

          setState(() {
            _DisplayListUser = [userObject];

            _DisplayListMember = [memberObject];
            // You can add the memberObject to another list if needed.
          });
        } else {
          print('Data key not found in JSON.');
        }
      } else {
        print('HTTP request failed with status: ${response.statusCode}');
      }
    } catch (err) {
      print('An error occurred: $err');
    }
  }

  void _showImageFullScreen(BuildContext context, String? imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(imageUrl.toString())
                  // image: imageUrl != null
                  //     ? NetworkImage(imageUrl)
                  //     : AssetImage(
                  //         'assets/placeholder_image.png'), // Add your placeholder image asset
                  ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 50,
                      color: ColorConstant.redA700,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // void _launchCaller(String Contact) async {
  //   Uri call = Uri(scheme: 'tel', path: Contact);
  //   // String url = '+91$phoneNumber';
  //   if (await launchUrl(call)) {
  //     await launchUrl(call);
  //   } else {
  //     throw 'Could not launch $call';
  //   }
  // }

  // void Whatapps(String number) async {
  //   Uri call = Uri.parse("https://wa.me/+91$number");
  //   // String url = '+91$phoneNumber';
  //   if (await launchUrl(call)) {
  //     await launchUrl(call);
  //   } else {
  //     throw 'Could not launch $call';
  //   }
  // }
}
