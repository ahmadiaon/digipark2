import 'dart:convert';
import 'package:digipark/0lainlain/textinputdecor.dart';
import 'package:digipark/customdialog/CustomDialog.dart';
import 'package:digipark/skeleton/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../customdialog/CustomDialogSimpanProfil.dart';
import '../widgets/handlinginet.dart';

class BankDeskripsiUbah extends StatefulWidget {
  // final String com_uuid;
  // final String name;
  final String role_uuid;
  final VoidCallback tampil_dataa;
  const BankDeskripsiUbah(this.role_uuid, this.tampil_dataa);
  @override
  _BankDeskripsiUbahState createState() => _BankDeskripsiUbahState();
}

enum LoginStatus { notSignIn, signInPegawai, signInMasyarakat, signInAdmin }

class _BankDeskripsiUbahState extends State<BankDeskripsiUbah> {
  String role_uuid,
      token,
      name = "",
      address = "",
      description = "",
      location = "",
      facebook = "",
      instagram = "",
      youtube = "";
  var txtName = TextEditingController(text: 'name');
  var txtAddress = TextEditingController(text: 'address');
  var txtLocation = TextEditingController(text: 'location');
  var txtDescription = TextEditingController(text: 'description');
  var txtInstagram = TextEditingController(text: 'instagram');
  var txtYoutube = TextEditingController(text: 'youtube');
  var txtFacebook = TextEditingController(text: 'facebook');
  final _key = new GlobalKey<FormState>();
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
              deskripsi: "Yakin profil ingin diperbaharui?",
              gambar: Image.asset("assets/icons/save.png"),
              check: check,
            ));
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
    });
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
          Uri.http('digiadministrator.falaraborneo.com',
              'api/v2/user/detail-data-financial/' + widget.role_uuid),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      datanya = json.decode(response.body);
      if (datanya.length == 0) {
      } else {
        setState(() {
          txtName = TextEditingController(text: datanya['data']['name']);
          txtAddress = TextEditingController(text: datanya['data']['address']);
          txtLocation =
              TextEditingController(text: datanya['data']['location']);
          txtDescription =
              TextEditingController(text: datanya['data']['description']);
          txtInstagram =
              TextEditingController(text: datanya['data']['instagram']);
          txtYoutube = TextEditingController(text: datanya['data']['youtube']);
          txtFacebook =
              TextEditingController(text: datanya['data']['facebook']);
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

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      simpan_profil();
    }
  }

  simpan_profil() async {
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
      var uri = Uri.parse(
          'http://digiadministrator.falaraborneo.com/api/v2/user/edit-financial/' +
              widget.role_uuid);
      var request = http.MultipartRequest("POST", uri);
      request.fields['name'] = name;
      request.fields['address'] = address;
      request.fields['description'] = description;
      request.fields['location'] = location;
      request.fields['facebook'] = facebook;
      request.fields['instagram'] = instagram;
      request.fields['youtube'] = youtube;
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
                    deskripsi: "Profil berhasil diperbaharui",
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
    tampil_data();
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
            "Ubah Profil",
            style: GoogleFonts.roboto(
                color: Colors.black87,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
          backgroundColor: Colors.white,
          color: Color(0xFFFFC600),
          onRefresh: tampil_data,
          key: _refresh,
          child: loading
              ? ListView(
                  children: [
                    buildSkeletonDeskripsi(context),
                  ],
                )
              : getBody()),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Form(
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
                  Text("Silahkan ubah data profil jasa keuangan Anda",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          fontSize: 14.5)),
                  SizedBox(
                    height: size.height * 0.020,
                  ),

                  Text("Data Profil",
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
                    controller: txtName,
                    onSaved: (e) => name = e,
                    decoration: textInputDecoration.copyWith(
                        labelText: "Nama jasa keuangan",
                        hintText: "Maksimal 100 karakter"),
                  ),
                  SizedBox(
                    height: size.height * 0.012,
                  ),
                  TextFormField(
                    style: GoogleFonts.roboto(color: Color(0xFF414141)),
                    maxLength: 150,
                    validator: (e) {
                      if (e.length < 6 && e.length > 0) {
                        return "Masukkan minimal 6 karakter";
                      }
                      if (e.isEmpty) {
                        return "Alamat kosong, silahkan masukkan";
                      }
                    },
                    maxLines: 3,
                    controller: txtAddress,
                    onSaved: (e) => address = e,
                    decoration: textInputDecoration.copyWith(
                        labelText: "Alamat", hintText: "Maksimal 60 karakter"),
                  ),
                  SizedBox(
                    height: size.height * 0.012,
                  ),
                  TextFormField(
                    style: GoogleFonts.roboto(color: Color(0xFF414141)),
                    maxLength: 300,
                    validator: (e) {
                      if (e.length < 6 && e.length > 0) {
                        return "Masukkan minimal 6 karakter";
                      }
                      if (e.isEmpty) {
                        return "Link google maps kosong, silahkan masukkan";
                      }
                    },
                    controller: txtLocation,
                    onSaved: (e) => location = e,
                    decoration: textInputDecoration.copyWith(
                        labelText: "Link google maps",
                        hintText: "Maksimal 100 karakter"),
                  ),
                  SizedBox(
                    height: size.height * 0.012,
                  ),
                  TextFormField(
                    style: GoogleFonts.roboto(color: Color(0xFF414141)),
                    maxLength: 2000,
                    validator: (e) {
                      if (e.length < 6 && e.length > 0) {
                        return "Masukkan minimal 6 karakter";
                      }
                      if (e.isEmpty) {
                        return "Deskripsi kosong, silahkan masukkan";
                      }
                    },
                    maxLines: 6,
                    controller: txtDescription,
                    onSaved: (e) => description = e,
                    decoration: textInputDecoration.copyWith(
                        labelText: "Deskripsi",
                        hintText: "Maksimal 60 karakter"),
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  Text("Media Sosial",
                      style: GoogleFonts.roboto(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                  // SizedBox(
                  //   height: size.height * 0.007,
                  // ),
                  // Text("Wajib Mengisi salah Satu media sosial!",
                  //     style: GoogleFonts.roboto(
                  //         color: Colors.black87, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: size.height * 0.012,
                  ),
                  TextFormField(
                    style: GoogleFonts.roboto(color: Color(0xFF414141)),
                    maxLength: 150,
                    validator: (e) {
                      if (e.length < 6 && e.length > 0) {
                        return "Masukkan minimal 6 karakter";
                      }
                      if (e.isEmpty) {
                        return "Instagram kosong, silahkan masukkan";
                      }
                    },
                    controller: txtInstagram,
                    onSaved: (e) => instagram = e,
                    decoration: textInputDecoration.copyWith(
                        labelText: "Link Instagram",
                        hintText: "Maksimal 150 karakter"),
                  ),

                  SizedBox(
                    height: size.height * 0.012,
                  ),
                  TextFormField(
                    style: GoogleFonts.roboto(color: Color(0xFF414141)),
                    maxLength: 150,
                    validator: (e) {
                      if (e.length < 6 && e.length > 0) {
                        return "Masukkan minimal 6 karakter";
                      }
                      if (e.isEmpty) {
                        return "Facebook kosong, silahkan masukkan";
                      }
                    },
                    controller: txtFacebook,
                    onSaved: (e) => facebook = e,
                    decoration: textInputDecoration.copyWith(
                        labelText: "Link Facebook",
                        hintText: "Maksimal 150 karakter"),
                  ),
                  SizedBox(
                    height: size.height * 0.012,
                  ),
                  TextFormField(
                    style: GoogleFonts.roboto(color: Color(0xFF414141)),
                    maxLength: 150,
                    validator: (e) {
                      if (e.length < 6 && e.length > 0) {
                        return "Masukkan minimal 6 karakter";
                      }
                      if (e.isEmpty) {
                        return "Youtube kosong, silahkan masukkan";
                      }
                    },
                    controller: txtYoutube,
                    onSaved: (e) => youtube = e,
                    decoration: textInputDecoration.copyWith(
                        labelText: "Link Youtube",
                        hintText: "Maksimal 150 karakter"),
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
                          "Simpan Profil",
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
