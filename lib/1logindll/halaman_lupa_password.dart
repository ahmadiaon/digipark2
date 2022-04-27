import 'dart:convert';
import 'package:digipark/0lainlain/textinputdecor.dart';
import 'package:digipark/1logindll/halaman_login.dart';
import 'package:digipark/1logindll/halaman_otp.dart';
import 'package:digipark/2menu/menu_utama.dart';
import 'package:digipark/customdialog/CustomDialog.dart';
import 'package:digipark/env.dart';
import 'package:digipark/widgets/handlinginet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'halaman_awal.dart';
import 'halaman_daftar.dart';

String uuid = "";

class LupaPassword extends StatefulWidget {
  final String title;
  const LupaPassword({Key key, this.title}) : super(key: key);
  @override
  _LupaPasswordState createState() => _LupaPasswordState();
}

enum LoginStatus { notSignIn, signInAnggota, signInAdmin, signInSuperAdmin }

class _LupaPasswordState extends State<LupaPassword> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String email, password, token, role, role_uuid, phone_number;
  // String dataLevel = "Anggota";

  final _key = new GlobalKey<FormState>();

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  showAlertDialogGagalLogin() {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
            judul: "Gagal login",
            deskripsi: "Username atau password salah",
            gambar: Image.asset("assets/icons/failed.png")));
  }

  showAlertDialogTidakTerdaftar() {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              judul: "Tidak Terdaftar",
              deskripsi:
                  "Email atau No HP (WhatsApp) yang digunakan tidak terdaftar",
              gambar: Image.asset("assets/icons/failed.png"),
              check: check,
            ));
  }

  var otps, loading = false;
  login() async {
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
      final response = await http.post(
          Uri.http(
              URL, 'api/v2/user/checkEmail'),
          body: {"data": phone_number});
      final data = jsonDecode(response.body);
      if (data['meta']['message'] == "Email or Phone number doesn't match") {
        showAlertDialogTidakTerdaftar();
        setState(() {
          loading = false;
        });
      } else if (response.statusCode > 2) {
        otps = data['OTP'].toString();
        print(otps);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HalamanOtp(otps, phone_number)));
        print(" berhasil ");
        setState(() {
          loading = false;
        });
      } else {
        print(" failed");
        setState(() {
          loading = false;
        });
      }
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HandlingInet(tampil_data:login)));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(),
    );
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
                Colors.white.withOpacity(0.07), BlendMode.dstATop),
            image: new AssetImage(
              'assets/images/jembatan_kahayan.jpg',
            ),
          ),
        ),
        child: loading
            ? Center(
                heightFactor: 10,
                child: Container(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    valueColor: AlwaysStoppedAnimation(Colors.grey[
                        300]), // Defaults to the current Theme's accentColor.
                    backgroundColor: Color(
                        0xFF18b15a), // Defaults to the current Theme's backgroundColor.
                  ),
                ))
            : Form(
                key: _key,
                child: Stack(
                  children: <Widget>[
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8),
                              // margin: EdgeInsets.only(top: size.height * 0.1),
                              // width: 400,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.5),
                                // borderRadius: BorderRadius.only(
                                //   topLeft: Radius.circular(50.0),
                                //   topRight: Radius.circular(50.0),
                                // )
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back_rounded,
                                    color: Color(0xFF18b15a)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 90, 30, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            // width: size.height * 0.53,
                            height: size.height * 0.12,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/logo.png',
                                  ),
                                  fit: BoxFit.fitHeight),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.025,
                          ),
                          // Text("Masuk",
                          //     textAlign: TextAlign.left,
                          //     style: GoogleFonts.inter(
                          //         fontWeight: FontWeight.w900,
                          //         color: Colors.black87,
                          //         fontSize: 19)),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          Text(
                              "Silahkan masukkan Email atau No Handphone (WhatsApp) yang sudah terdaftar sebelumnya untuk mereset password",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  fontSize: 14.5)),
                          SizedBox(
                            height: size.height * 0.035,
                          ),
                          // Container(
                          //   height: 60,
                          //   child: DropdownButtonFormField(
                          //     style: GoogleFonts.inter(
                          //         color: Color(0xFF414141), fontSize: 17),
                          //     decoration: textInputDecoration.copyWith(
                          //         labelText: "Login Sebagai"),
                          //     value: dataLevel,
                          //     onChanged: (e) {
                          //       dataLevel = e;

                          //       print(dataLevel);
                          //     },
                          //     // onChanged: (e) {
                          //     //   dataLevel = e;
                          //     //   print(dataLevel);
                          //     // },
                          //     items: <String>[
                          //       'Anggota',
                          //       'Admin',
                          //       'Super Admin',
                          //       // 'Lain-lain'
                          //     ]
                          //         .map((dataLevel) => DropdownMenuItem(
                          //               child: Text(
                          //                 dataLevel,
                          //                 style: GoogleFonts.inter(
                          //                     color: Color(0xFF414141), fontSize: 16),
                          //               ),
                          //               value: dataLevel,
                          //             ))
                          //         .toList(),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: size.height * 0.035,
                          // ),
                          TextFormField(
                            style: GoogleFonts.inter(color: Color(0xFF414141)),
                            maxLength: 100,
                            validator: (e) {
                              if (e.length < 10 && e.length > 0) {
                                return "Masukkan minimal 10 karakter";
                              }
                              if (e.isEmpty) {
                                return "Email atau No Handphone (WhatsApp) kosong, silahkan masukkan";
                              }
                            },
                            onSaved: (e) => phone_number = e,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Email atau No Handphone (WhatsApp)",
                                hintText: "Maksimal 100 karakter"),
                          ),

                          SizedBox(
                            height: size.height * 0.025,
                          ),
                          Center(
                            child: SizedBox(
                              width: size.width * 0.99,
                              height: size.height * 0.055,
                              child: RaisedButton(
                                color: Color(0xFF18b15a),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                onPressed: () {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => MenuUtama()));

                                  setState(() {
                                    check();
                                  });
                                },
                                child: Text(
                                  "Masukkan",
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
                            height: size.height * 0.012,
                          ),
                          Align(
                            child: FlatButton(
                              child: Text("Punya akun?",
                                  style:
                                      GoogleFonts.inter(color: Colors.black87)),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HalamanLogin()));
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
