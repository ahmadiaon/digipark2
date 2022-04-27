import 'dart:convert';
import 'dart:math';
import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digipark/0lainlain/modal.dart';
import 'package:digipark/0lainlain/textinputdecor.dart';
import 'package:digipark/skeleton/skeleton.dart';
import 'package:email_validator/email_validator.dart';
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
import 'package:digipark/customdialog/CustomDialog.dart';

class SideBarProfilSaya extends StatefulWidget {
  @override
  _SideBarProfilSayaState createState() => _SideBarProfilSayaState();
}

enum LoginStatus { notSignIn, signInPegawai, signInMasyarakat, signInAdmin }

class _SideBarProfilSayaState extends State<SideBarProfilSaya> {
  // LoginStatus _loginStatus = LoginStatus.notSignIn;

  String uuid, token, fullname, phone_number, email;
  File _imageFile_avatar;
  final _key = new GlobalKey<FormState>();

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

  showAlertDialogBerhasil() {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              judul: "Profil",
              deskripsi: "Profil berhasil diperbaharui",
              gambar: Image.asset("assets/icons/verif.png"),
            ));
  }

  Future pickImage_avatar(ImageSource source) async {
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

  List<ProfilModal> _list_profil = [];

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      uuid = preferences.getString("uuid");
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
          Uri.http('digiadministrator.falaraborneo.com',
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
          txtEmail = TextEditingController(text: datanya['data']['email']);
          txtFull_name = TextEditingController(text: datanya['data']['name']);
          txtPhone_number =
              TextEditingController(text: datanya['data']['phone_number']);
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
      print(uuid);
      print(token);
      final queryParameters = {
        '_method': "PUT",
      };
      if (_imageFile_avatar == null) {
        var uri = Uri.parse(
            'http://digiadministrator.falaraborneo.com/api/v2/user/profile/' +
                uuid +
                '?_method=PUT');
        var request = http.MultipartRequest("POST", uri);
        request.fields['name'] = fullname;
        request.fields['phone_number'] = phone_number;
        request.fields['email'] = email;
        request.headers["Authorization"] = 'Bearer $token';
        var response = await request.send();
        if (response.statusCode > 2) {
          print("image upload");
          setState(() {
            loading = false;
          });
          // setState(() {
          //   // Navigator.pop(context);
          //   //  showAlertDialogMendaftar();
          // });
          showAlertDialogBerhasil();
          print("Anda berhasil terdaftar ");
        } else {
          print("image failed");
          setState(() {
            loading = false;
          });
        }
      } else {
        var stream = http.ByteStream(
            DelegatingStream.typed(_imageFile_avatar.openRead()));
        var length = await _imageFile_avatar.length();
        var uri = Uri.parse(
            'http://digiadministrator.falaraborneo.com/api/v2/user/profile/' +
                uuid +
                '?_method=PUT');
        var request = http.MultipartRequest("POST", uri);
        request.fields['name'] = fullname;
        request.fields['phone_number'] = phone_number;
        request.fields['email'] = email;
        request.files.add(http.MultipartFile("avatar", stream, length,
            filename: path.basename(_imageFile_avatar.path)));
        request.headers["Authorization"] = 'Bearer $token';
        var response = await request.send();
        if (response.statusCode > 2) {
          setState(() {
            loading = false;
          });
          print("image upload");

          showAlertDialogBerhasil();
          print("Anda berhasil terdaftar ");
        } else {
          setState(() {
            loading = false;
          });
          print("image failed");
        }
      }
    } else {
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => HandlingInet()));
    }
  }

  var txtPhone_number = TextEditingController(text: 'phone_number');
  var txtFull_name = TextEditingController(text: 'name');
  var txtEmail = TextEditingController(text: 'email');
  final txtEmail2 = TextEditingController(text: 'email');
  String txt_avatar = "";
  @override
  void initState() {
    getPref();
    tampil_data();
  }

  @override
  void dispose() {
    txtEmail2.dispose();

    super.dispose();
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
            "Profil Saya",
            style: GoogleFonts.roboto(
                color: Colors.black87,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.camera_alt_outlined),
              onPressed: () {
                pickImage_avatar(ImageSource.gallery);
              },
            ),
            SizedBox(
              width: size.width * 0.030,
            ),
          ],
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
                    buildSkeletonSidebarProfilSaya(context),
                  ],
                )
              : getBody()),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    var placeholder_kosong = Container(
      child: txt_avatar == null
          ? Image.asset(
              "assets/images/1gambar.jpg",
              width: size.height * 0.158,
              height: size.height * 0.158,
              fit: BoxFit.cover,
            )
          : txt_avatar == ""
              ? Image.asset(
                  "assets/images/1gambar.jpg",
                  width: size.height * 0.158,
                  height: size.height * 0.158,
                  fit: BoxFit.cover,
                )
              : CachedNetworkImage(
                  imageUrl:
                      'http://digiadministrator.falaraborneo.com' + txt_avatar,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      buildSkeletonDrawer(context),
                  // placeholder: (context, url) =>
                  //     buildSkeletonDrawer(context),
                  errorWidget: (context, url, error) =>
                      buildSkeletonDrawer(context),
                  fit: BoxFit.cover, width: size.height * 0.158,
                  height: size.height * 0.158,
                ),
    );
    // var placeholder_image = Container(
    //   child: Image.network(
    //     'http://digiadministrator.falaraborneo.com' + txt_avatar,
    //     width: size.height * 0.158,
    //     height: size.height * 0.158,
    //     fit: BoxFit.cover,
    //   ),
    // );

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
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(300.0)),
                        child: _imageFile_avatar != null
                            ? Image.file(_imageFile_avatar,
                                width: size.height * 0.158,
                                height: size.height * 0.158,
                                fit: BoxFit.cover)
                            : placeholder_kosong,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  // Text("Sign Up",
                  //     textAlign: TextAlign.left,
                  //     style: GoogleFonts.inter(
                  //         fontWeight: FontWeight.w900,
                  //         color: Color(0xFFFFC600),
                  //         fontSize: 19)),
                  // SizedBox(
                  //   height: size.height * 0.015,
                  // ),
                  Text(
                      "Silahkan lihat atau ubah profil kamu pada form dibawah!",
                      textAlign: TextAlign.justify,
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
                      FilteringTextInputFormatter.allow(RegExp('[a-z,A-Z, ]')),
                    ],
                    controller: txtFull_name,
                    onSaved: (e) => fullname = e,
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
                        return "No handphone (WA) kosong, silahkan masukkan";
                      }
                    },
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    ],
                    controller: txtPhone_number,
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
                      return email != null && !EmailValidator.validate(email)
                          ? 'Format email salah'
                          : null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: [AutofillHints.email],
                    controller: txtEmail,
                    onSaved: (e) => email = e,
                    decoration: textInputDecoration.copyWith(
                        labelText: "Email", hintText: "Maksimal 100 karakter"),
                  ),
                  SizedBox(
                    height: size.height * 0.025,
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
                          "Simpan profil",
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
                    height: size.height * 0.012,
                  ),
                  // Align(
                  //   child: FlatButton(
                  //     child: Text("Punya akun?",
                  //         style: GoogleFonts.inter(color: Colors.black87)),
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
    );
  }
}
