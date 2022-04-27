import 'dart:convert';
import 'dart:io';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digipark/0lainlain/modal.dart';
import 'package:digipark/skeleton/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/handlinginet.dart';
import 'halaman_detail_komunitas.dart';

const String title = "Digipark";

class HalamanKomunitas extends StatefulWidget {
  @override
  _HalamanKomunitasState createState() => _HalamanKomunitasState();
}

class _HalamanKomunitasState extends State<HalamanKomunitas> {
  List<CommunityModal> list_community_sport = [];
  List<CommunityModal> list_community_art = [];
  List<CommunityModal> list_community_social = [];
  List<CommunityModal> list_community_entre = [];

  List<CommunityModal> list_com_sp = [];
  List<CommunityModal> list_com_ar = [];
  List<CommunityModal> list_com_so = [];
  List<CommunityModal> list_com_en = [];

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
      list_community_sport.clear();
      list_community_social.clear();
      list_community_art.clear();
      list_community_entre.clear();

      setState(() {
        loading = true;
      });

      //Sport
      final response5 = await http.get(
          Uri.http('digiadministrator.falaraborneo.com',
              'api/v2/user/community/list'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            // "phone": phone_number,
          });
      if (response5.contentLength == 2) {
      } else {
        final data = jsonDecode(response5.body);
        // print(data);
        // String message = data['meta']['message'];
        // print(message);
        data['data'].forEach((api) {
          final ab = new CommunityModal(
            api['id'],
            api['uuid'],
            api['community_category_uuid'],
            api['name'],
            api['logo_path'],
            api['address'],
            api['city'],
            api['province'],
            api['description'],
            api['image_path'],
            api['location'],
            api['facebook'],
            api['instagram'],
            api['youtube'],
            api['status'],
            api['created_at'],
            api['updated_at'],
            api['path'],
          );
          if (ab.community_category_uuid ==
              'b4c51f95-8f63-428c-90e6-4f41814afdc8') {
            list_community_sport.add(ab);
          }
          if (ab.community_category_uuid ==
              '03f29401-6c6f-42a6-95c3-930fb9827b5e') {
            list_community_social.add(ab);
          }
          if (ab.community_category_uuid ==
              'ac463245-a819-4a50-9d58-35926ba2ca33') {
            list_community_art.add(ab);
          }
          if (ab.community_category_uuid ==
              '91e4cdb0-86d4-4aa1-b727-a95935baa5fe') {
            list_community_entre.add(ab);
          }
          // _search_community.add(ab);
        });
        print(data['data']);
        setState(() {
          loading = false;
        });
      }

      // //Social Culture
      // final response2 = await http.get(
      //     Uri.http('digiadministrator.falaraborneo.com',
      //         'api/v2/user/community/list'),
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
      //     final ab = new CommunityModal(
      //       api['id'],
      //       api['uuid'],
      //       api['community_category_uuid'],
      //       api['name'],
      //       api['logo_path'],
      //       api['address'],
      //       api['city'],
      //       api['province'],
      //       api['description'],
      //       api['image_path'],
      //       api['location'],
      //       api['facebook'],
      //       api['instagram'],
      //       api['youtube'],
      //       api['status'],
      //       api['created_at'],
      //       api['updated_at'],
      //       api['path'],
      //     );
      //     if (ab.community_category_uuid ==
      //         '03f29401-6c6f-42a6-95c3-930fb9827b5e') {
      //       list_community_social.add(ab);
      //     }

      //     // _search_community.add(ab);
      //   });
      //   print(data['data']);
      //   setState(() {
      //     loading = false;
      //   });
      // }

      // //Entrepreneur
      // final response3 = await http.get(
      //     Uri.http('digiadministrator.falaraborneo.com',
      //         'api/v2/user/community/list'),
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
      //     final ab = new CommunityModal(
      //       api['id'],
      //       api['uuid'],
      //       api['community_category_uuid'],
      //       api['name'],
      //       api['logo_path'],
      //       api['address'],
      //       api['city'],
      //       api['province'],
      //       api['description'],
      //       api['image_path'],
      //       api['location'],
      //       api['facebook'],
      //       api['instagram'],
      //       api['youtube'],
      //       api['status'],
      //       api['created_at'],
      //       api['updated_at'],
      //       api['path'],
      //     );
      //     if (ab.community_category_uuid ==
      //         '91e4cdb0-86d4-4aa1-b727-a95935baa5fe') {
      //       list_community_entre.add(ab);
      //     }

      //     // _search_community.add(ab);
      //   });
      //   print(data['data']);
      //   setState(() {
      //     loading = false;
      //   });
      // }

      // //Art & Digital
      // final response4 = await http.get(
      //     Uri.http('digiadministrator.falaraborneo.com',
      //         'api/v2/user/community/list'),
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
      //     final ab = new CommunityModal(
      //       api['id'],
      //       api['uuid'],
      //       api['community_category_uuid'],
      //       api['name'],
      //       api['logo_path'],
      //       api['address'],
      //       api['city'],
      //       api['province'],
      //       api['description'],
      //       api['image_path'],
      //       api['location'],
      //       api['facebook'],
      //       api['instagram'],
      //       api['youtube'],
      //       api['status'],
      //       api['created_at'],
      //       api['updated_at'],
      //       api['path'],
      //     );
      //     if (ab.community_category_uuid ==
      //         'ac463245-a819-4a50-9d58-35926ba2ca33') {
      //       list_community_art.add(ab);
      //     }

      //     // _search_community.add(ab);
      //   });
      //   print(data['data']);
      //   setState(() {
      //     loading = false;
      //   });
      // }

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

    list_com_en = list_community_entre;
    list_com_ar = list_community_art;
    list_com_sp = list_community_sport;
    list_com_so = list_community_social;
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
            child: Text("Palangka Raya Wisata Komunitas",
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
                          icon: Icon(LineIcons.basketballBall),
                          text: "Sport ",
                        ),
                        Tab(
                          icon: Icon(LineIcons.digitalTachograph),
                          text: "Art & Digital ",
                        ),
                        Tab(
                          icon: Icon(LineIcons.userFriends),
                          text: "Social Culture ",
                        ),
                        Tab(
                          icon: Icon(LineIcons.businessTime),
                          text: "Entrepreneur ",
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: <Widget>[
                          sport(),
                          art(),
                          social(),
                          entre(),
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

  Widget sport() {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Color(0xFFFFC600),
        onRefresh: tampil_data,
        child: loading
            ? buildSkeletonMenu(context)
            : list_com_sp.length == 0
                ? ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(
                            top: size.height * 0.22,
                            bottom: size.height * 0.02,
                          ),
                          child: Text(
                              "Tidak ada Komunitas\nPalangka Raya yang dicari",
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
                              itemCount: list_com_sp.length,
                              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //   crossAxisCount: 3,
                              //   mainAxisSpacing: 12,
                              //   crossAxisSpacing: 15,
                              //   childAspectRatio: 0.60,
                              // ),
                              itemBuilder: (context, i) {
                                final x = list_com_sp[i];
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
                                                        DetailKomunitas(
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
                                                          "http://digiadministrator.falaraborneo.com/" +
                                                              x.path,
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
                          //       menu_komunitas: menu_komunitas[index],
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

  Widget art() {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Color(0xFFFFC600),
        onRefresh: tampil_data,
        child: loading
            ? buildSkeletonMenu(context)
            : list_com_ar.length == 0
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
                              "Tidak ada Komunitas\nPalangka Raya yang dicari",
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
                              itemCount: list_com_ar.length,
                              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //   crossAxisCount: 3,
                              //   mainAxisSpacing: 12,
                              //   crossAxisSpacing: 15,
                              //   childAspectRatio: 0.60,
                              // ),
                              itemBuilder: (context, i) {
                                final x = list_com_ar[i];
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
                                                        DetailKomunitas(
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
                                                          "http://digiadministrator.falaraborneo.com/" +
                                                              x.path,
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
                          //       menu_komunitas: menu_komunitas[index],
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

  Widget social() {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Color(0xFFFFC600),
        onRefresh: tampil_data,
        child: loading
            ? buildSkeletonMenu(context)
            : list_com_so.length == 0
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
                              "Tidak ada Komunitas\nPalangka Raya yang dicari",
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
                              itemCount: list_com_so.length,
                              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //   crossAxisCount: 3,
                              //   mainAxisSpacing: 12,
                              //   crossAxisSpacing: 15,
                              //   childAspectRatio: 0.60,
                              // ),
                              itemBuilder: (context, i) {
                                final x = list_com_so[i];
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
                                                        DetailKomunitas(
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
                                                          "http://digiadministrator.falaraborneo.com/" +
                                                              x.path,
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
                          //       menu_komunitas: menu_komunitas[index],
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

  Widget entre() {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Color(0xFFFFC600),
        onRefresh: tampil_data,
        child: loading
            ? buildSkeletonMenu(context)
            : list_com_en.length == 0
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
                              "Tidak ada Komunitas\nPalangka Raya yang dicari",
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
                              itemCount: list_com_en.length,
                              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //   crossAxisCount: 3,
                              //   mainAxisSpacing: 12,
                              //   crossAxisSpacing: 15,
                              //   childAspectRatio: 0.60,
                              // ),
                              itemBuilder: (context, i) {
                                final x = list_com_en[i];
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
                                                        DetailKomunitas(
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
                                                          "http://digiadministrator.falaraborneo.com/" +
                                                              x.path,
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
                          //       menu_komunitas: menu_komunitas[index],
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
          hintText: 'Cari berdasarkan Nama komunitas',
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
    final list_com_sp = list_community_sport.where((anggota) {
      final titleLower = anggota.name.toLowerCase();
      // final authorLower = anggota.deskripsi.toLowerCase();
      final searchLower = controller.text.toLowerCase();

      return titleLower.contains(searchLower);
      // || authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = controller.text;
      this.list_com_sp = list_com_sp;
    });

    final list_com_ar = list_community_art.where((anggota) {
      final titleLower = anggota.name.toLowerCase();
      // final authorLower = anggota.deskripsi.toLowerCase();
      final searchLower = controller.text.toLowerCase();

      return titleLower.contains(searchLower);
      // || authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = controller.text;
      this.list_com_ar = list_com_ar;
    });

    final list_com_so = list_community_social.where((anggota) {
      final titleLower = anggota.name.toLowerCase();
      // final authorLower = anggota.deskripsi.toLowerCase();
      final searchLower = controller.text.toLowerCase();

      return titleLower.contains(searchLower);
      // || authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = controller.text;
      this.list_com_so = list_com_so;
    });

    final list_com_en = list_community_entre.where((anggota) {
      final titleLower = anggota.name.toLowerCase();
      // final authorLower = anggota.deskripsi.toLowerCase();
      final searchLower = controller.text.toLowerCase();

      return titleLower.contains(searchLower);
      // || authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = controller.text;
      this.list_com_en = list_com_en;
    });
  }
}
