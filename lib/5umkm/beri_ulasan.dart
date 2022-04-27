// import 'dart:convert';
// import 'package:digipark/0lainlain/custom_dialog.dart';
// import 'package:digipark/0lainlain/gambar_model.dart';
// import 'package:digipark/0lainlain/textinputdecor.dart';
// import 'package:digipark/0lainlain/umkm_model.dart';
// import 'package:digipark/widgets/constant.dart';
// import 'package:digipark/widgets/reviewUI.dart';
// import 'package:digipark/widgets/reviews.dart';
// import 'package:digipark/widgets/stickyLabel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_carousel_slider/carousel_slider.dart';
// import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
// import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_svg/svg.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:line_icons/line_icons.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';
// // import 'package:_apk/0lainlain/CustomDialogVerifikasi_super.dart';
// // import 'package:_apk/0lainlain/textinputdecor.dart';
// // import 'package:_apk/1MenuLogin/menulogin.dart';
// // import 'package:_apk/1MenuLogin/sedang_verifikasi.dart';

// // import 'anggotaVerifSuper_Model.dart';

// class BeriUlasan extends StatefulWidget {
//   final IsiUmkm data_umkm;
//   BeriUlasan({Key key, this.data_umkm}) : super(key: key);
//   @override
//   _BeriUlasanState createState() => _BeriUlasanState();
// }

// class _BeriUlasanState extends State<BeriUlasan> {
//   bool _isPlaying = false;
//   bool isMore = false;

//   CarouselSliderController _sliderController;

//   @override
//   void initState() {
//     super.initState();
//     _sliderController = CarouselSliderController();
//   }

//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(size.height * 0.052),
//         child: AppBar(
//           elevation: 0,
//           foregroundColor: Colors.black87,
//           centerTitle: true,
//           backgroundColor: Color(0xFFFFC600),
//           title: Text(
//             "Beri Ulasan",
//             style: GoogleFonts.roboto(
//                 color: Colors.black87,
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.w600),
//           ),
//         ),
//       ),
//       body: ListView(
//         children: <Widget>[
//           Container(
//             // margin: EdgeInsets.only(top: size.height * 0.3),
//             width: double.infinity,
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30.0),
//                   topRight: Radius.circular(30.0),
//                 )),
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     // padding: EdgeInsets.only(
//                     //   top: 2.0,
//                     //   bottom: 2.0,
//                     //   left: 16.0,
//                     //   right: 0.0,
//                     // ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Berikan ulasan Anda",
//                           style: GoogleFonts.inter(
//                             fontSize: 15.0,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Container(
//                               height: 35.0,
//                               width: 35.0,
//                               margin: EdgeInsets.only(right: 12.0),
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   image:
//                                       AssetImage("assets/images/profil1.jpeg"),
//                                   fit: BoxFit.cover,
//                                 ),
//                                 borderRadius: BorderRadius.circular(44.0),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 "Chandra Tirta",
//                                 style: GoogleFonts.roboto(
//                                   fontSize: 15.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             // IconButton(
//                             //   onPressed: () {
//                             //     // Navigator.of(context).push(MaterialPageRoute(
//                             //     //     builder: (context) => BeriUlasan()));
//                             //   },
//                             //   icon: Icon(Icons.more_vert),
//                             // ),
//                           ],
//                         ),
//                         SizedBox(height: 8.0),
//                         Row(
//                           children: [
//                             SmoothStarRating(
//                               starCount: 5,
//                               rating: 0,
//                               size: 55.0,
//                               color: Colors.orange,
//                               borderColor: Colors.orange,
//                             ),
//                             SizedBox(width: kFixPadding),
//                             // Text(
//                             //   date,
//                             //   style: GoogleFonts.roboto(fontSize: 14.0, fontWeight: FontWeight.w600,),
//                             // ),
//                           ],
//                         ),
//                         SizedBox(height: 8.0),
//                         // GestureDetector(
//                         //   onTap: onTap,
//                         //   child: isLess
//                         //       ? Text(
//                         //           comment,
//                         //           style: GoogleFonts.roboto(
//                         //             fontSize: 15.0,
//                         //             color: kLightColor,
//                         //           ),
//                         //         )
//                         //       : Text(
//                         //           comment,
//                         //           maxLines: 3,
//                         //           overflow: TextOverflow.ellipsis,
//                         //           style: GoogleFonts.roboto(
//                         //             fontSize: 15.0,
//                         //             color: kLightColor,
//                         //             fontWeight: FontWeight.w400,
//                         //           ),
//                         //         ),
//                         // ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.005,
//                   ),
//                   RaisedButton.icon(
//                     onPressed: () {
//                       // Navigator.of(context).push(MaterialPageRoute(
//                       //     builder: (context) => HalamanKomunitas()));
//                     },
//                     icon: Icon(
//                       LineIcons.comment,
//                       color: Colors.black87,
//                     ),
//                     label: Text(
//                       "Beri Ulasan",
//                       style: GoogleFonts.roboto(
//                           color: Colors.black87,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600),
//                       textAlign: TextAlign.center,
//                     ),
//                     color: Color(0xFFFFC600),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5)),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.04,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
