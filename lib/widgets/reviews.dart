import 'dart:convert';
import 'dart:io'; 
import 'package:date_format/date_format.dart';
import 'package:digipark/0lainlain/modal.dart';
import 'package:digipark/widgets/constant.dart';
import 'package:digipark/widgets/reviewUI.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart' as http;

class Reviews extends StatefulWidget {
  final String buss_uuid;
  const Reviews(this.buss_uuid);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  bool isMore = false;

  List<ReviewListModal> list_review = [];
  List<ReviewListModal> list_review_b1 = [];
  var loading = false;
  String uuid, token;
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      uuid = preferences.getString("uuid");
    });
    //_lihatData();
  }

  double total = 0;
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
      list_review.clear();
      list_review_b1.clear;
      setState(() {
        loading = true;
      });
      print(widget.buss_uuid);
      final response2 = await http.get(
          Uri.http('digiadministrator.falaraborneo.com',
              'api/v2/user/business/' + widget.buss_uuid + '/review/list'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            // "phone": phone_number,
          });
      if (response2.contentLength == 2) {
      } else {
        final data = jsonDecode(response2.body);
        // print(data);
        // String message = data['meta']['message'];
        // print(message);

        data['data'].forEach((api) {
          final ab = new ReviewListModal(
              api['id'],
              api['uuid'],
              api['business_uuid'],
              api['user_uuid'],
              api['image_path'],
              api['description'],
              api['value'] == 1
                  ? 1.0
                  : api['value'] == 2
                      ? 2.0
                      : api['value'] == 3
                          ? 3.0
                          : api['value'] == 4
                              ? 4.0
                              : api['value'] == 5
                                  ? 5.0
                                  : api['value'],
              api['status'],
              api['created_at'],
              api['updated_at'],
              api['name'],
              api['photo_path']);

          total = total + api['value'].toDouble();
          // if (ab.value == 1.0 || ab.value == 1.5) {
          //   api['value'];

          //   list_review_b1.add(ab);
          // }

          list_review.add(ab);
        });
        print(total);
        print(data['data']);
        setState(() {
          loading = false;
        });
      }

      print(response2);
      // print("response");
    } else {
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => HandlingInet()));
    }
  }

  double doubleVar;
  @override
  void initState() {
    super.initState();
    getPref();
    tampil_data();
    // int bintang_1 = list_review_b1.length;
    // double doubleVar = bintang_1.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double rata = total / list_review.length;
    double ratarata = num.parse(rata.toStringAsFixed(1));
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.052),
        child: AppBar(
          elevation: 0,
          foregroundColor: Colors.black87,
          centerTitle: true,
          backgroundColor: Color(0xFFFFC600),
          title: Text(
            'Ulasan lengkap',
            style: GoogleFonts.roboto(
                color: Colors.black87,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: loading
          ? Center(
              heightFactor: 12,
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
          : ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFF1F1F1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            )),
                        // color: kAccentColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "${ratarata}",
                                        style: TextStyle(fontSize: 48.0),
                                      ),
                                      TextSpan(
                                        text: "/5",
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          color: kLightColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  "${list_review.length} Ulasan",
                                  style: GoogleFonts.roboto(
                                    fontSize: 17.0,
                                    color: kLightColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: size.width * 0.042),
                            Row(
                              children: [
                                SmoothStarRating(
                                  isReadOnly: true,
                                  starCount: 5,
                                  rating: ratarata == 0.1
                                      ? 0.0
                                      : ratarata == 0.2
                                          ? 0.0
                                          : ratarata == 0.6
                                              ? 0.5
                                              : ratarata == 0.7
                                                  ? 0.5
                                                  : ratarata == 1.1
                                                      ? 1.0
                                                      : ratarata == 1.2
                                                          ? 1.0
                                                          : ratarata == 1.6
                                                              ? 1.5
                                                              : ratarata ==
                                                                      1.7
                                                                  ? 1.5
                                                                  : ratarata ==
                                                                          2.1
                                                                      ? 2.0
                                                                      : ratarata ==
                                                                              2.2
                                                                          ? 2.0
                                                                          : ratarata == 2.6
                                                                              ? 2.5
                                                                              : ratarata == 2.7
                                                                                  ? 2.5
                                                                                  : ratarata == 3.1
                                                                                      ? 3.0
                                                                                      : ratarata == 3.2
                                                                                          ? 3.0
                                                                                          : ratarata == 3.6
                                                                                              ? 3.5
                                                                                              : ratarata == 3.7
                                                                                                  ? 3.5
                                                                                                  : ratarata == 4.1
                                                                                                      ? 4.0
                                                                                                      : ratarata == 4.2
                                                                                                          ? 4.0
                                                                                                          : ratarata == 4.6
                                                                                                              ? 4.5
                                                                                                              : ratarata == 4.7
                                                                                                                  ? 4.5
                                                                                                                  : ratarata,
                                  size: 40.0,
                                  color: Colors.orange,
                                  borderColor: Colors.orange,
                                ),
                                // Container(
                                //   // width: 175.0,
                                //   child: ListView.builder(
                                //     shrinkWrap: true,
                                //     reverse: true,
                                //     itemCount: 5,
                                //     itemBuilder: (context, index) {
                                //       // var long2 = num.tryParse(bintang_1)?.toDouble();
                                //       List<double> ratings = [
                                //         0.0,
                                //         1.0,
                                //         1.0,
                                //         1.0,
                                //         0.9
                                //       ];
                                //       return Row(
                                //         children: [
                                //           // Text(
                                //           //   "${index + 1}",
                                //           //   style: GoogleFonts.roboto(fontSize: 17.0),
                                //           // ),
                                //           // SizedBox(width: 4.0),
                                //           // Icon(Icons.star, color: Colors.orange),
                                //           // SizedBox(width: 2.0),
                                //           // Expanded(
                                //           //   child: LinearPercentIndicator(
                                //           //     lineHeight: 6.0,
                                //           //     // linearStrokeCap: LinearStrokeCap.roundAll,
                                //           //     // width: MediaQuery.of(context).size.width / 3,
                                //           //     animation: true,
                                //           //     animationDuration: 2500,
                                //           //     percent: ratings[index],
                                //           //     progressColor: Colors.orange,
                                //           //   ),
                                //           // ),
                                //         ],
                                //       );
                                //     },
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      ListView.separated(
                        reverse: true,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                        itemCount: list_review.length,
                        itemBuilder: (context, i) {
                          final x = list_review[i];
                          return ReviewUI(
                            image: x.photo_path,
                            name: x.name,
                            date: formatDate(
                                DateTime.parse(
                                  x.updated_at,
                                ),
                                [
                                  dd,
                                  ' ',
                                  M,
                                  ' ',
                                  yyyy,
                                  '   ',
                                  HH,
                                  ':',
                                  nn,
                                  ':',
                                  ss
                                ]),
                            comment: x.description,
                            rating: x.value,
                            image_path: x.image_path,
                            onPressed: () => print("More Action $i"),
                            onTap: () => setState(() {
                              isMore = !isMore;
                            }),
                            isLess: isMore,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 2.0,
                            color: kAccentColor,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
