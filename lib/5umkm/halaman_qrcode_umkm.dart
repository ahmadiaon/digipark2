// import 'dart:convert';
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
// // import 'package:_apk/0lainlain/CustomDialogVerifikasi_super.dart';
// // import 'package:_apk/0lainlain/textinputdecor.dart';
// // import 'package:_apk/1MenuLogin/menulogin.dart';
// // import 'package:_apk/1MenuLogin/sedang_verifikasi.dart';

// // import 'anggotaVerifSuper_Model.dart';

// class HalamanQrCodeUmkm extends StatefulWidget {
//   final IsiUmkm data_umkm;
//   HalamanQrCodeUmkm({Key key, this.data_umkm}) : super(key: key);
//   @override
//   _HalamanQrCodeUmkmState createState() => _HalamanQrCodeUmkmState();
// }

// class _HalamanQrCodeUmkmState extends State<HalamanQrCodeUmkm> {
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
//             widget.data_umkm.judul,
//             style: GoogleFonts.roboto(
//                 color: Colors.black87,
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.w600),
//           ),
//         ),
//       ),
//       floatingActionButton: Container(
//         height: size.height * 0.05,
//         child: FloatingActionButton.extended(
//           // splashColor: Colors.green,
//           onPressed: () async {},
//           label: Text(
//             'Pesan',
//             style: GoogleFonts.roboto(
//                 color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
//           ),
//           icon: Icon(
//             LineIcons.whatSApp,
//             color: Colors.white,
//           ),
//           backgroundColor: Color(0xFF18b15a),
//         ),
//         //  child: FloatingActionButton(
//         //   onPressed: () async {
//         //     final image =
//         //         await screenshotController.captureFromWidget(buildImage());
//         //     saveAndShare(image);
//         //   },
//         //   child: Icon(Icons.print),
//         //   backgroundColor: Color(0xFF0053A3),
//         // ),
//       ),
//       body: ListView(
//         children: <Widget>[
//           Container(
//             margin: EdgeInsets.only(left: 20, right: 20, top: 20),
//             height: size.height * 0.26,
//             child: CarouselSlider.builder(
//               autoSliderDelay: Duration(seconds: 2),
//               autoSliderTransitionTime: Duration(seconds: 2),
//               // autoSliderTransitionCurve: Curves.easeInBack,
//               unlimitedMode: true,
//               controller: _sliderController,
//               slideBuilder: (index) {
//                 return AspectRatio(
//                   aspectRatio: 16 / 9,
//                   child: ClipRRect(
//                       // borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       child: Stack(
//                     children: <Widget>[
//                       // Image.network(item, fit: BoxFit.cover, width: 1000.0),
//                       Image.asset(
//                           carousel_gambar_1dirtyborneo[index].gambar_detail,
//                           fit: BoxFit.cover),
//                     ],
//                   )),
//                 );
//               },
//               slideTransform: CubeTransform(),
//               slideIndicator: CircularSlideIndicator(
//                 itemSpacing: 13,
//                 indicatorRadius: 5,
//                 indicatorBorderWidth: 0,
//                 indicatorBackgroundColor: Colors.green[100],
//                 currentIndicatorColor: Color(0xFF18b15a),
//                 // padding: EdgeInsets.only(bottom: 32),
//                 // indicatorBorderColor: Colors.black,
//               ),
//               itemCount: carousel_gambar_1dirtyborneo.length,
//               initialPage: 0,
//               enableAutoSlider: true,
//             ),
//           ),
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
//                   SelectableText(
//                     widget.data_umkm.judul,
//                     style: GoogleFonts.inter(
//                         fontSize: 18, height: 1.5, fontWeight: FontWeight.bold),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
//                     width: size.width * 0.38,
//                     height: size.height * 0.005,
//                     decoration: BoxDecoration(
//                         color: Color(0xFFFFC600),
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.0235,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(3)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(6.0),
//                       child: Text(
//                         widget.data_umkm.alamat,
//                         style: GoogleFonts.inter(),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.01,
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: RaisedButton.icon(
//                           onPressed: () {
//                             // Navigator.of(context).push(MaterialPageRoute(
//                             //     builder: (context) => HalamanKomunitas()));
//                           },
//                           icon: Icon(
//                             LineIcons.mapMarked,
//                             color: Colors.black87,
//                           ),
//                           label: Text(
//                             "Lihat di Peta",
//                             style: GoogleFonts.roboto(
//                                 color: Colors.black87,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w600),
//                             textAlign: TextAlign.center,
//                           ),
//                           color: Color(0xFFFFC600),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5)),
//                         ),
//                       ),
//                       SizedBox(
//                         width: size.width * 0.02,
//                       ),
//                       Expanded(
//                         child: RaisedButton.icon(
//                           onPressed: () {
//                             // Navigator.of(context).push(MaterialPageRoute(
//                             //     builder: (context) => HalamanKomunitas()));
//                           },
//                           icon: Icon(
//                             LineIcons.qrcode,
//                             color: Colors.black87,
//                           ),
//                           label: Text(
//                             "QR Code",
//                             style: GoogleFonts.roboto(
//                                 color: Colors.black87,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w600),
//                             textAlign: TextAlign.center,
//                           ),
//                           color: Color(0xFFFFC600),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5)),
//                         ),
//                       ),
//                       // SizedBox(
//                       //   width: size.width * 0.02,
//                       // ),
//                       // RaisedButton.icon(
//                       //   onPressed: () {
//                       //     // Navigator.of(context).push(MaterialPageRoute(
//                       //     //     builder: (context) => HalamanKomunitas()));
//                       //   },
//                       //   icon: Icon(
//                       //     LineIcons.comment,
//                       //     color: Colors.black87,
//                       //   ),
//                       //   label: Text(
//                       //     "Ulasan",
//                       //     style: GoogleFonts.roboto(
//                       //         color: Colors.black87,
//                       //         fontSize: 13,
//                       //         fontWeight: FontWeight.w600),
//                       //     textAlign: TextAlign.center,
//                       //   ),
//                       //   color: Color(0xFFFFC600),
//                       //   shape: RoundedRectangleBorder(
//                       //       borderRadius: BorderRadius.circular(5)),
//                       // ),
//                     ],
//                   ),
//                   // Row(
//                   //   children: <Widget>[
//                   //     Container(
//                   //       decoration: BoxDecoration(
//                   //           border: Border.all(color: Colors.grey),
//                   //           borderRadius: BorderRadius.circular(3)),
//                   //       child: Padding(
//                   //         padding: const EdgeInsets.all(6.0),
//                   //         child: SelectableText(
//                   //           widget.data_umkm.kategori,
//                   //           style: GoogleFonts.inter(),
//                   //         ),
//                   //       ),
//                   //     ),
//                   //     // SizedBox(
//                   //     //   width: size.width * 0.024,
//                   //     // ),
//                   //     // Container(
//                   //     //   decoration: BoxDecoration(
//                   //     //       border: Border.all(color: Colors.grey),
//                   //     //       borderRadius: BorderRadius.circular(3)),
//                   //     //   child: Padding(
//                   //     //     padding: const EdgeInsets.all(6.0),
//                   //     //     child: SelectableText(
//                   //     //       widget.data_umkm.alamat,
//                   //     //       style: GoogleFonts.inter(),
//                   //     //     ),
//                   //     //   ),
//                   //     // ),
//                   //   ],
//                   // ),
//                   SizedBox(
//                     height: size.height * 0.01,
//                   ),
//                   SelectableText(
//                     widget.data_umkm.deskripsi,
//                     textAlign: TextAlign.justify,
//                     style: GoogleFonts.inter(height: 1.6),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.02,
//                   ),
//                   SelectableText(
//                     'Media Sosial',
//                     style: GoogleFonts.inter(
//                         fontSize: 17, height: 1.5, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.005,
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: RaisedButton.icon(
//                           onPressed: () {
//                             // Navigator.of(context).push(MaterialPageRoute(
//                             //     builder: (context) => HalamanKomunitas()));
//                           },
//                           icon: Icon(
//                             LineIcons.instagram,
//                             color: Colors.black87,
//                           ),
//                           label: Text(
//                             "Instagram",
//                             style: GoogleFonts.roboto(
//                                 color: Colors.black87,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w600),
//                             textAlign: TextAlign.center,
//                           ),
//                           color: Color(0xFFFFC600),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5)),
//                         ),
//                       ),
//                       SizedBox(
//                         width: size.width * 0.02,
//                       ),
//                       Expanded(
//                         child: RaisedButton.icon(
//                           onPressed: () {
//                             // Navigator.of(context).push(MaterialPageRoute(
//                             //     builder: (context) => HalamanKomunitas()));
//                           },
//                           icon: Icon(
//                             LineIcons.youtube,
//                             color: Colors.black87,
//                           ),
//                           label: Text(
//                             "Youtube",
//                             style: GoogleFonts.roboto(
//                                 color: Colors.black87,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w600),
//                             textAlign: TextAlign.center,
//                           ),
//                           color: Color(0xFFFFC600),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5)),
//                         ),
//                       ),
//                     ],
//                   ),
//                   // SizedBox(
//                   //   height: size.height * 0.02,
//                   // ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: RaisedButton.icon(
//                           onPressed: () {
//                             // Navigator.of(context).push(MaterialPageRoute(
//                             //     builder: (context) => HalamanKomunitas()));
//                           },
//                           icon: Icon(
//                             LineIcons.facebookSquare,
//                             color: Colors.black87,
//                           ),
//                           label: Text(
//                             "Facebook",
//                             style: GoogleFonts.roboto(
//                                 color: Colors.black87,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w600),
//                             textAlign: TextAlign.center,
//                           ),
//                           color: Color(0xFFFFC600),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5)),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: size.height * 0.017,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Ulasan teratas",
//                         style: GoogleFonts.roboto(
//                             fontSize: 18,
//                             height: 1.5,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       GestureDetector(
//                         onTap: () => Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => Reviews(),
//                           ),
//                         ),
//                         child: Text(
//                           "Selengkapnya",
//                           style: GoogleFonts.roboto(
//                               color: Color(0xFF18b15a),
//                               fontSize: 15,
//                               height: 1.5,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                   ListView.separated(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
//                     itemCount: 3,
//                     itemBuilder: (context, index) {
//                       return ReviewUI(
//                         image: reviewList[index].image,
//                         name: reviewList[index].name,
//                         date: reviewList[index].date,
//                         comment: reviewList[index].comment,
//                         rating: reviewList[index].rating,
//                         onPressed: () => print("More Action $index"),
//                         onTap: () => setState(() {
//                           isMore = !isMore;
//                         }),
//                         isLess: isMore,
//                       );
//                     },
//                     separatorBuilder: (context, index) {
//                       return Divider(
//                         thickness: 2.0,
//                         color: kAccentColor,
//                       );
//                     },
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
