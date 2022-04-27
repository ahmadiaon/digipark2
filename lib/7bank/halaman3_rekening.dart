import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:digipark/0lainlain/modal.dart';
import 'package:digipark/customdialog/CustomDialog.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../skeleton/skeleton.dart';
import '../widgets/handlinginet.dart';

class BankRekening extends StatefulWidget {
  const BankRekening({Key key}) : super(key: key);

  @override
  State<BankRekening> createState() => _BankRekeningState();
}

class _BankRekeningState extends State<BankRekening> {
  List<ListRegisterBank> list_register = [];
  List<ListRegisterBank> list_reg = [];
  String query = '', role_uuid, token;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      role_uuid = preferences.getString("role_uuid");
    });
  }

  showAlertDialogTerdaftar() {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              judul: "File Sudah Terdownload",
              deskripsi: "File yg didownload sudah ada pada file manager",
              gambar: Image.asset("assets/icons/failed.png"),
            ));
  }

  Future download(String url) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final baseStorage = await getExternalStorageDirectory();

      await FlutterDownloader.enqueue(
        url: url, 
        saveInPublicStorage: true,
        savedDir: baseStorage.path,
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
    }
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
      list_register.clear();
      setState(() {
        loading = true;
      });

      final response2 = await http.get(
          Uri.http('digiadministrator.falaraborneo.com',
              'api/v2/user/financial-registers/' + role_uuid),
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
          final ab = new ListRegisterBank(
            api['id'],
            api['uuid'],
            api['financial_service_uuid'],
            api['user_uuid'],
            api['name'],
            api['address'],
            api['phone_number'],
            api['email'],
            api['profession'],
            api['status'],
            api['created_at'],
            api['updated_at'],
            api['pdf'],
          );
          list_register.add(ab);
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

  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    getPref();
    tampil_data();
    list_reg = list_register;

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      if (status == DownloadTaskStatus.failed) {
        showAlertDialogTerdaftar();
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // floatingActionButton: Container(
      //   height: size.height * 0.05,
      //   child: FloatingActionButton.extended(
      //     // splashColor: Colors.green,
      //     onPressed: () async {
      //       download(
      //           'http://digiadministrator.falaraborneo.com/images/pdf/2022-03-19-12-22-36-Bank-Kalteng.pdf');
      //     },
      //     label: Text(
      //       'Unduh Data',
      //       style: GoogleFonts.roboto(
      //           color: Colors.black87,
      //           fontSize: 16,
      //           fontWeight: FontWeight.w700),
      //     ),
      //     icon: Icon(
      //       LineIcons.fileDownload,
      //       color: Colors.black87,
      //     ),
      //     backgroundColor: Color(0xFFFFC600),
      //   ),
      // ),
      // Provide the [TabController]
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.021,
          ),
          Align(
            alignment: Alignment.center,
            child: Text("Daftar Pembukaan Rekening",
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
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
          child: RefreshIndicator(
            backgroundColor: Colors.white,
            color: Color(0xFFFFC600),
            onRefresh: tampil_data,
            key: _refresh,
            child: loading
                ? buildSkeletonBankRekening(context)
                : list_reg.isEmpty
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
                                  "Tidak ada daftar pembukaan\nrekening yang dicari",
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
                        itemCount: list_reg.length,
                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //   crossAxisCount: 3,
                        //   mainAxisSpacing: 12,
                        //   crossAxisSpacing: 15,
                        //   childAspectRatio: 0.60,
                        // ),
                        itemBuilder: (context, i) {
                          final x = list_reg[i];
                          // final y = jsonDecode(x.image_path);
                          // final image = y[1];
                          // print(image);
                          return Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[100],
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        15.0,
                                        15.0,
                                        0.0,
                                        15.0,
                                      ),
                                      child: GestureDetector(
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
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  width: size.width * 0.69,
                                                  child: Text(
                                                    x.name,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.black87,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.006,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: size.width * 0.4,
                                                      child: Text(
                                                        x.profession,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          size.height * 0.005,
                                                    ),
                                                    SizedBox(
                                                      width: size.width * 0.28,
                                                      child: Text(
                                                        x.phone_number,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.006,
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.69,
                                                  child: Text(
                                                    x.email,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.006,
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.69,
                                                  child: Text(
                                                    x.address,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.roboto(
                                                        color:
                                                            Color(0xFF18b15a),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14),
                                                  ),
                                                )
                                              ],
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
                                                  icon: Icon(
                                                      LineIcons.fileDownload),
                                                  onPressed: () async {
                                                    download(
                                                        'http://digiadministrator.falaraborneo.com/' +
                                                            x.pdf);
                                                  },
                                                ), // icon-2
                                              ],
                                            ),
                                          ],
                                        ),
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
          hintText: 'Cari berdasarkan Nama ',
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
    final list_reg = list_register.where((anggota) {
      final titleLower = anggota.name.toLowerCase();
      // final authorLower = anggota.deskripsi.toLowerCase();
      final searchLower = controller.text.toLowerCase();

      return titleLower.contains(searchLower);
      // || authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = controller.text;
      this.list_reg = list_reg;
    });
  }
}
