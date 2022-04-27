// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:line_icons/line_icons.dart';

// class BankRekeningDetail extends StatefulWidget {
//   @override
//   State<BankRekeningDetail> createState() => _BankRekeningDetailState();
// }

// class _BankRekeningDetailState extends State<BankRekeningDetail> {
//   @override
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
//             "Detail Pendaftar",
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
//           onPressed: () async {
//             // Navigator.of(context).push(MaterialPageRoute(
//             //     builder: (context) => BankDeskripsiUbah(role_uuid, tampil_data )));
//           },
//           label: Text(
//             'Download Data',
//             style: GoogleFonts.roboto(
//                 color: Colors.black87,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700),
//           ),
//           icon: Icon(
//             LineIcons.download,
//             color: Colors.black87,
//           ),
//           backgroundColor: Color(0xFFFFC600),
//         ),
//       ),
//       body: ListView(
//         children: [
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
//                     'Chandra Tirtsyandysh',
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
//                         'Jl Temanggung Tilung X No 115',
//                         style: GoogleFonts.inter(),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.02,
//                   ),
//                   Row(
//                     children: [
//                       Icon(
//                         LineIcons.whatSApp,
//                         color: Colors.black87,
//                       ),
//                       SizedBox(
//                         width: size.width * 0.02,
//                       ),
//                       SelectableText(
//                         '085251762717',
//                         textAlign: TextAlign.justify,
//                         style: GoogleFonts.inter(height: 1.6),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: size.height * 0.02,
//                   ),
//                   Row(
//                     children: [
//                       Icon(
//                         LineIcons.mailBulk,
//                         color: Colors.black87,
//                       ),
//                       SizedBox(
//                         width: size.width * 0.02,
//                       ),
//                       SelectableText(
//                         'chandratiryansyah@gmail.com',
//                         textAlign: TextAlign.justify,
//                         style: GoogleFonts.inter(height: 1.6),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: size.height * 0.02,
//                   ),
//                   Row(
//                     children: [
//                       Icon(
//                         LineIcons.userCircle,
//                         color: Colors.black87,
//                       ),
//                       SizedBox(
//                         width: size.width * 0.02,
//                       ),
//                       SelectableText(
//                         'Swasta',
//                         textAlign: TextAlign.justify,
//                         style: GoogleFonts.inter(height: 1.6),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: size.height * 0.06,
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
