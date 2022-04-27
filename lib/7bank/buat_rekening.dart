import 'package:digipark/0lainlain/textinputdecor.dart';
import 'package:digipark/customdialog/CustomDialog.dart';
import 'package:digipark/customdialog/CustomDialogBuatRekening.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server/gmail.dart';

class BuatRekening extends StatefulWidget {
  // final IsiBank data_bank;
  final String finan_uuid;
  const BuatRekening(this.finan_uuid);
  @override
  _BuatRekeningState createState() => _BuatRekeningState();
}

enum LoginStatus { notSignIn, signInPegawai, signInMasyarakat, signInAdmin }

class _BuatRekeningState extends State<BuatRekening> {
  // LoginStatus _loginStatus = LoginStatus.notSignIn;
  String fullname,
      address,
      profession,
      email,
      phone_number,
      password,
      instagram,
      facebook,
      uuid,
      token;
  // File _imageFile_idCard;
  // File _imageFile_avatar;

  final _key = new GlobalKey<FormState>();

  showAlertDialogBuatRek() {
    showDialog(
        context: context,
        builder: (context) => CustomDialogBuatRekening(
              judul: "Rekening",
              deskripsi: "Yakin form telah diisi dengan benar?",
              gambar: Image.asset("assets/icons/save.png"),
              check: check,
            ));
  }

  showAlertDialogMendaftar() {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              judul: "Rekening",
              deskripsi:
                  "Pembuatan rekening sedang diproses, tunggu informasi yang akan diberikan melalui No Whatsapp yang telah didaftarkan tadi",
              gambar: Image.asset("assets/icons/verif.png"),
              // check: check,
            ));
  }

  openwhatsapp() async {
    var whatsapp = "+6283841915786";
    var whatsappURl_android = "whatsapp://send?phone=" +
        whatsapp +
        "&text=Saya ingin melakukan pembukaan rekening baru, berikut form biodata diri saya : \n\nNama Lengkap : $fullname\nNo WhatsAppp : $phone_number\nAlamat : $address\nEmail : $email\nPekerjaan : $profession";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }

  // sendMail() async {
  //   String username = 'digipark.creative17@gmail.com';
  //   String password = 'ytdigiPARK0777';
  //   print(email);
  //   final smtpServer = gmail(username, password);
  //   // Use the SmtpServer class to configure an SMTP server:
  //   // final smtpServer = SmtpServer('smtp.domain.com');
  //   // See the named arguments of SmtpServer for further configuration
  //   // options.

  //   // Create our message.
  //   final message = Message()
  //     ..from = Address(username)
  //     ..recipients.add(email)
  //     // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
  //     // ..bccRecipients.add(Address('bccAddress@example.com'))
  //     ..subject = 'Pembukaan Rekening Baru ${DateTime.now()}'
  //     // ..text = 'This is the plain text.\nThis is line 2 of the text part.'
  //     ..html =
  //         "<h3>Saya ingin melakukan pembukaan rekening baru, berikut form biodata diri saya : \n\nNama Lengkap : $fullname\nNo WhatsAppp : $phone_number\nAlamat : $address\nEmail : $email\nPekerjaan : $profession</p>";

  //   try {
  //     final sendReport = await send(message, smtpServer);
  //     print('Message sent: ' + sendReport.toString());
  //   } on MailerException catch (e) {
  //     print('Message not sent. \n' + e.toString());
  //     // for (var p in e.problems) {
  //     //   print('Problem: ${p.code}: ${p.msg}');
  //     // }
  //   }
  // }
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

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      ajukan_rekening();
      // openwhatsapp();
      // sendMail();
      // save();
    }
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      uuid = preferences.getString("uuid");
    });
    //_lihatData();
  }

  var loading = false;
  ajukan_rekening() async {
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
          'http://digiadministrator.falaraborneo.com/api/v2/user/financial-service/register/' +
              uuid);
      var request = http.MultipartRequest("POST", uri);
      request.fields['financial_service_uuid'] = widget.finan_uuid;
      request.fields['name'] = fullname;
      request.fields['address'] = address;
      request.fields['phone_number'] = phone_number;
      request.fields['email'] = email;
      request.fields['profession'] = profession;
      request.headers["Authorization"] = 'Bearer $token';
      var response = await request.send();
      if (response.statusCode > 2) {
        print("image upload");
        Navigator.pop(context);
        showAlertDialogMendaftar();
        setState(() {
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
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: Color(0xFF18b15a),
          title: Text(
            "Buat Rekening",
            style: GoogleFonts.roboto(
                color: Colors.white,
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
                    //                 color: Color(0xFF18b15a)),
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
                              "Silahkan isi form pembuatan rekening baru terlebih dahulu untuk pembuatan rekening bank!",
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  fontSize: 14.5)),
                          SizedBox(
                            height: size.height * 0.020,
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
                            onSaved: (e) => fullname = e,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-z,A-Z, ]')),
                            ],
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
                            maxLength: 500,
                            validator: (e) {
                              if (e.length < 6 && e.length > 0) {
                                return "Masukkan minimal 6 karakter";
                              }
                              if (e.isEmpty) {
                                return "Alamat kosong, silahkan masukkan";
                              }
                            },
                            onSaved: (e) => address = e,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Alamat",
                                hintText: "Maksimal 500 karakter"),
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
                            maxLength: 100,
                            validator: (e) {
                              if (e.length < 3 && e.length > 0) {
                                return "Masukkan minimal 3 karakter";
                              }
                              if (e.isEmpty) {
                                return "Pekerjaan kosong, silahkan masukkan";
                              }
                            },
                            onSaved: (e) => profession = e,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Pekerjaan",
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
                                  showAlertDialogBuatRek();
                                  // check();
                                },
                                child: Text(
                                  "Ajukan pembuatan rekening",
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
      ),
    );
  }
}
