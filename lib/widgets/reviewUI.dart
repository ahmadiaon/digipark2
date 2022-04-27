import 'package:cached_network_image/cached_network_image.dart';
import 'package:digipark/env.dart';
import 'package:digipark/skeleton/skeleton.dart';
import 'package:digipark/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewUI extends StatelessWidget {
  final String image, name, date, comment, image_path;
  final double rating;
  final Function onTap, onPressed;
  final bool isLess;
  const ReviewUI({
    Key key,
    this.image,
    this.image_path,
    this.name,
    this.date,
    this.comment,
    this.rating,
    this.onTap,
    this.isLess,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      // padding: EdgeInsets.only(
      //   top: 2.0,
      //   bottom: 2.0,
      //   left: 16.0,
      //   right: 0.0,
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 35.0,
                width: 35.0,
                margin: EdgeInsets.only(right: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: image == ""
                      ? Image.asset(
                          "assets/images/1gambar.jpg",
                          width: size.height * 0.158,
                          height: size.height * 0.158,
                          fit: BoxFit.cover,
                        )
                      : image == null
                          ? Image.asset(
                              "assets/images/1gambar.jpg",
                              width: size.height * 0.158,
                              height: size.height * 0.158,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl:
                                  URL_FULL +
                                      image,
                              fit: BoxFit.cover,
                              //                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                              // CircularProgressIndicator(value: downloadProgress.progress),
                              placeholder: (context, url) =>
                                  buildSkeletonPhotoReview(context),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                ),
              ),
              Expanded(
                child: Text(
                  name,
                  style: GoogleFonts.roboto(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // IconButton(
              //   onPressed: onPressed,
              //   icon: Icon(Icons.more_vert),
              // ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              SmoothStarRating(
                isReadOnly: true,
                starCount: 5,
                rating: rating,
                size: 28.0,
                color: Colors.orange,
                borderColor: Colors.orange,
              ),
              SizedBox(width: kFixPadding),
              Text(
                date,
                style: GoogleFonts.roboto(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          GestureDetector(
            onTap: onTap,
            child: isLess
                ? Text(
                    comment,
                    style: GoogleFonts.roboto(
                      fontSize: 15.0,
                      color: kLightColor,
                    ),
                  )
                : Text(
                    comment,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                      fontSize: 15.0,
                      color: kLightColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
          ),
          SizedBox(height: 10.0),
          image_path == ""
              ? Container()
              : Column(
                  children: [
                    Container(
                      width: size.width * 0.333,
                      height: size.height * 0.105,
                      margin: EdgeInsets.only(right: 12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl:
                              URL_HTTP +
                                  image_path,
                          fit: BoxFit.cover,
                          //                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                          // CircularProgressIndicator(value: downloadProgress.progress),
                          placeholder: (context, url) =>
                              buildSkeletonImageReview(context),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
        ],
      ),
    );
  }
}
