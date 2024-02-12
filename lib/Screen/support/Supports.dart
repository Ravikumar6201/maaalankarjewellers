// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'package:MaaAlankar/class/Colorconstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  String address = "Main Road, Opposite Reliance Foot Print, Ranchi, 834001";
  String Contact1 = "9431581043";
  String Contact2 = "6513568588";
  String Email = "maaalankar@gmail.com";
  String Location =
      "Maa Alankar Jewellers Main Opposite Reliance Foot Print, Ranchi, 834001";
  String Website = "https://maaalankarjewellers.com/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Support",
          style: GoogleFonts.salsa(color: ColorConstant.whiteA700),
        ),
        actions: [
          IconButton(
              onPressed: () {
                shareProfile();
              },
              icon: Row(
                children: [
                  Text(
                    "Share",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ],
              ))
        ],
        backgroundColor: ColorConstant.golden,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10,
          child: Container(
            color: Colors.white,
            width: double.infinity,
            height: 300,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageIcon(
                        AssetImage("assets/images/call.jpg"),
                        color: Colors.black,
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "9431581043",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageIcon(
                        AssetImage("assets/images/call.jpg"),
                        color: Colors.black,
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "6513568588",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageIcon(
                        AssetImage("assets/images/message.png"),
                        color: Colors.black,
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: InkWell(
                          onLongPress: () {
                            _copyToClipboard("maaalankar@gmail.com", context);
                          },
                          child: Text(
                            "maaalankar@gmail.com",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ImageIcon(
                        AssetImage("assets/images/location.png"),
                        color: Colors.black,
                        size: 30,
                      ),
                      InkWell(
                        onTap: () {
                          openGoogleMaps(address);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            "Maa Alankar Jewellers Main Road, " +
                                "\n" +
                                "Opposite Reliance Foot" +
                                "\n" +
                                "Print, Ranchi, 834001",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageIcon(
                        AssetImage("assets/images/web.png"),
                        color: Colors.black,
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Row(
                          children: [
                            Text(
                              "Website : ",
                              style: TextStyle(fontSize: 18),
                            ),
                            InkWell(
                              onTap: () {
                                _launchURL("https://maaalankarjewellers.com/");
                              },
                              child: Text(
                                "https://maaalankarjewellers.com/",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.underline,
                                    color: ColorConstant.lightBlue700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _launchCaller("6513568588");
            },
            child: Icon(Icons.call),
          ),
          SizedBox(height: 16.0), // Add some spacing between the buttons
          FloatingActionButton(
            onPressed: () {
              Whatapps("9431581043");
            },
            // backgroundColor: ColorConstant.whiteA700,
            // child: Icon(Icons.whatshot_sharp),
            child: Image(
              image: AssetImage('assets/images/whatapp.png'),
              // color: Colors.black,
              height: 30,
              width: 30,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _copyToClipboard(String text, BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Text copied to clipboard'),
      ),
    );
  }

  void _launchCaller(String Contact) async {
    Uri call = Uri(scheme: 'tel', path: Contact);
    // String url = '+91$phoneNumber';
    if (await launchUrl(call)) {
      await launchUrl(call);
    } else {
      throw 'Could not launch $call';
    }
  }

  void Whatapps(String number) async {
    Uri call = Uri.parse("https://wa.me/+91$number");
    // String url = '+91$phoneNumber';
    if (await launchUrl(call)) {
      await launchUrl(call);
    } else {
      throw 'Could not launch $call';
    }
  }

  Future<void> openGoogleMaps(String address) async {
    // The URL to open the Google Maps app with the provided address
    final url =
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}';

    // Check if the URL can be launched
    if (await canLaunch(url)) {
      // Launch the URL
      await launch(url);
    } else {
      // Handle the case where the URL can't be launched
      throw 'Could not launch $url';
    }
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit the app?'),
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

  void shareProfile() {
    Share.share("Maa Alankar jewellers Profile ⬇" +
        "\n" +
        "Contact : $Contact1" +
        "\n" +
        "Contact : $Contact2" +
        "\n" +
        "Email : $Email" +
        "\n" +
        "Location : $Location" +
        "\n" +
        "Website : $Website");
  }
}
