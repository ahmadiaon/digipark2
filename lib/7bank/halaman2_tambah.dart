import 'dart:convert';
import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digipark/0lainlain/bank_model.dart';
import 'package:digipark/0lainlain/textinputdecor.dart';
import 'package:digipark/customdialog/CustomDialog.dart';
import 'package:digipark/env.dart';
import 'package:digipark/skeleton/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

import '../customdialog/CustomDialogSimpanProfil.dart';
import '../widgets/handlinginet.dart';

class BankGambarTambah extends StatefulWidget {
  // final String com_uuid;
  // final String name;
  final String role_uuid;
  final VoidCallback tampil_dataa;
  const BankGambarTambah(this.role_uuid, this.tampil_dataa);
  @override
  _BankGambarTambahState createState() => _BankGambarTambahState();
}

enum LoginStatus { notSignIn, signInPegawai, signInMasyarakat, signInAdmin }

class _BankGambarTambahState extends State<BankGambarTambah> {
  String role_uuid, token, name;
  File _imageFile_avatar;

  tampil_dataa() {
    setState(() {
      widget.tampil_dataa();
    });
  }

  showAlertDialogMendaftar() {
    showDialog(
        context: context,
        builder: (context) => CustomDialogSimpanProfil(
              judul: "Profil",
              deskripsi: "Yakin tambahkan gambar slide ini?",
              gambar: Image.asset("assets/icons/save.png"),
              check: check,
            ));
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      role_uuid = preferences.getString("role_uuid");
    });
  }

  Future pickImage_idCard(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 50);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this._imageFile_avatar = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  final _key = new GlobalKey<FormState>();
  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      tambah_gambar();
    }
  }

  var loading = false;
  tambah_gambar() async {
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
      var stream =
          http.ByteStream(DelegatingStream.typed(_imageFile_avatar.openRead()));
      var length = await _imageFile_avatar.length();
      var uri = Uri.parse(
          URL_HTTP+'/api/v2/user/financial-slide/' +
              role_uuid +
              '/slide');
      var request = http.MultipartRequest("POST", uri);
      request.fields['name'] = name;
      request.files.add(http.MultipartFile("image", stream, length,
          filename: path.basename(_imageFile_avatar.path)));
      request.headers["Authorization"] = 'Bearer $token';
      var response = await request.send();
      if (response.statusCode > 2) {
        print("image upload");
        Navigator.pop(context);
        showAlertDialogMendaftar() {
          showDialog(
              context: context,
              builder: (context) => CustomDialog(
                    judul: "Profil",
                    deskripsi: "Gambar slide berhasil ditambahkan",
                    gambar: Image.asset("assets/icons/verif.png"),
                  ));
        }

        showAlertDialogMendaftar();
        tampil_dataa();
        print("Anda berhasil terdaftar ");
        setState(() {
          loading = false;
        });
      } else {
        print("image failed");
        setState(() {
          loading = false;
        });
      }
    } else {
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => HandlingInet()));
    }
  }

  @override
  void initState() {
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.052),
        child: AppBar(
          elevation: 0,
          foregroundColor: Colors.black87,
          centerTitle: true,
          backgroundColor: Color(0xFFFFC600),
          title: Text(
            "Tambah Gambar",
            style: GoogleFonts.roboto(
                color: Colors.black87,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    var placeholder_id_card = Container(
      child: Image.asset(
        "assets/images/gambar.png",
        width: size.width * 0.333,
        height: size.height * 0.105,
        fit: BoxFit.cover,
      ),
    );
    return SingleChildScrollView(
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
                      0xFFFFC600), // Defaults to the current Theme's backgroundColor.
                ),
              ))
          : Form(
              key: _key,
              child: Stack(
                children: <Widget>[
                  // SafeArea(
                  //   child: Padding(
                  //     padding:
                  //         const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: <Widget>[
                  //         Container(
                  //           padding: EdgeInsets.all(8),
                  //           // margin: EdgeInsets.only(top: size.height * 0.1),
                  //           // width: 400,
                  //           decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             color: Colors.white.withOpacity(0.5),
                  //             // borderRadius: BorderRadius.only(
                  //             //   topLeft: Radius.circular(50.0),
                  //             //   topRight: Radius.circular(50.0),
                  //             // )
                  //           ),
                  //           child: InkWell(
                  //             onTap: () {
                  //               Navigator.pop(context);
                  //             },
                  //             child: Icon(Icons.arrow_back_rounded,
                  //                 color: Color(0xFFFFC600)),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 25, 30, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Text("Sign Up",
                        //     textAlign: TextAlign.left,
                        //     style: GoogleFonts.roboto(
                        //         fontWeight: FontWeight.w900,
                        //         color: Color(0xFFFFC600),
                        //         fontSize: 18)),
                        // SizedBox(
                        //   height: size.height * 0.015,
                        // ),
                        Text("Silahkan tambah gambar slide jasa keuangan Anda",
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                                fontSize: 14.5)),
                        SizedBox(
                          height: size.height * 0.020,
                        ),

                        Text("Data Gambar Slide",
                            style: GoogleFonts.roboto(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          height: size.height * 0.012,
                        ),
                        TextFormField(
                          style: GoogleFonts.roboto(color: Color(0xFF414141)),
                          maxLength: 100,
                          validator: (e) {
                            if (e.length < 3 && e.length > 0) {
                              return "Masukkan minimal 3 karakter";
                            }
                            if (e.isEmpty) {
                              return "Nama jasa keuangan kosong, silahkan masukkan";
                            }
                          },
                          onSaved: (e) => name = e,
                          decoration: textInputDecoration.copyWith(
                              labelText: "Nama gambar slide",
                              hintText: "Maksimal 100 karakter"),
                        ),
                        SizedBox(
                          height: size.height * 0.012,
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    pickImage_idCard(ImageSource.gallery);
                                  },
                                  child: Container(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        child: _imageFile_avatar != null
                                            ? Image.file(_imageFile_avatar,
                                                width: size.width * 0.333,
                                                height: size.height * 0.105,
                                                fit: BoxFit.cover)
                                            : placeholder_id_card),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.04,
                                ),
                                Expanded(
                                  child: Container(
                                    child: Text(
                                        'Upload gambar slide yang jelas, dengan ratio yang disarankan 3:2 ',
                                        style: GoogleFonts.inter(
                                            color: Colors.black87,
                                            fontSize: 13)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.04,
                            ),
                            GestureDetector(
                              child: Text("Pilih Foto",
                                  style: GoogleFonts.inter(
                                      color: Color(0xFF18b15a),
                                      fontWeight: FontWeight.w600)),
                              onTap: () {
                                pickImage_idCard(ImageSource.gallery);
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.035,
                        ),
                        Center(
                          child: SizedBox(
                            width: size.width * 0.99,
                            height: size.height * 0.055,
                            child: RaisedButton(
                              color: Color(0xFFFFC600),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () {
                                showAlertDialogMendaftar();
                              },
                              child: Text(
                                "Tambah",
                                style: GoogleFonts.roboto(
                                    color: Colors.black87,
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
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
