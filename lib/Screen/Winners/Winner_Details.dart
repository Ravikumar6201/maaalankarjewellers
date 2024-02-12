// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:MaaAlankar/Models/Winner.dart';
import 'package:MaaAlankar/class/Colorconstant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class WinnerDetailsScreen extends StatelessWidget {
  Winner _winnerList;
  WinnerDetailsScreen(this._winnerList);

  // final Member member;

  // WinnerDetailsScreen({required this.member});

  void shareProfile(Name, Group, City, Position) {
    Share.share("BCI Member Profile ⬇" +
        "\n" +
        "Name : $Name" +
        "\n" +
        "Group : $Group" +
        "\n" +
        "City : $City" +
        "\n" +
        "Position : $Position");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Member Details',
          style: GoogleFonts.salsa(color: ColorConstant.whiteA700),
        ),
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
              onPressed: () {
                shareProfile(_winnerList.winnerName, _winnerList.groupname,
                    "Ranchi", _winnerList.winnermnth);
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
        backgroundColor: ColorConstant.puregolden,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage("assets/images/profilepic.png"),
              ),
              SizedBox(height: 16),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _winnerList.winnerName.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "1 st Winner",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Group A",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Ranchi",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Morabadi",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),
              // Additional member details or actions can be added here
            ],
          ),
        ),
      ),
    );
  }
}





















// // ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';

// class WinnerDetailsScreen extends StatefulWidget {
//   @override
//   State<WinnerDetailsScreen> createState() => _WinnerDetailsScreenState();
// }

// class _WinnerDetailsScreenState extends State<WinnerDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Details Screen'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Name:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text('John Doe'),
            
//             SizedBox(height: 16.0),
            
//             Text(
//               'Age:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text('25'),
            
//             SizedBox(height: 16.0),
            
//             Text(
//               'Email:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text('john.doe@example.com'),
            
//             SizedBox(height: 16.0),
            
//             // Add more details as needed
//             Text(
//               'Address:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text('123 Main St'),
            
//             SizedBox(height: 16.0),
            
//             Text(
//               'Phone:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text('555-1234'),
            
//             // Add more details as needed
//           ],
//         ),
//       ),
//     );
//   }
// }