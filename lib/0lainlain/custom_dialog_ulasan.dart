import 'package:digipark/0lainlain/textinputdecor.dart';
import 'package:digipark/widgets/constant.dart'; 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CustomDialogUlasan extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;
  String fullname;

  CustomDialogUlasan({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
    // this.qrcode,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: Consts.avatarRadius + Consts.padding,
                bottom: Consts.padding,
                left: Consts.padding,
                right: Consts.padding,
              ),
              margin: EdgeInsets.only(top: Consts.avatarRadius),
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(Consts.padding),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 15.0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // To make the card compact
                  children: <Widget>[
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Text(
                      description,
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 35.0,
                          width: 35.0,
                          margin: EdgeInsets.only(right: 12.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/profil1.jpeg"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(44.0),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Chandra Tirta",
                            style: GoogleFonts.roboto(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // IconButton(
                        //   onPressed: () {
                        //     // Navigator.of(context).push(MaterialPageRoute(
                        //     //     builder: (context) => BeriUlasan()));
                        //   },
                        //   icon: Icon(Icons.more_vert),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmoothStarRating(
                          starCount: 5,
                          rating: 0,
                          size: 50.0,
                          color: Colors.orange,
                          borderColor: Colors.orange,
                        ),
                        SizedBox(width: kFixPadding),
                        // Text(
                        //   date,
                        //   style: GoogleFonts.roboto(fontSize: 14.0, fontWeight: FontWeight.w600,),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            style: GoogleFonts.inter(color: Color(0xFF414141)),
                            maxLength: 1000,
                            maxLines: 7,
                            validator: (e) {
                              if (e.length < 6 && e.length > 0) {
                                return "Masukkan minimal 6 karakter";
                              }
                              if (e.isEmpty) {
                                return "Komentar kosong, silahkan masukkan";
                              }
                            },
                            onSaved: (e) => fullname = e,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Komentar",
                                hintText: "Maksimal 1000 karakter"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Center(
                      child: SizedBox(
                        width: size.width * 0.99,
                        height: size.height * 0.050,
                        child: RaisedButton(
                          color: Color(0xFF18b15a),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () {
                            // showAlertDialogMendaftar();
                          },
                          child: Text(
                            "Kirim ulasan",
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: FlatButton(
                        textColor: Color(0xFF18b15a),
                        onPressed: () {
                          Navigator.of(context).pop(); // To close the dialog
                        },
                        child: Text(buttonText),
                      ),
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
            Positioned(
              left: Consts.padding,
              right: Consts.padding,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: Consts.avatarRadius,
                child: ClipOval(
                  child: image,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 10.0;
  static const double avatarRadius = 66.0;
}
