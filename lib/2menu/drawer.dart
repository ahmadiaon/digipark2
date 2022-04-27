import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digipark/0lainlain/modal.dart';
import 'package:digipark/2menu/sidebar_profil_saya.dart';
import 'package:digipark/customdialog/CustomDialogLogout.dart';
import 'package:digipark/env.dart';
import 'package:digipark/skeleton/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../7bank/halaman_daftar_jasa_keuangan.dart';
import '../widgets/handlinginet.dart';

String username = "";

class Drawer_siderbar extends StatefulWidget {
  final VoidCallback signOut;
  const Drawer_siderbar({Key key, this.signOut}) : super(key: key);
  @override
  Drawer_siderbarState createState() => Drawer_siderbarState();
}

class Drawer_siderbarState extends State<Drawer_siderbar> {
  String uuid, token, role, txt_avatar = "";
  File _imageFile_avatar;
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  showAlertDialogKeluar() {
    showDialog(
        context: context,
        builder: (context) => CustomDialogLogout(
            judul: "Logout",
            deskripsi: "Yakin ingin keluar dari akun ini?",
            gambar: Image.asset("assets/icons/logout.png"),
            signOut: signOut));
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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

  List<ProfilModal> _list_profil = [];
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      uuid = preferences.getString("uuid");
      role = preferences.getString("role");
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
      _list_profil.clear();
      setState(() {
        loading = true;
      });
      final response = await http.get(
          Uri.http(URL,
              'api/v2/user/profile/' + uuid),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      datanya = json.decode(response.body);
      if (datanya.length == 0) {
      } else {
        setState(() {
          print('berhasil');
          print(datanya['data']['name']);
          print(datanya['data']['photo_path']);
          txt_avatar = datanya['data']['photo_path'];
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
    print(role);
    tampil_data();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFFFFC600),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/digipark0.jpg'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.26,
                    height: MediaQuery.of(context).size.width * 0.26,
                    margin: EdgeInsets.only(
                      top: 40,
                      bottom: 15,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(55),
                      child: txt_avatar == ""
                          ? Image.asset(
                              "assets/images/1gambar.jpg",
                              fit: BoxFit.cover,
                            )
                          : txt_avatar == null
                              ? Image.asset(
                                  "assets/images/1gambar.jpg",
                                  fit: BoxFit.cover,
                                )
                              : CachedNetworkImage(
                                  imageUrl:
                                      URL_HTTP +
                                          txt_avatar,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          buildSkeletonDrawer(context),
                                  // placeholder: (context, url) =>
                                  //     buildSkeletonDrawer(context),
                                  errorWidget: (context, url, error) =>
                                      buildSkeletonDrawer(context),
                                  fit: BoxFit.cover,
                                ),
                    ),
                  ),
                  // Text(
                  //   txtNama == "" ? "Digipark" : txtNama,
                  //   textAlign:TextAlign.start,
                  //   style: TextStyle(fontSize: 22, color: Color(0xFF18b15a),),
                  // ),
                  // Text(
                  //   txtNohp == "" ? "Creative Hub" : txtNohp,
                  //   style: TextStyle(color: Color(0xFF18b15a)),
                  // ),
                  // Text(username, style: TextStyle( color: Colors.white),),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person_outlined,
                color: Color(0xFF3d3d3d),
              ),
              title: Text(
                'Profil Saya',
                style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Color(0xFF3d3d3d),
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SideBarProfilSaya()));
                // Navigator.of(context).pushNamed(DetailScreen.routeName);
              },
            ),
            role == 'admin'
                ? ListTile(
                    leading: Icon(
                      LineIcons.university,
                      color: Color(0xFF3d3d3d),
                    ),
                    title: Text(
                      'Data Jasa Keuangan',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Color(0xFF3d3d3d),
                          fontWeight: FontWeight.w400),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MenuJasaKeuangan()));
                      // Navigator.of(context).pushNamed(DetailScreen.routeName);
                    },
                  )
                : Container(),
            ListTile(
              leading: Icon(
                Icons.phone,
                color: Color(0xFF3d3d3d),
              ),
              title: Text(
                'Emergency Call',
                style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Color(0xFF3d3d3d),
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.of(context).pop();
                _makePhoneCall('tel:112');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.report_problem_outlined,
                color: Color(0xFF3d3d3d),
              ),
              title: Text(
                'Pelaporan Layanan Publik',
                style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Color(0xFF3d3d3d),
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.of(context).pop();
                openApp(url: 'https://www.lapor.go.id/', inApp: false);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.info_outline,
                color: Color(0xFF3d3d3d),
              ),
              title: Text(
                'Tentang',
                style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Color(0xFF3d3d3d),
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.of(context).pop();
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => UbahPassword()));
                //Navigator.of(context).pushNamed(DetailScreen.routeName);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout_outlined,
                color: Color(0xFF3d3d3d),
              ),
              title: Text(
                'Logout',
                style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Color(0xFF3d3d3d),
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                showAlertDialogKeluar();
                // Navigator.of(context).pop();
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MediaSosial()));
                //Navigator.of(context).pushNamed(DetailScreen.routeName);
              },
            ),
            // ListTile(
            //   leading: Icon(FontAwesome5Solid.video),
            //   title: Text('Pantau CCTV', style: TextStyle(fontSize: 18, color: Colors.grey[600]),),
            //   onTap: (){
            //     Navigator.of(context).pop();
            //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => PantauCCTV()));
            //     //Navigator.of(context).pushNamed(DetailScreen.routeName);
            //   },
            // ),
            // ListTile(
            //   leading: Icon(FontAwesome5Solid.mobile_alt),
            //   title: Text('Tentang Aplikasi', style: TextStyle(fontSize: 18, color: Colors.grey[600]),),
            //   onTap: (){
            //     Navigator.of(context).pop();
            //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => Tentang()));
            //     //Navigator.of(context).pushNamed(DetailScreen.routeName);
            //   },
            // ),
            // SizedBox(height: MediaQuery.of(context).size.height * 0.12,),
            // ListTile(
            //   leading: Icon(FontAwesome5Solid.sign_out_alt),
            //   title: Text('Logout', style: TextStyle(fontSize: 18, color: Colors.grey[600]),),
            //   onTap: (){
            //     showAlertDialog();
            //     //Navigator.of(context).pushNamed(DetailScreen.routeName);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
