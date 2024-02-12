// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, prefer_const_constructors, avoid_print

import 'dart:convert';
import 'dart:typed_data';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:MaaAlankar/Models/Dashboard.dart';
import 'package:MaaAlankar/class/Colorconstant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditScreen extends StatefulWidget {
  Member _member;
  ProfileEditScreen(this._member);

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  DateTime dob = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the current user data
    _nameController.text = widget._member.proprietername ?? "";
    _emailController.text = widget._member.proemail ?? "";
    // dob = widget._member.dob;
  }

  final ImagePicker picker = ImagePicker();
  XFile? image;
  Uint8List? imagebytearray;

  Future getImage(
    ImageSource media,
  ) async {
    var img = await picker.pickImage(source: media, imageQuality: 30);
    var byte = await img!.readAsBytes();

    setState(() {
      // image = img;
      image = img;
      imagebytearray = byte;
      // hasData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      image != null
                          ? Image.memory(
                              imagebytearray!,
                              width: 100,
                              height: 100,
                            )
                          : Text('No image selected'),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              getImage(ImageSource.gallery);
                              // pickImage(ImageSource.gallery);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.lightBlue701,
                              elevation: 3,
                            ),
                            child: Text(
                              'Gallery',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              getImage(ImageSource.camera);
                              // pickImage(ImageSource.camera);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.lightBlue701,
                              elevation: 3,
                            ),
                            child: Text(
                              'Camara',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            // SizedBox(height: 16.0),
            // TextField(
            //   controller: _emailController,
            //   decoration: InputDecoration(labelText: 'Date Of Merriage'),
            // ),
            // SizedBox(height: 16.0),
            // TextField(
            //   // controller: dob.toString(),
            //   decoration: InputDecoration(labelText: 'Date Of Birth'),
            // ),
            SizedBox(height: 32.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Save the changes and navigate back
                  AddMeeting(_nameController.text, _emailController.text);
                },
                child: Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future AddMeeting(name, email) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? sender = preferences.getString('username');
      String? token = preferences.getString('token');
// Read the image bytes
      Uint8List imageBytes = await image!.readAsBytes();

      // Convert bytes to base64
      String base64Image = base64Encode(imageBytes);
      var Insertobj = new Map<String, dynamic>();

      Insertobj["proprietername"] = name;
      Insertobj["proemail"] = email;
      Insertobj["memberid"] = widget._member.memberid;
      Insertobj["photo"] = base64Image;
      // Insertobj["image"] = base64Image;

      final Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final request = http.Request(
          "POST",
          Uri.parse(
              'https://maaalankarjewellers.com/erp/api/editMemberapipost'));

      request.headers.addAll(headers);
      request.body = json.encode(Insertobj);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        dynamic json = jsonDecode(await response.stream.bytesToString());
        return Navigator.pop(context);
        // _showSnackbar(context);
        // Navigator.pop(context, widget.counter + 1);
      } else {
        // addData();
      }
      throw new Exception();
    } catch (_, ex) {
      return false;
    }
  }
}
