import 'package:cached_network_image/cached_network_image.dart';
import 'package:digipark/0lainlain/textinputdecor.dart';
import 'package:digipark/customdialog/CustomDialog.dart';
import 'package:digipark/env.dart';
import 'package:digipark/skeleton/skeleton.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MendaftarKomunitas extends StatefulWidget {
  final String com_uuid;
  final String name;
  final String path;
  const MendaftarKomunitas(this.com_uuid, this.name, this.path);
  @override
  _MendaftarKomunitasState createState() => _MendaftarKomunitasState();
}

enum LoginStatus { notSignIn, signInPegawai, signInMasyarakat, signInAdmin }

class _MendaftarKomunitasState extends State<MendaftarKomunitas> {
  // LoginStatus _loginStatus = LoginStatus.notSignIn;
  String fullname,
      age,
      email,
      phone_number,
      instagram = "",
      facebook = "",
      uuid,
      token;
  String datajabatan = "Anggota";
  String datasetujuDistrik = "Belum Aktif";
  bool _checked = false;
  bool _checked2 = false;
  final _key = new GlobalKey<FormState>();

  showAlertDialogMendaftar() {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
            judul: "Pendaftaran",
            deskripsi: "Anda berhasil terdaftar pada komunitas " + widget.name,
            gambar: Image.asset("assets/icons/verif.png")));
  }

  showAlertDialogGagalMendaftar() {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
            judul: "Pendaftaran Gagal",
            deskripsi:
                "Centang terlebih dahulu ketentuan untuk bisa mendaftar pada komunitas " +
                    widget.name,
            gambar: Image.asset("assets/icons/failed.png")));
  }

  // Future pickImage_idCard(ImageSource source) async {
  //   try {
  //     final image =
  //         await ImagePicker().pickImage(source: source, imageQuality: 50);
  //     if (image == null) return;

  //     final imageTemporary = File(image.path);
  //     setState(() => this._imageFile_idCard = imageTemporary);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  // Future pickImage_avatar(ImageSource source) async {
  //   try {
  //     final image =
  //         await ImagePicker().pickImage(source: source, imageQuality: 50);
  //     if (image == null) return;

  //     final imageTemporary = File(image.path);
  //     setState(() => this._imageFile_avatar = imageTemporary);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  // check() {
  //   final form = _key.currentState;
  //   if (form.validate()) {
  //     form.save();
  //     save();
  //   }
  // }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      uuid = preferences.getString("uuid");
    });
    //_lihatData();
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      mendaftar();
    }
  }

  var loading = false;
  mendaftar() async {
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
      print(uuid);
      print(token);

      var uri = Uri.parse(
          URL_HTTP+'/api/v2/user/community/register/' +
              uuid);
      var request = http.MultipartRequest("POST", uri);
      request.fields['community_uuid'] = widget.com_uuid;
      request.fields['name'] = fullname;
      request.fields['email'] = email;
      request.fields['age'] = age;
      request.fields['phone_number'] = phone_number;
      request.fields['facebook'] = facebook;
      request.fields['instagram'] = instagram;
      request.headers["Authorization"] = 'Bearer $token';
      var response = await request.send();
      if (response.statusCode > 2) {
        print("image upload");

        setState(() {
          Navigator.pop(context);
          showAlertDialogMendaftar();
          loading = false;
        });

        print("Anda berhasil terdaftar ");
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
            "Mendaftar Komunitas",
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
    return SingleChildScrollView(
      child: Container(
        // height: size.height * 1,
        // decoration: new BoxDecoration(
        //   color: Colors.white,
        //   image: new DecorationImage(
        //     fit: BoxFit.cover,
        //     colorFilter: new ColorFilter.mode(
        //         Colors.white.withOpacity(0.07), BlendMode.dstATop),
        //     image: new AssetImage(
        //       'assets/images/jembatan_kahayan.jpg',
        //     ),
        //   ),
        // ),
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
                          Center(
                            child: CachedNetworkImage(
                              imageUrl:
                                  URL_FULL +
                                      widget.path,
                              fit: BoxFit.cover,
                              height: size.height * 0.18,
                              placeholder: (context, url) =>
                                  buildSkeletonLogoMendaftar(context),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),

                          SizedBox(
                            height: size.height * 0.025,
                          ),
                          // Text("Sign Up",
                          //     textAlign: TextAlign.left,
                          //     style: GoogleFonts.roboto(
                          //         fontWeight: FontWeight.w900,
                          //         color: Color(0xFFFFC600),
                          //         fontSize: 18)),
                          // SizedBox(
                          //   height: size.height * 0.015,
                          // ),
                          Text(
                              "Silahkan isi form pendaftaran komunitas " +
                                  widget.name +
                                  " terlebih dahulu untuk bisa mendaftar komunitas!",
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  fontSize: 14.5)),
                          SizedBox(
                            height: size.height * 0.020,
                          ),

                          Text("Data Diri",
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
                                return "Nama lengkap kosong, silahkan masukkan";
                              }
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-z,A-Z, ]')),
                            ],
                            onSaved: (e) => fullname = e,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Nama lengkap",
                                hintText: "Maksimal 100 karakter"),
                          ),
                          SizedBox(
                            height: size.height * 0.012,
                          ),
                          TextFormField(
                            style: GoogleFonts.roboto(color: Color(0xFF414141)),
                            maxLength: 2,
                            validator: (e) {
                              if (e.length < 1 && e.length > 0) {
                                return "Masukkan minimal 2 karakter";
                              }
                              if (e.isEmpty) {
                                return "Umur kosong, silahkan masukkan";
                              }
                            },
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]')),
                            ],
                            onSaved: (e) => age = e,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Umur",
                                hintText: "Maksimal 2 karakter"),
                          ),
                          SizedBox(
                            height: size.height * 0.012,
                          ),
                          TextFormField(
                            style: GoogleFonts.roboto(color: Color(0xFF414141)),
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
                            onSaved: (e) => email = e,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Email",
                                hintText: "Maksimal 100 karakter"),
                          ),
                          SizedBox(
                            height: size.height * 0.012,
                          ),
                          TextFormField(
                            style: GoogleFonts.roboto(color: Color(0xFF414141)),
                            maxLength: 13,
                            validator: (e) {
                              if (e.length < 10 && e.length > 0) {
                                return "Masukkan minimal 10 karakter";
                              }
                              if (e.isEmpty) {
                                return "No handphone (WA) kosong, silahkan masukkan";
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
                            height: size.height * 0.005,
                          ),
                          Text("Media Sosial",
                              style: GoogleFonts.roboto(
                                  color: Colors.black87,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          Text("Wajib Mengisi salah Satu media sosial!",
                              style: GoogleFonts.roboto(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: size.height * 0.012,
                          ),
                          TextFormField(
                            style: GoogleFonts.roboto(color: Color(0xFF414141)),
                            maxLength: 100,
                            // validator: (e) {
                            //   if (e.length < 0 && e.length > 0) {
                            //     return "Masukkan minimal 6 karakter";
                            //   }
                            //   if (e.isEmpty) {
                            //     return "Instagram kosong, silahkan masukkan";
                            //   }
                            // },
                            onSaved: (e) => instagram = e,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Instagram",
                                hintText: "Maksimal 100 karakter"),
                          ),

                          SizedBox(
                            height: size.height * 0.012,
                          ),
                          TextFormField(
                            style: GoogleFonts.roboto(color: Color(0xFF414141)),
                            maxLength: 100,
                            // validator: (e) {
                            //   if (e.length < 0 && e.length > 0) {
                            //     return "Masukkan minimal 6 karakter";
                            //   }
                            //   if (e.isEmpty) {
                            //     return "Facebook kosong, silahkan masukkan";
                            //   }
                            // },
                            onSaved: (e) => facebook = e,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Facebook",
                                hintText: "Maksimal 100 karakter"),
                          ),
                          SizedBox(
                            height: size.height * 0.012,
                          ),
                          Text("Ketentuan",
                              style: GoogleFonts.roboto(
                                  color: Colors.black87,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(
                            height: size.height * 0.010,
                          ),
                          Container(
                            height: 40,
                            child: ListTileTheme(
                              contentPadding: EdgeInsets.zero,
                              child: CheckboxListTile(
                                title: Text(
                                    'Saya sudah membaaca peraturan komunitas yang ada di deskripsi',
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.roboto(
                                        color: Colors.black87, fontSize: 13)),
                                controlAffinity:
                                    ListTileControlAffinity.platform,
                                dense: true,
                                value: _checked,
                                onChanged: (bool value) {
                                  if (value == true) {
                                    setState(() {
                                      // datasetujuDistrik = 'Setuju Admin';
                                      _checked = value;
                                    });
                                  } else {
                                    setState(() {
                                      // datasetujuDistrik = 'Belum Aktif';
                                      _checked = value;
                                    });
                                  }
                                },
                                activeColor: Color(0xFFFFC600),
                                checkColor: Colors.black87,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          ListTileTheme(
                            contentPadding: EdgeInsets.zero,
                            child: CheckboxListTile(
                              title: Text(
                                  'Saya menyetujui keputusan Ketua Komunitas yang berkaitan dengan pendaftaran saya di komunitas ini',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.roboto(
                                      color: Colors.black87, fontSize: 13)),
                              controlAffinity: ListTileControlAffinity.platform,
                              dense: true,
                              value: _checked2,
                              onChanged: (bool value) {
                                if (value == true) {
                                  setState(() {
                                    // datasetujuDistrik = 'Setuju Admin';
                                    _checked2 = value;
                                  });
                                } else {
                                  setState(() {
                                    // datasetujuDistrik = 'Belum Aktif';
                                    _checked2 = value;
                                  });
                                }
                              },
                              activeColor: Color(0xFFFFC600),
                              checkColor: Colors.black87,
                            ),
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
                                  if (instagram == "") {
                                    if (_checked == true && _checked2 == true) {
                                      check();
                                    } else {
                                      print('centang dlu');
                                      showAlertDialogGagalMendaftar();
                                    }
                                  } else {
                                    print('isi salah satu medssos');
                                  }
                                },
                                child: Text(
                                  "Mendaftar Komunitas",
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
                          // Align(
                          //   child: FlatButton(
                          //     child: Text("Punya akun?",
                          //         style: GoogleFonts.roboto(color: Colors.black87)),
                          //     onPressed: () {
                          //       // Navigator.of(context).push(MaterialPageRoute(
                          //       //     builder: (context) => MenuLogin()));
                          //     },
                          //   ),
                          // ),
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
