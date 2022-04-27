import 'dart:convert';
import 'package:digipark/2menu/menu_utama.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../env.dart';
import 'halaman_daftar.dart';
import 'halaman_login.dart';

const String title = "n";

class HalamanAwal extends StatefulWidget {
  HalamanAwal({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HalamanAwalState createState() => _HalamanAwalState();
}

enum LoginStatus { notSignIn, signInAnggota, signInAdmin, signInSuperAdmin }

class _HalamanAwalState extends State<HalamanAwal> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String email, password, token;
  var phone_number;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      phone_number = preferences.getString("phone_number");
      token = preferences.getString("token");
      _loginStatus = _loginStatus = phone_number == null
          ? LoginStatus.notSignIn
          : phone_number == ""
              ? LoginStatus.notSignIn
              : LoginStatus.signInAnggota;
    });
  }

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
      final response = await http.get(
          Uri.http(URL, 'api/v2/user/logout'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });
      print('object');
      print('Token : ${token}');

      // print("response");
    } else {
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => HandlingInet()));
    }
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("phone_number", "");
      preferences.setString("token", "");
      preferences.setString("uuid", "");
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
    tampil_data();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  DateTime backbuttonpressedTime;

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButton = backbuttonpressedTime == null ||
        currentTime.difference(backbuttonpressedTime) > Duration(seconds: 2);

    if (backButton) {
      backbuttonpressedTime = currentTime;
      Fluttertoast.showToast(
        msg: "Tekan kembali lagi untuk keluar",
      );
      return false;
    }
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // return Scaffold(body: WillPopScope(onWillPop: onWillPop, child: getBody()));
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          backgroundColor: Colors.white,
          body: WillPopScope(onWillPop: onWillPop, child: getBody()),
        );
        break;
      case LoginStatus.signInAnggota:
        return MenuUtama(signOut: signOut);
        break;

      case LoginStatus.signInAdmin:
        // return MenuUtama(signOut: signOut);
        break;

      case LoginStatus.signInSuperAdmin:
        // return MenuUtama(signOut: signOut);
        break;
    }
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height * 1,
        decoration: new BoxDecoration(
          color: Colors.white,
          image: new DecorationImage(
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.white.withOpacity(0.1), BlendMode.dstATop),
            image: new AssetImage(
              'assets/images/jembatan_kahayan.jpg',
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 30, left: 30),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // SizedBox(
              //   height: size.height * 0.17,
              // ),
              // Align(
              //   child: Text("Selamat datang di !",
              //       textAlign: TextAlign.center,
              //       style: GoogleFonts.inter(
              //           fontWeight: FontWeight.bold,
              //           color: Colors.black87,
              //           fontSize: 23)),
              // ),
              // SizedBox(
              //   height: size.height * 0.02,
              // ),
              Container(
                // width: size.height * 0.53,
                height: size.height * 0.15,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/logo.png',
                      ),
                      fit: BoxFit.fitHeight),
                ),
              ),
              SizedBox(
                height: size.height * 0.15,
              ),
              // Align(
              //   child: Text(
              //       "Aplikasi pendataan anggota partai PAN Kalimantan Tengah.  hadir untuk membantu menjawab persoalan dan tantangan di masa depan.",
              //       textAlign: TextAlign.center,
              //       style: GoogleFonts.inter(
              //           fontWeight: FontWeight.w400,
              //           color: Colors.black87,
              //           fontSize: 13.5)),
              // ),
              // SizedBox(
              //   height: size.height * 0.06,
              // ),
              Center(
                child: SizedBox(
                  width: size.width * 0.75,
                  height: size.height * 0.055,
                  child: RaisedButton(
                    color: Color(0xFF18b15a),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HalamanLogin()));
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Center(
                child: SizedBox(
                  width: size.width * 0.75,
                  height: size.height * 0.055,
                  child: RaisedButton(
                    color: Colors.white.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFF18b15a)),
                        borderRadius: BorderRadius.circular(50)),
                    // color: Color(0xFFd8f42f),
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(50)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HalamanDaftar()));
                    },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.inter(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.33,
              ),
              Align(
                child: FlatButton(
                  child: Text("Created by Palangka Raya Wisata Komunitas 2021",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(color: Colors.black87)),
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => MenuPengunjung()));
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
