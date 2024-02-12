// // ignore_for_file: prefer_const_constructors

// import 'package:MaaAlankar/Screen/Paymet/Paytm_PaymentGetway.dart';
// import 'package:MaaAlankar/Screen/Winners/Winner_Details.dart';
// import 'package:MaaAlankar/Screen/Winners/Winners.dart';
// import 'package:MaaAlankar/Screen/support/Supports.dart';
// import 'package:flutter/material.dart';

// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({Key? key}) : super(key: key);

//   Widget _thumbnailPart() {
//     return Row(
//       children: [
//         SizedBox(
//           width: 50,
//           height: 50,
//           child: CircleAvatar(
//             backgroundImage:
//                 Image.asset("assets/images/profilepic.png", fit: BoxFit.contain)
//                     .image,
//           ),
//         ),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   "Sudarlife",
//                   style: TextStyle(color: Colors.white, fontSize: 24),
//                 ),
//                 Text(
//                   "Boys, be ambitious",
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.5),
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget get _line => Container(
//       margin: const EdgeInsets.symmetric(vertical: 15),
//       height: 1,
//       color: Colors.white.withOpacity(0.2));

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         padding: const EdgeInsets.all(25),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             _thumbnailPart(),
//             SizedBox(height: 20),
//             _line,
//             MenuBox(
//               padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
//               icon: Icon(
//                 Icons.add_chart,
//                 color: Colors.white,
//               ),
//               menu: InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PAymentScreen(),
//                     ),
//                   ).then((_) async {
//                     // await _firstLoad();
//                     // await _firstLoadSend();
//                   });
//                 },
//                 child: Text(
//                   "Payment",
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             MenuBox(
//               padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
//               icon: Icon(
//                 Icons.add_to_photos_outlined,
//                 color: Colors.white,
//               ),
//               menu: InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => WinnersScreen(),
//                     ),
//                   ).then((_) async {
//                     // await _firstLoad();
//                     // await _firstLoadSend();
//                   });
//                 },
//                 child: Text(
//                   "Winners",
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             MenuBox(
//               padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
//               icon: Icon(
//                 Icons.announcement_rounded,
//                 color: Colors.white,
//               ),
//               menu: InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SupportScreen(),
//                     ),
//                   ).then((_) async {
//                     // await _firstLoad();
//                     // await _firstLoadSend();
//                   });
//                 },
//                 child: Text(
//                   "Support",
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             // MenuBox(
//             //   padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
//             //   icon: Icon(
//             //     Icons.settings,
//             //     color: Colors.white,
//             //   ),
//             // menu: InkWell(
//             //   onTap: (){
//             //      Navigator.push(
//             //       context,
//             //       MaterialPageRoute(
//             //         builder: (context) =>
//             //             pro(),
//             //       ),
//             //     ).then((_) async {
//             //       // await _firstLoad();
//             //       // await _firstLoadSend();
//             //     });
//             //   },
//             //   child: Text(
//             //     "Profile",
//             //     style: TextStyle(
//             //       fontSize: 20,
//             //       color: Colors.white,
//             //     ),
//             //   ),
//             // ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MenuBox extends StatelessWidget {
//   final EdgeInsetsGeometry? padding;
//   final Widget? icon;
//   final Widget menu;
//   final Function()? onTap;
//   const MenuBox({
//     Key? key,
//     required this.menu,
//     this.padding = const EdgeInsets.all(10),
//     this.icon,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (onTap != null) {
//           this.onTap!();
//         }
//       },
//       child: Container(
//         padding: padding,
//         child: Row(
//           children: [
//             icon != null ? icon! : Container(),
//             SizedBox(width: 15),
//             menu,
//           ],
//         ),
//       ),
//     );
//   }
// }
