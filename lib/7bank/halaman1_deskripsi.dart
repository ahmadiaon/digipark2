import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../env.dart';
import '../skeleton/skeleton.dart';
import '../widgets/handlinginet.dart';
import 'halaman1_ubah.dart'; 

class BankDeskripsi extends StatefulWidget {
  const BankDeskripsi({Key key}) : super(key: key);

  @override
  State<BankDeskripsi> createState() => _BankDeskripsiState();
}

class _BankDeskripsiState extends State<BankDeskripsi> {
  // LoginStatus _loginStatus = LoginStatus.notSignIn;

  String role_uuid,
      token,
      name = "",
      address = "",
      description = "",
      location = "",
      facebook = "",
      instagram = "",
      youtube = "";
  launchURL(String url) async {
    // const String homeLat = "37.3230";
    // const String homeLng = "-122.0312";

    final String googleMapslocationUrl = url;

    final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

    if (await canLaunch(encodedURl)) {
      await launch(encodedURl);
    } else {
      print('Could not launch $encodedURl');
      throw 'Could not launch $encodedURl';
    }
  }

  Future openApp({String url, bool inApp = false}) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: inApp,
        forceWebView: inApp,
        enableJavaScript: true,
      );
    }
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      role_uuid = preferences.getString("role_uuid");
    });
    //_lihatData();
  }

  var datanya;
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
      setState(() {
        loading = true;
      });
      final response = await http.get(
          Uri.http(URL,
              'api/v2/user/detail-data-financial/' + role_uuid),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      datanya = json.decode(response.body);
      if (datanya.length == 0) {
      } else {
        setState(() {
          name = datanya['data']['name'];
          address = datanya['data']['address'];
          description = datanya['data']['description'];
          location = datanya['data']['location'];
          facebook = datanya['data']['facebook'];
          instagram = datanya['data']['instagram'];
          youtube = datanya['data']['youtube'];
        });

        setState(() {
          loading = false;
        });
      }
      print('Token : ${token}');
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HandlingInet(tampil_data: tampil_data)));
    }
  }

  @override
  void initState() {
    getPref();
    tampil_data();
  }

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
                builder: (context) => BankDeskripsiUbah(role_uuid, tampil_data )));
          },
          label: Text(
            'Ubah Profil',
            style: GoogleFonts.roboto(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
          icon: Icon(
            LineIcons.editAlt,
            color: Colors.black87,
          ),
          backgroundColor: Color(0xFFFFC600),
        ),
      ),
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Color(0xFFFFC600),
        onRefresh: tampil_data,
        child: loading
            ? buildSkeletonDetailBank(context)
            : ListView(
                children: [
                  Container(
                    // margin: EdgeInsets.only(top: size.height * 0.3),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SelectableText(
                            name,
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                height: 1.5,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            width: size.width * 0.38,
                            height: size.height * 0.005,
                            decoration: BoxDecoration(
                                color: Color(0xFFFFC600),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          SizedBox(
                            height: size.height * 0.0235,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(3)),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                address,
                                style: GoogleFonts.inter(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          location == ""
                              ? Container()
                              : RaisedButton.icon(
                                  onPressed: () {
                                    launchURL(location);
                                  },
                                  icon: Icon(
                                    LineIcons.mapMarked,
                                    color: Colors.black87,
                                  ),
                                  label: Text(
                                    "Lihat di Peta",
                                    style: GoogleFonts.roboto(
                                        color: Colors.black87,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  ),
                                  color: Color(0xFFFFC600),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          SelectableText(
                            description,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.inter(height: 1.6),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          youtube == "" && instagram == "" && facebook == ""
                              ? Container()
                              : SelectableText(
                                  'Media Sosial',
                                  style: GoogleFonts.inter(
                                      fontSize: 17,
                                      height: 1.5,
                                      fontWeight: FontWeight.bold),
                                ),
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                          Row(
                            children: [
                              instagram == ""
                                  ? Container()
                                  : Expanded(
                                      child: RaisedButton.icon(
                                        onPressed: () {
                                          openApp(url: instagram, inApp: false);
                                        },
                                        icon: Icon(
                                          LineIcons.instagram,
                                          color: Colors.black87,
                                        ),
                                        label: Text(
                                          "Instagram",
                                          style: GoogleFonts.roboto(
                                              color: Colors.black87,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ),
                                        color: Color(0xFFFFC600),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                    ),
                              youtube == ""
                                  ? Container()
                                  : instagram == ""
                                      ? Container()
                                      : SizedBox(
                                          width: size.width * 0.02,
                                        ),
                              youtube == ""
                                  ? Container()
                                  : Expanded(
                                      child: RaisedButton.icon(
                                        onPressed: () {
                                          openApp(url: youtube, inApp: false);
                                        },
                                        icon: Icon(
                                          LineIcons.youtube,
                                          color: Colors.black87,
                                        ),
                                        label: Text(
                                          "Youtube",
                                          style: GoogleFonts.roboto(
                                              color: Colors.black87,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ),
                                        color: Color(0xFFFFC600),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                    ),
                            ],
                          ),
                          // SizedBox(
                          //   height: size.height * 0.02,
                          // ),
                          Row(
                            children: [
                              facebook == ""
                                  ? Container()
                                  : Expanded(
                                      child: RaisedButton.icon(
                                        onPressed: () {
                                          openApp(url: facebook, inApp: false);
                                        },
                                        icon: Icon(
                                          LineIcons.facebookSquare,
                                          color: Colors.black87,
                                        ),
                                        label: Text(
                                          "Facebook",
                                          style: GoogleFonts.roboto(
                                              color: Colors.black87,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ),
                                        color: Color(0xFFFFC600),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.06,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
