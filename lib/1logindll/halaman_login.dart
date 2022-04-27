import 'dart:convert';
import 'package:digipark/0lainlain/textinputdecor.dart';
import 'package:digipark/2menu/menu_utama.dart';
import 'package:digipark/customdialog/CustomDialog.dart';
import 'package:digipark/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'halaman_awal.dart';
import 'halaman_daftar.dart';
import 'halaman_lupa_password.dart';

const String title = "n";
String uuid = "";

class HalamanLogin extends StatefulWidget {
  final String title;
  const HalamanLogin({Key key, this.title}) : super(key: key);
  @override
  _HalamanLoginState createState() => _HalamanLoginState();
}

enum LoginStatus { notSignIn, signInAnggota, signInAdmin, signInSuperAdmin }

class _HalamanLoginState extends State<HalamanLogin> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String email, password, token, role, role_uuid;
  // String dataLevel = "Anggota";

  final _key = new GlobalKey<FormState>();

  bool _secureText = true;

  // dialog_cek_email() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) => CustomDialog(
  //       image: Image.asset('./gambar/success.gif'),
  //       title: "Lupa password?",
  //       description: "Tenangkan diri Anda dan ingat kembali password Anda (:",
  //       buttonText: "Tutup",
  //     ),
  //   );
  // }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

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

  var loading = false;
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
          Uri.http(URL, 'api/v2/user/login'),
          body: {"phone_number": phone_number, "password": password});
      final data = jsonDecode(response.body);

      // int value = data['value'];
      String status = data['status'];

      print(status);
      String role = data['role'];

      print('role');
      print(role);
      print('role_uuid');
      print(role_uuid);
      // String emailAPI = data['email'];
      if (status != "error") {
        String uuid = data['data']['user']['uuid'];
        String token = data['token'];
        String role = data['role'];
        String role_uuid = data['data']['user']['role'];
        //control flow pengecekan level
        // if (district == "1") {
        setState(() {
          // String phone_number = data['data']['user']['phone_number'];

          // showAlertDialogPegawai();
          setState(() {
            loading = false;
          });
          _loginStatus = LoginStatus.signInAnggota;
          savePrefAnggota(phone_number, token, uuid, role, role_uuid);
        });
        // }
        // if (district == "Palangka Raya") {
        //   setState(() {
        //     // showAlertDialogMasyarakat();
        //     _loginStatus = LoginStatus.signInAdmin;
        //     savePref(value, emailAPI, passwordAPI, district, full_name);
        //   });
        // }
        // if (district == "3") {
        //   setState(() {
        //     // showAlertDialogAdmin();
        //     _loginStatus = LoginStatus.signInSuperAdmin;
        //     savePref(value, emailAPI, passwordAPI, district, full_name);
        //   });
        // }
        // print(pesan);
      }
      // else if (value == 2) {
      //   setState(() {
      //     // showAlertDialogPegawai();
      //     _loginStatus = LoginStatus.signInAdmin;
      //     savePrefAdmin(value, emailAPI);
      //   });

      //   print(pesan);
      // } else if (value == 3) {
      //   setState(() {
      //     // showAlertDialogPegawai();
      //     _loginStatus = LoginStatus.signInSuperAdmin;
      //     savePrefSuper(value, emailAPI);
      //   });

      //   print(pesan);
      // }
      else {
        setState(() {
          loading = false;
        });
        print(uuid);
        showAlertDialogGagalLogin();
      }
    } else {
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => HandlingInet()));
    }
  }

// inti savenya
  savePrefAnggota(String phone_number, String token, String uuid, String role,
      String role_uuid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("phone_number", phone_number);
      preferences.setString("token", token);
      preferences.setString("uuid", uuid);
      preferences.setString("role", role);
      preferences.setString("role_uuid", role_uuid);
      preferences.commit();
    });
  }

  // savePrefAdmin(int value, String email) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     preferences.setInt("value", value);
  //     preferences.setString("email", email);
  //     preferences.commit();
  //   });
  // }

  // savePrefSuper(int value, String email) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     preferences.setInt("value", value);
  //     preferences.setString("email", email);
  //     preferences.commit();
  //   });
  // }

  // var uuid;

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

      print('Token : ${token}');
      print('object');
      // print("response");
    } else {
      print('object');
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => HandlingInet()));
    }
  }

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

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("phone_number", "");
      preferences.setString("token", "");
      preferences.setString("role", "");
      preferences.setString("role_uuid", "");
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          backgroundColor: Colors.white,
          body: getBody(),
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

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 20),
      //     child: IconButton(
      //       icon: Icon(Icons.arrow_back_rounded, color: Colors.black87),
      //       onPressed: () {
      //         Navigator.of(context)
      //             .push(MaterialPageRoute(builder: (context) => MenuAwal()));
      //       },
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      body: getBody(),
    );

    // switch (_loginStatus) {
    //   case LoginStatus.notSignIn:
    //     return Scaffold(
    //       backgroundColor: Colors.white,
    //       appBar: AppBar(
    //         leading: Padding(
    //           padding: const EdgeInsets.only(left: 20),
    //           child: IconButton(
    //             icon: Icon(Icons.arrow_back_rounded, color: Colors.black87),
    //             onPressed: () {
    //               Navigator.of(context).push(
    //                   MaterialPageRoute(builder: (context) => MenuAwal()));
    //             },
    //           ),
    //         ),
    //         backgroundColor: Colors.white,
    //         elevation: 0,
    //       ),
    //       body: getBody(),
    //     );
    //     break;
    //   case LoginStatus.signInAnggota:
    //     return MenuAnggota(signOut: signOut);
    //     break;

    //   case LoginStatus.signInAdmin:
    //     return MenuAdmin(signOut: signOut);
    //     break;

    //   case LoginStatus.signInSuperAdmin:
    //     return MenuSuperAdmin(signOut: signOut);
    //     break;
    // }
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
                              "Silahkan login menggunakan no hp & password yang sudah terdaftar sebelumnya",
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
                            maxLength: 13,
                            validator: (e) {
                              if (e.length < 10 && e.length > 0) {
                                return "Masukkan minimal 10 karakter";
                              }
                              if (e.isEmpty) {
                                return "No handphone kosong, silahkan masukkan";
                              }
                            },
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]')),
                            ],
                            onSaved: (e) => phone_number = e,
                            decoration: textInputDecoration.copyWith(
                                labelText: "No Handphone (WhatsApp)",
                                hintText: "Maksimal 13 karakter"),
                          ),
                          SizedBox(
                            height: size.height * 0.012,
                          ),
                          TextFormField(
                            style: GoogleFonts.inter(color: Color(0xFF414141)),
                            maxLength: 16,
                            obscureText: _secureText,
                            validator: (e) {
                              if (e.length < 6 && e.length > 0) {
                                return "Masukkan minimal 6 karakter";
                              }
                              if (e.isEmpty) {
                                return "Password kosong, silahkan masukkan";
                              }
                            },
                            onSaved: (e) => password = e,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Password",
                                hintText: "Maksimal 16 karakter",
                                suffixIcon: IconButton(
                                  onPressed: showHide,
                                  icon: Icon(
                                    _secureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Color(0xFF18b15a),
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          GestureDetector(
                            child: Text("Lupa Password?",
                                style:
                                    GoogleFonts.inter(color: Colors.black87)),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LupaPassword()));
                            },
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
                                    // if (dataLevel == "Anggota") {
                                    //   // Navigator.of(context).push(MaterialPageRoute(
                                    //   //     builder: (context) => MenuAnggota()));
                                    //   check();
                                    // }
                                    // if (dataLevel == "Admin") {
                                    //   // Navigator.of(context).push(MaterialPageRoute(
                                    //   //     builder: (context) => MenuAdmin()));
                                    //   check();
                                    // }
                                    // if (dataLevel == "Super Admin") {
                                    //   // Navigator.of(context).push(MaterialPageRoute(
                                    //   //     builder: (context) => MenuSuperAdmin()));
                                    //   check();
                                    // }
                                  });
                                  // setState(() {
                                  //   if (dataLevel == "Anggota") {
                                  //     // Navigator.of(context).push(MaterialPageRoute(
                                  //     //     builder: (context) => MenuAnggota()));
                                  //     check();
                                  //   }
                                  //   if (dataLevel == "Admin") {
                                  //     // Navigator.of(context).push(MaterialPageRoute(
                                  //     //     builder: (context) => MenuAdmin()));
                                  //     check();
                                  //   }
                                  //   if (dataLevel == "Super Admin") {
                                  //     // Navigator.of(context).push(MaterialPageRoute(
                                  //     //     builder: (context) => MenuSuperAdmin()));
                                  //     check();
                                  //   }
                                  // });
                                  // check();
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
                            height: size.height * 0.012,
                          ),
                          Align(
                            child: FlatButton(
                              child: Text("Belum punya akun?",
                                  style:
                                      GoogleFonts.inter(color: Colors.black87)),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HalamanDaftar()));
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
