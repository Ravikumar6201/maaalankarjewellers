// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, prefer_final_fields, unused_field, prefer_const_literals_to_create_immutables, non_constant_identifier_names, deprecated_member_use

import 'package:MaaAlankar/Models/Image_benner.dart';
import 'package:MaaAlankar/class/Colorconstant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailsScreen extends StatefulWidget {
  Latestproduct _products;
  ProductDetailsScreen(this._products);
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            widget._products
                .latestProduct!, // Replace with your product image URL
            height: 250.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Welcome To",
                  style: GoogleFonts.lato(
                      fontSize: 25, color: ColorConstant.lightBlue700),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    " Maa Alankar Jewellers",
                    style: GoogleFonts.lato(fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    " Please contact for above product",
                    style: GoogleFonts.lato(fontSize: 20),
                  ),
                )
                // Text(
                //   'Product Name',
                //   style: TextStyle(
                //     fontSize: 20.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // SizedBox(height: 8.0),
                // Text(
                //   'Price: \$50.00', // Replace with your product price
                //   style: TextStyle(
                //     fontSize: 16.0,
                //     color: Colors.green,
                //   ),
                // ),
                // SizedBox(height: 16.0),
                // Text(
                //   'Product Description goes here. You can provide a detailed description of the product.',
                //   style: TextStyle(fontSize: 16.0),
                // ),
                // SizedBox(height: 16.0),
                // ElevatedButton(
                //   onPressed: () {
                //     // Add to cart functionality or any other action
                //   },
                //   child: Text('Add to Cart'),
                // ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _launchCaller("6513568588");
            },
            child: Icon(
              Icons.call,
              color: ColorConstant.black900,
            ),
          ),
          SizedBox(height: 16.0), // Add some spacing between the buttons
          FloatingActionButton(
            onPressed: () {
              sendImageToWhatsApp(
                  "9431581043", widget._products.latestProduct!);
              // Whatapps("9431581043");
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

  void _launchCaller(String Contact) async {
    Uri call = Uri(scheme: 'tel', path: Contact);
    // String url = '+91$phoneNumber';
    if (await launchUrl(call)) {
      await launchUrl(call);
    } else {
      throw 'Could not launch $call';
    }
  }

  void sendImageToWhatsApp(String phoneNumber, String imageUrl) async {
    final url =
        'https://wa.me/$phoneNumber/?text=${Uri.encodeComponent('Check out this image: $imageUrl')}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle error, e.g., show an alert
      print('Could not launch $url');
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
}

// class ProductDetailsWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return  }
// }