// ignore_for_file: use_key_in_widget_constructors, camel_case_types, prefer_const_constructors

import 'dart:async';

import 'package:MaaAlankar/class/Colorconstant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

// class Shipping_PolicyScreen extends StatefulWidget {
//   const Shipping_PolicyScreen({super.key});

//   @override
//   State<Shipping_PolicyScreen> createState() => _Shipping_PolicyScreenState();
// }

// class _Shipping_PolicyScreenState extends State<Shipping_PolicyScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Privecy Policy"),
//       automaticallyImplyLeading: false,
//         leading: InkWell(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Icon(Icons.arrow_back_ios)),
//         backgroundColor: ColorConstant.golden,),
//     );
//   }
// }

class Shipping_PolicyScreen extends StatefulWidget {
  @override
  State<Shipping_PolicyScreen> createState() => _Shipping_PolicyScreenState();
}

class _Shipping_PolicyScreenState extends State<Shipping_PolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Privecy Policy",
          style: GoogleFonts.salsa(color: ColorConstant.whiteA700),
        ),
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        backgroundColor: ColorConstant.golden,
      ),
      body: WebView(
        initialUrl:
            'https://maaalankarjewellers.com/shipping-policy/', // Replace with your desired URL
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
