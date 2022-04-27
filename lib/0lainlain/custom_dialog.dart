import 'package:cached_network_image/cached_network_image.dart';
import 'package:digipark/env.dart';
import 'package:digipark/skeleton/skeleton.dart'; 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDialog extends StatefulWidget {
  final String title, description, buttonText, qrcode, image;
  
  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    @required this.image,
    @required this.qrcode,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  var UrL = "";

  @override
  
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
    
    return Stack(
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
          child: ListView(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min, // To make the card compact
                children: <Widget>[
                  Text(
                    widget.title,
                    style: GoogleFonts.inter(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    child: Text(
                      widget.description,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                      child: CachedNetworkImage(
                        imageUrl:
                            URL_FULL + widget.qrcode,
                        // fit: BoxFit.cover,
                        //                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                        // CircularProgressIndicator(value: downloadProgress.progress),
                        placeholder: (context, url) =>
                            buildSkeletonQRCode(context),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      margin: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0)),
                  // SizedBox(height: 24.0),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FlatButton(
                      textColor: Color(0xFF18b15a),
                      onPressed: () {
                        Navigator.of(context).pop(); // To close the dialog
                      },
                      child: Text(widget.buttonText),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: Consts.avatarRadius,
            child: ClipOval(
              child: CachedNetworkImage(
                height: 120,
                width: 120,
                imageUrl: URL_FULL + widget.image,
                fit: BoxFit.cover,
                //                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                // CircularProgressIndicator(value: downloadProgress.progress),
                placeholder: (context, url) =>
                    buildSkeletonPhotoReview(context),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
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
