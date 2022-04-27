import 'package:async/async.dart';
import 'package:digipark/0lainlain/textinputdecor.dart';
import 'package:digipark/customdialog/CustomDialogPinjamDana.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digipark/customdialog/CustomDialog.dart';

class PinjamanDana extends StatefulWidget {
  final String finan_uuid;
  const PinjamanDana(this.finan_uuid);
  @override
  _PinjamanDanaState createState() => _PinjamanDanaState();
}

enum LoginStatus { notSignIn, signInPegawai, signInMasyarakat, signInAdmin }

class _PinjamanDanaState extends State<PinjamanDana> {
  // LoginStatus _loginStatus = LoginStatus.notSignIn;
  String fullname,
      email,
      business,
      business_address,
      income,
      loan,
      purpose,
      full_name,
      district = "Kota Palangka Raya",
      nin,
      status,
      position,
      number_code,
      avatar,
      image_id_card,
      phone_number,
      address,
      geolocation,
      instagram,
      facebook,
      whatsapp,
      lagi,
      uuid,
      token;
  File _imageFile_idCard;
  // File _imageFile_avatar;

  final _key = new GlobalKey<FormState>();

  showAlertDialogPinjamDana() {
    showDialog(
        context: context,
        builder: (context) => CustomDialogPinjamDana(
              judul: "Pinjam Dana",
              deskripsi: "Yakin form telah diisi dengan benar?",
              gambar: Image.asset("assets/icons/save.png"),
              check: check,
            ));
  }

  showAlertDialogMendaftar() {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              judul: "Pinjam Dana",
              deskripsi:
                  "Peminjaman dana sedang diproses, tunggu informasi yang akan diberikan melalui No Whatsapp yang telah didaftarkan pada pembuatan rekening",
              gambar: Image.asset("assets/icons/verif.png"),
            ));
  }

  Future pickImage_idCard(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 50);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this._imageFile_idCard = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

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
      pinjam_dana();
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
  pinjam_dana() async {
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
      var stream =
          http.ByteStream(DelegatingStream.typed(_imageFile_idCard.openRead()));
      var length = await _imageFile_idCard.length();
      var uri = Uri.parse(
          'http://digiadministrator.falaraborneo.com/api/v2/user/financial-service/submission/' +
              uuid);
      var request = http.MultipartRequest("POST", uri);
      request.fields['financial_service_uuid'] = widget.finan_uuid;
      request.fields['name'] = fullname;
      request.fields['address'] = address;
      request.fields['business_name'] = business;
      request.fields['business_address'] = business_address;
      request.fields['income'] = income;
      request.fields['loan_estimate'] = loan;
      request.fields['purpose'] = purpose;
      request.files.add(http.MultipartFile("identity_card", stream, length,
          filename: path.basename(_imageFile_idCard.path)));
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

  final _controller_income = TextEditingController();
  final _controller_loan = TextEditingController();
  static const _locale = 'ind';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

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
            "Pinjam Dana",
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
    var placeholder_id_card = Container(
      child: Image.asset(
        "assets/images/ktp.png",
        width: size.width * 0.333,
        height: size.height * 0.105,
        fit: BoxFit.cover,
      ),
    );
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
                              "Silahkan isi form peminjaman dana terlebih dahulu untuk bisa melakukan pinjaman dana!",
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
                            validator: (e) {
                              if (e.length < 6 && e.length > 0) {
                                return "Masukkan minimal 6 karakter";
                              }
                              if (e.isEmpty) {
                                return "Nama usaha kosong, silahkan masukkan";
                              }
                            },
                            onSaved: (e) => business = e,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Nama usaha",
                                hintText: "Maksimal 100 karakter"),
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
                                return "Alamat tempat usaha kosong, silahkan masukkan";
                              }
                            },
                            onSaved: (e) => business_address = e,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Alamat tempat usaha",
                                hintText: "Maksimal 500 karakter"),
                          ),
                          SizedBox(
                            height: size.height * 0.012,
                          ),
                          TextFormField(
                            style: GoogleFonts.inter(color: Color(0xFF414141)),
                            maxLength: 14,
                            validator: (e) {
                              if (e.length < 5 && e.length > 0) {
                                return "Masukkan minimal 6 karakter";
                              }
                              if (e.isEmpty) {
                                return "Pendapatan per bulan kosong, silahkan masukkan";
                              }
                            },
                            controller: _controller_income,
                            decoration: textInputDecoration.copyWith(
                              prefixText: _currency,
                              labelText: "Pendapatan per bulan",
                              // hintText: "Maksimal 100 karakter"
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]')),
                            ],
                            onChanged: (string) {
                              string =
                                  ' ${_formatNumber(string.replaceAll('.', ''))}';
                              _controller_income.value = TextEditingValue(
                                text: string,
                                selection: TextSelection.collapsed(
                                    offset: string.length),
                              );
                            },
                            onSaved: (e) => income = e,
                            // decoration: textInputDecoration.copyWith(
                            //     labelText: "Pendapatan",
                            //     hintText: "Maksimal 100 karakter"),
                          ),
                          SizedBox(
                            height: size.height * 0.012,
                          ),
                          TextFormField(
                            style: GoogleFonts.inter(color: Color(0xFF414141)),
                            maxLength: 14,
                            validator: (e) {
                              if (e.length < 5 && e.length > 0) {
                                return "Masukkan minimal 6 karakter";
                              }
                              if (e.isEmpty) {
                                return "Estimasi pinjaman kosong, silahkan masukkan";
                              }
                            },
                            controller: _controller_loan,
                            decoration: textInputDecoration.copyWith(
                              prefixText: _currency,
                              labelText: "Estimasi pinjaman ",
                              // hintText: "Maksimal 100 karakter"
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]')),
                            ],
                            onChanged: (string) {
                              string =
                                  ' ${_formatNumber(string.replaceAll('.', ''))}';
                              _controller_loan.value = TextEditingValue(
                                text: string,
                                selection: TextSelection.collapsed(
                                    offset: string.length),
                              );
                            },
                            onSaved: (e) => loan = e,
                            // decoration: textInputDecoration.copyWith(
                            //     labelText: "Pendapatan",
                            //     hintText: "Maksimal 100 karakter"),
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
                                return "Pinjaman untuk keperluan kosong, silahkan masukkan";
                              }
                            },
                            onSaved: (e) => purpose = e,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Pinjaman untuk keperluan",
                                hintText: "Maksimal 100 karakter"),
                          ),
                          Text("Foto KTP",
                              style: GoogleFonts.inter(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: size.height * 0.01,
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
                                          child: _imageFile_idCard != null
                                              ? Image.file(_imageFile_idCard,
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
                                          'Upload foto KTP kamu yang jelas, dengan keterangan yang bisa dibaca.',
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
                                  showAlertDialogPinjamDana();
                                  // check();
                                },
                                child: Text(
                                  "Ajukan peminjaman dana",
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

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "ind");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
