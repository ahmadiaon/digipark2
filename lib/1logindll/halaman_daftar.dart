import 'dart:convert';
import 'package:async/async.dart';
import 'package:digipark/0lainlain/textinputdecor.dart';
import 'package:digipark/1logindll/halaman_login.dart';
import 'package:digipark/customdialog/CustomDialog.dart';
import 'package:digipark/widgets/handlinginet.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class HalamanDaftar extends StatefulWidget {
  @override
  _HalamanDaftarState createState() => _HalamanDaftarState();
}

enum LoginStatus { notSignIn, signInPegawai, signInMasyarakat, signInAdmin }

class _HalamanDaftarState extends State<HalamanDaftar> {
  // LoginStatus _loginStatus = LoginStatus.notSignIn;
  String phone_number, password, email, name, lagi;
  // File _imageFile_idCard;
  // File _imageFile_avatar;

  final _key = new GlobalKey<FormState>();

  bool _secureText = true;
  bool _secureText2 = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  showHide2() {
    setState(() {
      _secureText2 = !_secureText2;
    });
  }

  // showAlertDialogGagalDaftar() {
  //   showDialog(
  //       context: context,
  //       builder: (context) => CustomDialog(
  //             judul: "Pendaftaran",
  //             deskripsi: "Yakin formulir pendaftaran sudah benar?",
  //             gambar: Image.asset("assets/icons/register.png"),
  //             check: check,
  //           ));
  // }

  showAlertDialogGagalDaftar() {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              judul: "Gagal Mendaftar",
              deskripsi: "Password dan masukkan password lagi tidak cocok",
              gambar: Image.asset("assets/icons/username_not_same.png"),
              check: check,
            ));
  }

  showAlertDialogNoHpAda() {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              judul: "Gagal Mendaftar",
              deskripsi:
                  "No HP yang digunakan Sudah pernah terdaftar, gunakan yg lain",
              gambar: Image.asset("assets/icons/failed.png"),
              check: check,
            ));
  }

  showAlertDialogKeduaAda() {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              judul: "Gagal Mendaftar",
              deskripsi:
                  "Email dan No HP yang digunakan Sudah pernah terdaftar atau format email salah, gunakan yg lain",
              gambar: Image.asset("assets/icons/failed.png"),
              check: check,
            ));
  }

  showAlertDialogEmailAda() {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              judul: "Gagal Mendaftar",
              deskripsi:
                  "Email yang digunakan Sudah pernah terdaftar atau format email salah, gunakan yg lain",
              gambar: Image.asset("assets/icons/failed.png"),
              check: check,
            ));
  }

  showAlertDialogBerhasilDaftar() {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              judul: "Berhasil Mendaftar",
              deskripsi: "Selamat Anda berhasil mandaftar!",
              gambar: Image.asset("assets/icons/verif.png"),
              check: check,
            ));
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }
  }

  String email_er = "";
  String number_er = "";
  var loading = false;
  save() async {
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
      if (password == lagi) {
        try {
          final response = await http.post(
              Uri.http(
                  'digiadministrator.falaraborneo.com', 'api/v2/user/register'),
              body: {
                "email": email,
                "password": password,
                "name": name,
                "phone_number": phone_number,
              });

          final data = jsonDecode(response.body);
          if (data['meta']['status'] == "success") {
            if (response.statusCode > 2) {
              setState(() {
                Navigator.pop(context);
                loading = false;
              });

              showAlertDialogBerhasilDaftar();
              print("Anda berhasil terdaftar ");
            } else {
              print("image failed");
            }
          } else if (data['errors']['email'] == null) {
            showAlertDialogNoHpAda();
            setState(() {
              loading = false;
            });
          } else if (data['errors']['phone_number'] == null) {
            showAlertDialogEmailAda();
            setState(() {
              loading = false;
            });
          } else if (data['meta']['status'] == "errors") {
            showAlertDialogKeduaAda();
            setState(() {
              loading = false;
            });
          }
        } catch (e) {
          debugPrint("Error $e");
        }
      } else {
        print("Password dan masukkan password lagi tidak cocok");
        showAlertDialogGagalDaftar();
        setState(() {
          loading = false;
        });
      }
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HandlingInet()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 20),
      //     child: IconButton(
      //       icon: Icon(Icons.arrow_back_rounded, color: Colors.black87),
      //       onPressed: () => Navigator.of(context).pop(),
      //     ),
      //   ),
      //   // actions: [
      //   //   FlatButton(
      //   //     child: Text("Ada kendala? Hubungi admin",
      //   //         style: GoogleFonts.inter(
      //   //             color: Color(0xFF18b15a), fontWeight: FontWeight.bold)),
      //   //     onPressed: () {
      //   //       // Navigator.of(context).push(MaterialPageRoute(
      //   //       //     builder: (context) => MenuRegister()));
      //   //     },
      //   //   ),
      //   // ],
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      body: getBody(),
    );
    // switch (_loginStatus) {
    //   case LoginStatus.notSignIn:

    //     break;
    // case LoginStatus.signInPegawai:
    //   return MenuPegawai(signOut);
    //   break;

    // case LoginStatus.signInMasyarakat:
    //   return MenuMasyarakat(signOut);
    //   break;

    // case LoginStatus.signInAdmin:
    //   return MenuAdmin(signOut);
    //   break;
    // }
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        // height: size.height * 1,
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
                          // Text("Sign Up",
                          //     textAlign: TextAlign.left,
                          //     style: GoogleFonts.inter(
                          //         fontWeight: FontWeight.w900,
                          //         color: Color(0xFF18b15a),
                          //         fontSize: 19)),
                          // SizedBox(
                          //   height: size.height * 0.015,
                          // ),
                          Text(
                              "Silahkan mendaftar terlebih dahulu untuk bisa login pada aplikasi!",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  fontSize: 14.5)),
                          SizedBox(
                            height: size.height * 0.035,
                          ),
                          TextFormField(
                            style: GoogleFonts.inter(color: Color(0xFF414141)),
                            maxLength: 100,
                            validator: (e) {
                              if (e.length < 3 && e.length > 0) {
                                return "Masukkan minimal 3 karakter";
                              }
                              if (e.isEmpty) {
                                return "Nama lengkap kosong, silahkan masukkan";
                              }
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-z,A-Z, ]')),
                            ],
                            onSaved: (e) => name = e,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Nama lengkap",
                                hintText: "Maksimal 100 karakter"),
                          ),
                          SizedBox(
                            height: size.height * 0.012,
                          ),
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
                            maxLength: 100,
                            validator: (email) {
                              if (email.length < 6 && email.length > 0) {
                                return "Masukkan minimal 6 karakter";
                              }
                              if (email.isEmpty) {
                                return "Email kosong, silahkan masukkan";
                              }
                              return email != null &&
                                      !EmailValidator.validate(email)
                                  ? 'Format email salah'
                                  : null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (e) => email = e,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Email",
                                hintText: "Maksimal 100 karakter"),
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
                            height: size.height * 0.012,
                          ),
                          TextFormField(
                            style: GoogleFonts.inter(color: Color(0xFF414141)),
                            maxLength: 16,
                            obscureText: _secureText2,
                            validator: (e) {
                              if (e.length < 6 && e.length > 0) {
                                return "Masukkan minimal 6 karakter";
                              }
                              if (e.isEmpty) {
                                return "Password kosong, silahkan masukkan";
                              }
                            },
                            onSaved: (e) => lagi = e,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Password Lagi",
                                hintText: "Maksimal 16 karakter",
                                suffixIcon: IconButton(
                                  onPressed: showHide2,
                                  icon: Icon(
                                    _secureText2
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Color(0xFF18b15a),
                                  ),
                                )),
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
                                  // showAlertDialogGagalDaftar();
                                  check();
                                },
                                child: Text(
                                  "Sign Up",
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
