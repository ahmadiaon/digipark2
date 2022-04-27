import 'dart:convert';
import 'dart:io';  
import 'package:cached_network_image/cached_network_image.dart'; 
import 'package:digipark/0lainlain/modal.dart';
import 'package:digipark/env.dart';
import 'package:digipark/skeleton/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../widgets/handlinginet.dart';
import 'halaman_detail_bank.dart';

const String title = "";

class HalamanBank extends StatefulWidget {
  @override
  _HalamanBankState createState() => _HalamanBankState();
}

class _HalamanBankState extends State<HalamanBank> {
  List<FinancialModal> list_financial = [];
  List<FinancialModal> list_fina;
  // List<FinancialModal> _search_financial = [];
  String query = '', token = "";

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
    });
    //_lihatData();
  }

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
      list_financial.clear();
      setState(() {
        loading = true;
      });

      final response2 = await http.get(
          Uri.http(URL,
              'api/v2/user/financial-service/list'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            // "phone": phone_number,
          });
      if (response2.contentLength == 2) {
      } else {
        final data = jsonDecode(response2.body);
        // print(data);
        // String message = data['meta']['message'];
        // print(message);
        data['data'].forEach((api) {
          final ab = new FinancialModal(
            api['id'],
            api['uuid'],
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
          list_financial.add(ab);
          // _search_financial.add(ab);
        });
        print(data['data']);
        setState(() {
          loading = false;
        });
      }

      print(response2);
      // print("response");
    } else {
    Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HandlingInet(tampil_data:tampil_data)));
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
    tampil_data();
    list_fina = list_financial;
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
            child: Text("Jasa Keuangan",
                style: GoogleFonts.roboto(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87)),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          buildSearch(),
          Expanded(child: sport()),
        ],
      ),
    );
  }

  Widget sport() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
      child: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Color(0xFFFFC600),
        onRefresh: tampil_data,
        key: _refresh,
        child: loading
            ? buildSkeletonMenu(context)
            : list_fina.length == 0
                ? ListView( 
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(
                          top: size.height * 0.23,
                          bottom: size.height * 0.02,
                        ),
                        child: Text(
                            "Tidak ada Jasa Keuangan\nyang dicari",
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
                : ListView.builder(
                    itemCount: list_fina.length,
                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 3,
                    //   mainAxisSpacing: 12,
                    //   crossAxisSpacing: 15,
                    //   childAspectRatio: 0.60,
                    // ),
                    itemBuilder: (context, i) {
                      final x = list_fina[i];
                      return Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                        child: AspectRatio(
                          aspectRatio: size.height * 0.87 / size.height * 4,
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailBank(
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
                                              BorderRadius.circular(10),
                                          child: Container(
                                            color: Colors.grey[200],
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    URL_FULL +
                                                        x.path,
                                                //                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                // CircularProgressIndicator(value: downloadProgress.progress),
                                                placeholder: (context, url) =>
                                                    buildSkeletonListView(
                                                        context),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
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
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              x.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.roboto(
                                                  color: Colors.black87,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.006,
                                            ),
                                            Text(
                                              x.description,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 13,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            // SizedBox(
                                            //   height: size.height * 0.006,
                                            // ),
                                            // Text(
                                            //   komnitas_isi.alamat,
                                            //   maxLines: 2,
                                            //   overflow: TextOverflow.ellipsis,
                                            //   style: GoogleFonts.roboto(
                                            //       color: Color(0xFF18b15a),
                                            //       fontWeight: FontWeight.w500,
                                            //       fontSize: 10),
                                            // )
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
          hintText: 'Cari berdasarkan Nama jasa keuangan',
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
    final list_fina = list_financial.where((anggota) {
      final titleLower = anggota.name.toLowerCase();
      // final authorLower = anggota.deskripsi.toLowerCase();
      final searchLower = controller.text.toLowerCase();

      return titleLower.contains(searchLower);
      // || authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = controller.text;
      this.list_fina = list_fina;
    });
  }
}
