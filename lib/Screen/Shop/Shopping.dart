// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:MaaAlankar/class/Colorconstant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   _launchURL("https://maaalankarjewellers.com/shop/");
  // }

  // Future<void> _launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shop Now",
          style: GoogleFonts.salsa(color: ColorConstant.whiteA700),
        ),
        automaticallyImplyLeading: false,
        // leading: InkWell(
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //     child: Icon(Icons.arrow_back_ios)),
        backgroundColor: ColorConstant.golden,
      ),
      body: WebView(
        initialUrl:
            'https://maaalankarjewellers.com/shop/', // Replace with your desired URL
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (String url) {
          // Inject your CSS and JS after the page is loaded
          injectCustomCode();
        },
      ),
    );
  }

  void injectCustomCode() async {
    // Get the WebViewController
    WebViewController controller = await _controller.future;

    // Inject custom CSS

    await controller.evaluateJavascript("""
      var style = document.createElement('style');
      style.innerHTML = '/* Your CSS code here */';
      document.head.appendChild(style);
    """);

    // Inject custom JS
    await controller.evaluateJavascript("""
      // Your JS code here
    """);
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
}
