import 'dart:convert';
import 'dart:io';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digipark/0lainlain/modal.dart';
import 'package:digipark/env.dart';
import '../skeleton/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../widgets/handlinginet.dart';
import 'halaman_detail_umkm.dart';

const String title = "";

class HalamanUmkm extends StatefulWidget {
  @override
  _HalamanUmkmState createState() => _HalamanUmkmState();
}

class _HalamanUmkmState extends State<HalamanUmkm> {
  List<BusinessModal> list_bussiness_life = [];
  List<BusinessModal> list_bussiness_digital = [];
  List<BusinessModal> list_bussiness_culture = [];
  List<BusinessModal> list_bussiness_food = [];

  List<BusinessModal> list_buss_life = [];
  List<BusinessModal> list_buss_digital = [];
  List<BusinessModal> list_buss_culture = [];
  List<BusinessModal> list_buss_food = [];

  String query = '';
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
    });
    //_lihatData();
  }

  String token = "";
  var loading = false;
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  Future<void> tampil_data() async {
    var koneksi;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        koneksi = 1;
      }
    } on SocketException catch (_) {
      print('not connected');
      koneksi = 0;
    }

    if (koneksi == 1) {
      list_bussiness_life.clear();
      list_bussiness_digital.clear();
      list_bussiness_culture.clear();
      list_bussiness_food.clear();

      setState(() {
        loading = true;
      });

      //Life style
      final response = await http.get(
          Uri.http(URL,
              'api/v2/user/business/list'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            // "phone": phone_number,
          });
      if (response.contentLength == 2) {
      } else {
        final data = jsonDecode(response.body);
        // print(data);
        // String message = data['meta']['message'];
        // print(message);
        data['data'].forEach((api) {
          final ab = new BusinessModal(
            api['id'],
            api['uuid'],
            api['business_category_uuid'],
            api['name'],
            api['address'],
            api['city'],
            api['province'],
            api['description'],
            api['image_path'],
            api['location'],
            api['facebook'],
            api['instagram'],
            api['youtube'],
            api['whatsapp'],
            api['qr_code'],
            api['category'],
            api['status'],
            api['created_at'],
            api['updated_at'],
          );
          if (ab.business_category_uuid == '50d5e583-0014-4f92-8e8a-5f97deba728a') {
            list_bussiness_life.add(ab);
          }
          if (ab.business_category_uuid == '1a43afcb-ec92-450b-a46a-33fe0ffb07c1') {
            list_bussiness_digital.add(ab);
          }
          if (ab.business_category_uuid == 'aa752a10-3c54-468d-a07b-fa2cd44bc192') {
            list_bussiness_culture.add(ab);
          }
          if (ab.business_category_uuid == '25d6bf32-b461-4364-a5dd-7432ecfe09ae') {
            list_bussiness_food.add(ab);
          }
          // _search_business.add(ab);
        });
        print(data['data']);
        setState(() {
          loading = false;
        });
      }

      // //Digital
      // final response2 = await http.get(
      //     Uri.http(URL,
      //         'api/v2/user/business/list'),
      //     headers: {
      //       'Content-Type': 'application/json',
      //       'Accept': 'application/json',
      //       'Authorization': 'Bearer $token',
      //       // "phone": phone_number,
      //     });
      // if (response2.contentLength == 2) {
      // } else {
      //   final data = jsonDecode(response2.body);
      //   // print(data);
      //   // String message = data['meta']['message'];
      //   // print(message);
      //   data['data'].forEach((api) {
      //     final ab = new BusinessModal(
      //       api['id'],
      //       api['uuid'],
      //       api['business_category_uuid'],
      //       api['name'],
      //       api['address'],
      //       api['city'],
      //       api['province'],
      //       api['description'],
      //       api['image_path'],
      //       api['location'],
      //       api['facebook'],
      //       api['instagram'],
      //       api['youtube'],
      //       api['whatsapp'],
      //       api['qr_code'],
      //       api['category'],
      //       api['status'],
      //       api['created_at'],
      //       api['updated_at'],
      //     );
      //     if (ab.business_category_uuid ==
      //         '1a43afcb-ec92-450b-a46a-33fe0ffb07c1') {
      //       list_bussiness_digital.add(ab);
      //     }
      //     // _search_business.add(ab);
      //   });
      //   print(data['data']);
      //   setState(() {
      //     loading = false;
      //   });
      // }

      // //Culture & art
      // final response3 = await http.get(
      //     Uri.http(URL,
      //         'api/v2/user/business/list'),
      //     headers: {
      //       'Content-Type': 'application/json',
      //       'Accept': 'application/json',
      //       'Authorization': 'Bearer $token',
      //       // "phone": phone_number,
      //     });
      // if (response3.contentLength == 2) {
      // } else {
      //   final data = jsonDecode(response3.body);
      //   // print(data);
      //   // String message = data['meta']['message'];
      //   // print(message);
      //   data['data'].forEach((api) {
      //     final ab = new BusinessModal(
      //       api['id'],
      //       api['uuid'],
      //       api['business_category_uuid'],
      //       api['name'],
      //       api['address'],
      //       api['city'],
      //       api['province'],
      //       api['description'],
      //       api['image_path'],
      //       api['location'],
      //       api['facebook'],
      //       api['instagram'],
      //       api['youtube'],
      //       api['whatsapp'],
      //       api['qr_code'],
      //       api['category'],
      //       api['status'],
      //       api['created_at'],
      //       api['updated_at'],
      //     );
      //     if (ab.business_category_uuid ==
      //         'aa752a10-3c54-468d-a07b-fa2cd44bc192') {
      //       list_bussiness_culture.add(ab);
      //     }
      //     // _search_business.add(ab);
      //   });
      //   print(data['data']);
      //   setState(() {
      //     loading = false;
      //   });
      // }

      // //Food & Beverage
      // final response4 = await http.get(
      //     Uri.http(URL,
      //         'api/v2/user/business/list'),
      //     headers: {
      //       'Content-Type': 'application/json',
      //       'Accept': 'application/json',
      //       'Authorization': 'Bearer $token',
      //       // "phone": phone_number,
      //     });
      // if (response4.contentLength == 2) {
      // } else {
      //   final data = jsonDecode(response4.body);
      //   // print(data);
      //   // String message = data['meta']['message'];
      //   // print(message);
      //   data['data'].forEach((api) {
      //     final ab = new BusinessModal(
      //       api['id'],
      //       api['uuid'],
      //       api['business_category_uuid'],
      //       api['name'],
      //       api['address'],
      //       api['city'],
      //       api['province'],
      //       api['description'],
      //       api['image_path'],
      //       api['location'],
      //       api['facebook'],
      //       api['instagram'],
      //       api['youtube'],
      //       api['whatsapp'],
      //       api['qr_code'],
      //       api['category'],
      //       api['status'],
      //       api['created_at'],
      //       api['updated_at'],
      //     );
      //     if (ab.business_category_uuid ==
      //         '25d6bf32-b461-4364-a5dd-7432ecfe09ae') {
      //       list_bussiness_food.add(ab);
      //     }
      //     // _search_business.add(ab);
      //   });
      //   print(data['data']);
      //   setState(() {
      //     loading = false;
      //   });
      // }

      print(response);
      // print("response");
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HandlingInet(tampil_data: tampil_data)));
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
    tampil_data();

    list_buss_life = list_bussiness_life;
    list_buss_digital = list_bussiness_digital;
    list_buss_culture = list_bussiness_culture;
    list_buss_food = list_bussiness_food;
  }

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // Provide the [TabController]
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.021,
          ),
          Align(
            alignment: Alignment.center,
            child: Text("UMKM Palangka Raya",
                style: GoogleFonts.roboto(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87)),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          buildSearch(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 20, 15),
              child: DefaultTabController(
                length: 4,
                child: Column(
                  children: <Widget>[
                    ButtonsTabBar(
                      // backgroundColor: Color(0xFFFFC600),
                      // unselectedBackgroundColor: Colors.grey[300],
                      backgroundColor: Color(0xFF18b15a),
                      unselectedBackgroundColor: Color(0xFFFFC600),
                      unselectedLabelStyle: TextStyle(color: Colors.black87),
                      //     style: GoogleFonts.roboto(
                      // fontSize: 16,
                      // fontWeight: FontWeight.w800,
                      // color: Colors.black87)
                      labelStyle: GoogleFonts.roboto(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(
                          icon: Icon(LineIcons.tShirt),
                          text: "Life Style ",
                        ),
                        Tab(
                          icon: Icon(LineIcons.mobilePhone),
                          text: "Digital ",
                        ),
                        Tab(
                          icon: Icon(LineIcons.paintBrush),
                          text: "Culture & Art ",
                        ),
                        Tab(
                          icon: Icon(LineIcons.breadSlice),
                          text: "Food & Beverage ",
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: <Widget>[
                          life_style(),
                          digital(),
                          culture(),
                          food(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget life_style() {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Color(0xFFFFC600),
        onRefresh: tampil_data,
        child: loading
            ? buildSkeletonMenu(context)
            : list_buss_life.length == 0
                ? ListView(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(
                            top: size.height * 0.22,
                            bottom: size.height * 0.02,
                          ),
                          child: Text(
                              "Tidak ada UMKM\nPalangka Raya yang dicari",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Color(0xFF756F6F),
                                  fontWeight: FontWeight.bold))),
                      Container(
                          height: 110,
                          child: Image.asset(
                            "assets/icons/empty.png",
                          )),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ListView.builder(
                              itemCount: list_buss_life.length,
                              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //   crossAxisCount: 3,
                              //   mainAxisSpacing: 12,
                              //   crossAxisSpacing: 15,
                              //   childAspectRatio: 0.60,
                              // ),
                              itemBuilder: (context, i) {
                                final x = list_buss_life[i];
                                // final y = jsonDecode(x.image_path);
                                // final image = y[1];
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 10),
                                  child: AspectRatio(
                                    aspectRatio:
                                        size.height * 0.87 / size.height * 4,
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailUmkm(
                                                      x,
                                                    ),
                                                  ));
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                AspectRatio(
                                                  aspectRatio: size.height *
                                                      0.65 /
                                                      size.height *
                                                       2.35,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          URL_FULL +
                                                              x.image_path,
                                                      fit: BoxFit.cover,
                                                      //                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                      // CircularProgressIndicator(value: downloadProgress.progress),
                                                      placeholder: (context,
                                                              url) =>
                                                          buildSkeletonListView(
                                                              context),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.025,
                                                ),
                                                AspectRatio(
                                                  aspectRatio: size.height *
                                                      0.65 /
                                                      size.height *
                                                      2.7,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        x.name,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.006,
                                                      ),
                                                      Text(
                                                        x.description,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.006,
                                                      ),
                                                      Text(
                                                        x.address,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Color(
                                                                    0xFF18b15a),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 10),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // IconButton(
                                          //   onPressed: () {},
                                          //   icon: Icon(
                                          //     Icons.add_circle,
                                          //     color: Colors.brown[600],
                                          //     size: 36,
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          // itemBuilder: (context, index) => MenuCardkomnitas_isi(
                          //       menu_umkm: menu_umkm[index],
                          //       press2: () => Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) => DetailVerifikasi(
                          //               daftarkmunitas: index,
                          //             ),
                          //           )),
                          //     )),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget digital() {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Color(0xFFFFC600),
        onRefresh: tampil_data,
        child: loading
            ? buildSkeletonMenu(context)
            : list_buss_digital.length == 0
                ? ListView(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(
                            top: size.height * 0.22,
                            bottom: size.height * 0.02,
                          ),
                          child: Text(
                              "Tidak ada UMKM\nPalangka Raya yang dicari",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Color(0xFF756F6F),
                                  fontWeight: FontWeight.bold))),
                      Container(
                          height: 110,
                          child: Image.asset(
                            "assets/icons/empty.png",
                          )),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ListView.builder(
                              itemCount: list_buss_digital.length,
                              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //   crossAxisCount: 3,
                              //   mainAxisSpacing: 12,
                              //   crossAxisSpacing: 15,
                              //   childAspectRatio: 0.60,
                              // ),
                              itemBuilder: (context, i) {
                                final x = list_buss_digital[i];
                                // final y = jsonDecode(x.image_path);
                                // final image = y[1];
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 10),
                                  child: AspectRatio(
                                    aspectRatio:
                                        size.height * 0.87 / size.height * 4,
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailUmkm(
                                                      x,
                                                    ),
                                                  ));
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                AspectRatio(
                                                  aspectRatio: size.height *
                                                      0.65 /
                                                      size.height *
                                                       2.35,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          URL_FULL +
                                                              x.image_path,
                                                      fit: BoxFit.cover,
                                                      //                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                      // CircularProgressIndicator(value: downloadProgress.progress),
                                                      placeholder: (context,
                                                              url) =>
                                                          buildSkeletonListView(
                                                              context),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.025,
                                                ),
                                                AspectRatio(
                                                  aspectRatio: size.height *
                                                      0.65 /
                                                      size.height *
                                                      2.7,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        x.name,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.006,
                                                      ),
                                                      Text(
                                                        x.description,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.006,
                                                      ),
                                                      Text(
                                                        x.address,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Color(
                                                                    0xFF18b15a),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 10),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // IconButton(
                                          //   onPressed: () {},
                                          //   icon: Icon(
                                          //     Icons.add_circle,
                                          //     color: Colors.brown[600],
                                          //     size: 36,
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          // itemBuilder: (context, index) => MenuCardkomnitas_isi(
                          //       menu_umkm: menu_umkm[index],
                          //       press2: () => Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) => DetailVerifikasi(
                          //               daftarkmunitas: index,
                          //             ),
                          //           )),
                          //     )),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget culture() {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Color(0xFFFFC600),
        onRefresh: tampil_data,
        child: loading
            ? buildSkeletonMenu(context)
            : list_buss_culture.length == 0
                ? ListView(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(
                            top: size.height * 0.22,
                            bottom: size.height * 0.02,
                          ),
                          child: Text(
                              "Tidak ada UMKM\nPalangka Raya yang dicari",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Color(0xFF756F6F),
                                  fontWeight: FontWeight.bold))),
                      Container(
                          height: 110,
                          child: Image.asset(
                            "assets/icons/empty.png",
                          )),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ListView.builder(
                              itemCount: list_buss_culture.length,
                              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //   crossAxisCount: 3,
                              //   mainAxisSpacing: 12,
                              //   crossAxisSpacing: 15,
                              //   childAspectRatio: 0.60,
                              // ),
                              itemBuilder: (context, i) {
                                final x = list_buss_culture[i];
                                // final y = jsonDecode(x.image_path);
                                // final image = y[1];
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 10),
                                  child: AspectRatio(
                                    aspectRatio:
                                        size.height * 0.87 / size.height * 4,
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailUmkm(
                                                      x,
                                                    ),
                                                  ));
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                AspectRatio(
                                                  aspectRatio: size.height *
                                                      0.65 /
                                                      size.height *
                                                     2.35,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          URL_FULL +
                                                              x.image_path,
                                                      fit: BoxFit.cover,
                                                      //                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                      // CircularProgressIndicator(value: downloadProgress.progress),
                                                      placeholder: (context,
                                                              url) =>
                                                          buildSkeletonListView(
                                                              context),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.025,
                                                ),
                                                AspectRatio(
                                                  aspectRatio: size.height *
                                                      0.65 /
                                                      size.height *
                                                      2.7,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        x.name,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.006,
                                                      ),
                                                      Text(
                                                        x.description,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.006,
                                                      ),
                                                      Text(
                                                        x.address,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Color(
                                                                    0xFF18b15a),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 10),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // IconButton(
                                          //   onPressed: () {},
                                          //   icon: Icon(
                                          //     Icons.add_circle,
                                          //     color: Colors.brown[600],
                                          //     size: 36,
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          // itemBuilder: (context, index) => MenuCardkomnitas_isi(
                          //       menu_umkm: menu_umkm[index],
                          //       press2: () => Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) => DetailVerifikasi(
                          //               daftarkmunitas: index,
                          //             ),
                          //           )),
                          //     )),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget food() {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Color(0xFFFFC600),
        onRefresh: tampil_data,
        child: loading
            ? buildSkeletonMenu(context)
            : list_buss_food.length == 0
                ? ListView(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(
                            top: size.height * 0.22,
                            bottom: size.height * 0.02,
                          ),
                          child: Text(
                              "Tidak ada UMKM\nPalangka Raya yang dicari",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Color(0xFF756F6F),
                                  fontWeight: FontWeight.bold))),
                      Container(
                          height: 110,
                          child: Image.asset(
                            "assets/icons/empty.png",
                          )),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ListView.builder(
                              itemCount: list_buss_food.length,
                              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //   crossAxisCount: 3,
                              //   mainAxisSpacing: 12,
                              //   crossAxisSpacing: 15,
                              //   childAspectRatio: 0.60,
                              // ),
                              itemBuilder: (context, i) {
                                final x = list_buss_food[i];
                                // final y = jsonDecode(x.image_path);
                                // final image = y[1];
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 10),
                                  child: AspectRatio(
                                    aspectRatio:
                                        size.height * 0.87 / size.height * 4,
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailUmkm(
                                                      x,
                                                    ),
                                                  ));
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                AspectRatio(
                                                  aspectRatio: size.height *
                                                      0.65 /
                                                      size.height *
                                                     2.35,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          URL_FULL +
                                                              x.image_path,
                                                      fit: BoxFit.cover,
                                                      //                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                      // CircularProgressIndicator(value: downloadProgress.progress),
                                                      placeholder: (context,
                                                              url) =>
                                                          buildSkeletonListView(
                                                              context),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.025,
                                                ),
                                                AspectRatio(
                                                  aspectRatio: size.height *
                                                      0.65 /
                                                      size.height *
                                                      2.7,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        x.name,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.006,
                                                      ),
                                                      Text(
                                                        x.description,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.006,
                                                      ),
                                                      Text(
                                                        x.address,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Color(
                                                                    0xFF18b15a),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 10),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // IconButton(
                                          //   onPressed: () {},
                                          //   icon: Icon(
                                          //     Icons.add_circle,
                                          //     color: Colors.brown[600],
                                          //     size: 36,
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          // itemBuilder: (context, index) => MenuCardkomnitas_isi(
                          //       menu_umkm: menu_umkm[index],
                          //       press2: () => Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) => DetailVerifikasi(
                          //               daftarkmunitas: index,
                          //             ),
                          //           )),
                          //     )),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget buildSearch() {
    final styleActive = GoogleFonts.roboto(color: Colors.black);
    final styleHint = GoogleFonts.roboto(color: Colors.black54);
    final style = query.isEmpty ? styleHint : styleActive;

    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            child: Icon(
              Icons.search,
              color: Color(0xFF18b15a),
            ),
            onTap: () {
              searchBook();
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
          hintText: 'Cari berdasarkan Nama UMKM',
          //  hintStyle: GoogleFonts.roboto(
          //             fontSize: 19,
          //             color: Colors.black87),
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        // onChanged: searchBook,
      ),
    );
  }

  void searchBook() {
    final list_buss_life = list_bussiness_life.where((anggota) {
      final titleLower = anggota.name.toLowerCase();
      // final authorLower = anggota.deskripsi.toLowerCase();
      final searchLower = controller.text.toLowerCase();

      return titleLower.contains(searchLower);
      // || authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = controller.text;
      this.list_buss_life = list_buss_life;
    });

    final list_buss_digital = list_bussiness_digital.where((anggota) {
      final titleLower = anggota.name.toLowerCase();
      // final authorLower = anggota.deskripsi.toLowerCase();
      final searchLower = controller.text.toLowerCase();

      return titleLower.contains(searchLower);
      // || authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = controller.text;
      this.list_buss_digital = list_buss_digital;
    });

    final list_buss_culture = list_bussiness_culture.where((anggota) {
      final titleLower = anggota.name.toLowerCase();
      // final authorLower = anggota.deskripsi.toLowerCase();
      final searchLower = controller.text.toLowerCase();

      return titleLower.contains(searchLower);
      // || authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = controller.text;
      this.list_buss_culture = list_buss_culture;
    });

    final list_buss_food = list_bussiness_food.where((anggota) {
      final titleLower = anggota.name.toLowerCase();
      // final authorLower = anggota.deskripsi.toLowerCase();
      final searchLower = controller.text.toLowerCase();

      return titleLower.contains(searchLower);
      // || authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = controller.text;
      this.list_buss_food = list_buss_food;
    });
  }
}
