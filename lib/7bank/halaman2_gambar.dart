import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digipark/0lainlain/modal.dart';
import 'package:digipark/customdialog/CustomDialog.dart';
import 'package:digipark/customdialog/CustomDialogSimpanProfil.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../skeleton/skeleton.dart';
import '../widgets/handlinginet.dart';
import 'halaman2_tambah.dart';

class BankGambar extends StatefulWidget {
  const BankGambar({Key key}) : super(key: key);

  @override
  State<BankGambar> createState() => _BankGambarState();
}

class _BankGambarState extends State<BankGambar> {
  List<SlideAdminBank> list_slide_admin = [];
  List<SlideAdminBank> list_sld = [];
  String query = '', role_uuid, token;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      role_uuid = preferences.getString("role_uuid");
    });
  }

  var loading = false;
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  Future<void> tampil_data() async {
    print(role_uuid);
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
      list_slide_admin.clear();
      setState(() {
        loading = true;
      });

      final response2 = await http.get(
          Uri.http('digiadministrator.falaraborneo.com',
              'api/v2/user/financial/slide/' + role_uuid),
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
          final ab = new SlideAdminBank(
            api['id'],
            api['uuid'],
            api['name'],
            api['is_url'],
            api['url'],
            api['path'],
            api['mime_type'],
            api['status'],
            api['created_at'],
            api['updated_at'],
          );
          list_slide_admin.add(ab);
        });
        print(data['data']);
        setState(() {
          loading = false;
        });
      }

      print(response2);
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
    list_sld = list_slide_admin;
  }

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Container(
        height: size.height * 0.05,
        child: FloatingActionButton.extended(
          // splashColor: Colors.green,
          onPressed: () async {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    BankGambarTambah(role_uuid, tampil_data)));
          },
          label: Text(
            'Tambah Gambar',
            style: GoogleFonts.roboto(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
          icon: Icon(
            LineIcons.plus,
            color: Colors.black87,
          ),
          backgroundColor: Color(0xFFFFC600),
        ),
      ),
      // Provide the [TabController]
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.021,
          ),
          Align(
            alignment: Alignment.center,
            child: Text("Gambar Slide Jasa Keuangan",
                style: GoogleFonts.roboto(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87)),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          buildSearch(),
          sport(),
        ],
      ),
    );
  }

  Widget sport() {
    var size = MediaQuery.of(context).size;
    return Container(
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
          child: RefreshIndicator(
            backgroundColor: Colors.white,
            color: Color(0xFFFFC600),
            onRefresh: tampil_data,
            key: _refresh,
            child: loading
                ? buildSkeletonMenu(context)
                : list_sld.isEmpty
                    ? ListView(
                        // physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(
                                top: size.height * 0.23,
                                bottom: size.height * 0.02,
                              ),
                              child: Text(
                                  "Tidak ada Gambar Slide\nJasa Keuangan yang dicari",
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
                        itemCount: list_sld.length,
                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //   crossAxisCount: 3,
                        //   mainAxisSpacing: 12,
                        //   crossAxisSpacing: 15,
                        //   childAspectRatio: 0.60,
                        // ),
                        itemBuilder: (context, i) {
                          final x = list_sld[i];
                          // final y = jsonDecode(x.image_path);
                          // final image = y[1];
                          // print(image);
                          return Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 5, 0, 10),
                            child: AspectRatio(
                              aspectRatio: size.height * 0.87 / size.height * 4,
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           DetailWisata(
                                        //         x,
                                        //       ),
                                        //     ));
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
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "http://digiadministrator.falaraborneo.com/" +
                                                          x.path,
                                                  fit: BoxFit.cover,
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
                                          SizedBox(
                                            width: size.width * 0.025,
                                          ),
                                          AspectRatio(
                                            aspectRatio: size.height *
                                                0.65 /
                                                size.height *
                                                1.7,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  x.name,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.roboto(
                                                      color: Colors.black87,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                                // SizedBox(
                                                //   height: size.height * 0.006,
                                                // ),
                                                // Text(
                                                //   x.description,
                                                //   maxLines: 3,
                                                //   overflow:
                                                //       TextOverflow.ellipsis,
                                                //   style: GoogleFonts.roboto(
                                                //       fontSize: 13,
                                                //       color: Colors.black87,
                                                //       fontWeight:
                                                //           FontWeight.w500),
                                                // ),
                                                // SizedBox(
                                                //   height: size.height * 0.006,
                                                // ),
                                                // Text(
                                                //   x.address,
                                                //   maxLines: 2,
                                                //   overflow:
                                                //       TextOverflow.ellipsis,
                                                //   style: GoogleFonts.roboto(
                                                //       color: Color(0xFF18b15a),
                                                //       fontWeight:
                                                //           FontWeight.w500,
                                                //       fontSize: 10),
                                                // )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              // Expanded(
                                              //   child: IconButton(
                                              //     icon:
                                              //         Icon(Icons.edit_outlined),
                                              //     onPressed: () {
                                              //       // Navigator.push(
                                              //       //     context,
                                              //       //     MaterialPageRoute(
                                              //       //         builder: (context) =>
                                              //       //             EditBeritaAdmin(x,
                                              //       //                 _lihatData)));
                                              //     },
                                              //   ),
                                              // ), // icon-1
                                              IconButton(
                                                icon:
                                                    Icon(Icons.delete_outline),
                                                onPressed: () {
                                                  Future<void> delete() async {
                                                    var koneksi;
                                                    try {
                                                      final result =
                                                          await InternetAddress
                                                              .lookup(
                                                                  'google.com');
                                                      if (result.isNotEmpty &&
                                                          result[0]
                                                              .rawAddress
                                                              .isNotEmpty) {
                                                        print('connected');
                                                        koneksi = 1;
                                                      }
                                                    } on SocketException catch (_) {
                                                      print('not connected');
                                                      koneksi = 0;
                                                    }

                                                    if (koneksi == 1) {
                                                      var uri = Uri.parse(
                                                          'http://digiadministrator.falaraborneo.com/api/v2/user/financial-slide/' +
                                                              role_uuid +
                                                              '/delete');
                                                      var request =
                                                          http.MultipartRequest(
                                                              "POST", uri);
                                                      request.fields[
                                                              'gallery_uuid'] =
                                                          x.uuid;
                                                      request.headers[
                                                              "Authorization"] =
                                                          'Bearer $token';
                                                      var response =
                                                          await request.send();
                                                      if (response.statusCode >
                                                          2) {
                                                        print("image upload");

                                                        // Navigator.pop(context);
                                                        showAlertDialogMendaftar() {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      CustomDialog(
                                                                        judul:
                                                                            "Gambar slide",
                                                                        deskripsi:
                                                                            "Gambar slide berhasil dihapus",
                                                                        gambar:
                                                                            Image.asset("assets/icons/verif.png"),
                                                                      ));
                                                        }

                                                        showAlertDialogMendaftar();
                                                        tampil_data();
                                                        print(
                                                            "Anda berhasil terdaftar ");
                                                      } else {
                                                        print("image failed");
                                                      }
                                                    } else {
                                                      // Navigator.of(context)
                                                      //     .push(MaterialPageRoute(builder: (context) => HandlingInet()));
                                                    }
                                                  }

                                                  showAlertDialogMendaftar() {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            CustomDialogSimpanProfil(
                                                              judul:
                                                                  "Gambar slide",
                                                              deskripsi:
                                                                  "Yakin hapus gambar slide ini?",
                                                              gambar: Image.asset(
                                                                  "assets/icons/failed.png"),
                                                              check: delete,
                                                            ));
                                                  }

                                                  showAlertDialogMendaftar();
                                                  // showDialog(
                                                  //     context: context,
                                                  //     builder: (context) =>
                                                  //         CustomDialogHapusBerita(
                                                  //           judul: "Hapus",
                                                  //           deskripsi:
                                                  //               "Yakin hapus berita ini?",
                                                  //           gambar: Image.asset(
                                                  //               "assets/icons/delete.png"),
                                                  //         ));
                                                },
                                              ), // icon-2
                                            ],
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
          // itemBuilder: (context, index) => MenuCardkomnitas_isi(
          //       menu_wisata: menu_wisata[index],
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
          hintText: 'Cari berdasarkan Nama Gambar Slide',
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
    final list_sld = list_slide_admin.where((anggota) {
      final titleLower = anggota.name.toLowerCase();
      // final authorLower = anggota.deskripsi.toLowerCase();
      final searchLower = controller.text.toLowerCase();

      return titleLower.contains(searchLower);
      // || authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = controller.text;
      this.list_sld = list_sld;
    });
  }
}
