import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
 import 'package:digipark/customdialog/CustomDialog.dart';

class CustomDialogBuatRekening extends StatelessWidget {
  final String judul, deskripsi, operasi;
  final VoidCallback check;
  final Image gambar;
  CustomDialogBuatRekening(
      {this.judul, this.deskripsi, this.operasi, this.gambar,
       this.check
       });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(16, 90, 16, 16),
          margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(17),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0.0, 10.0))
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                judul,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              Text(
                deskripsi,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Tidak",
                      style: GoogleFonts.inter(
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
                  Align(
                      child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigator.pop(context);
                      check();
                   
                    },
                    child: Text(
                      "Ya",
                      style: GoogleFonts.inter(
                          color: Color(0xFF18b15a),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
                ],
              )
            ],
          ),
        ),
        Positioned(
            top: 0,
            left: 20,
            right: 20,
            child: Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: gambar,
            ))
      ],
    );
  }
}
