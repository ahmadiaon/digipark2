import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digipark/0lainlain/custom_dialog.dart';
import 'package:digipark/0lainlain/modal.dart';
import 'package:digipark/0lainlain/textinputdecor.dart';
import 'package:digipark/env.dart';
import 'package:digipark/skeleton/skeleton.dart';
import 'package:digipark/widgets/constant.dart';
import 'package:digipark/widgets/reviewUI.dart';
import 'package:digipark/widgets/reviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:date_format/date_format.dart';
import 'package:async/async.dart';

import '../widgets/handlinginet.dart';

class DetailUmkm extends StatefulWidget {
  final BusinessModal list_business;
  DetailUmkm(this.list_business);
  @override
  _DetailUmkmState createState() => _DetailUmkmState();
}

class _DetailUmkmState extends State<DetailUmkm> {
  bool isMore = false;
  CarouselSliderController _sliderController;

  Future openApp({String url, bool inApp = false}) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: inApp,
        forceWebView: inApp,
        enableJavaScript: true,
      );
    }
  }

  launchURL(String url) async {
    // const String homeLat = "37.3230";
    // const String homeLng = "-122.0312";

    final String googleMapslocationUrl = url;

    final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

    if (await canLaunch(encodedURl)) {
      await launch(encodedURl);
    } else {
      print('Could not launch $encodedURl');
      throw 'Could not launch $encodedURl';
    }
  }

  openwhatsapp() async {
    var whatsapp = "+62" + widget.list_business.whatsapp;
    var whatsappURl_android = "whatsapp://send?phone=" +
        whatsapp +
        "&text=Saya melihat produk Anda pada aplikasi Digipark dan saya ingin memesan produk dari UMKM ini";
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

  File _imageFile_path;

  String description, rating;
  double value;
  String uuid, token;
  List<ReviewListModal> list_review = [];
  var loading = false;

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

  var datanya, image_path;
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
      setState(() {
        loading = true;
      });
      print(widget.list_business.uuid);
      final response = await http.get(
          Uri.http(URL,
              'api/v2/user/detail-business/' + widget.list_business.uuid),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      datanya = json.decode(response.body);
      if (datanya.length == 0) {
      } else {
        setState(() {
          // print('berhasil');
          // print(datanya['data']['image_path'][0]);

          image_path = datanya['data']['image_path'];

          // print(jsonDecode(datanya['data']['image_path']));
          //  final data = jsonDecode(x[index].image_path);

          // print(datanya['data']['photo_path']);
          // txtEmail = TextEditingController(text: datanya['data']['email']);
          // txtFull_name = TextEditingController(text: datanya['data']['name']);
          // txtPhone_number =
          //     TextEditingController(text: datanya['data']['phone_number']);
          // txt_avatar = datanya['data']['photo_path'];
        });
      }

      final response2 = await http.get(
          Uri.http(
              URL,
              'api/v2/user/business/' +
                  widget.list_business.uuid +
                  '/review/listLimit'),
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
          list_review.add(ab);
        });
        print(data['data']);
        setState(() {
          loading = false;
        });
      }

      print(response2);
      // print("response");
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HandlingInet(tampil_data: tampil_data)));
    }
  }

  final _key = new GlobalKey<FormState>();
  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      beri_ulasan();
    }
  }

  beri_ulasan() async {
    setState(() {
      loading = true;
      // tampil_data();
    });
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
      print(uuid);
      print(token);
      if (_imageFile_path == null) {
        var uri = Uri.parse(
            URL_HTTP+'/api/v2/user/business/' +
                widget.list_business.uuid +
                '/review');
        var request = http.MultipartRequest("POST", uri);
        request.fields['user_uuid'] = uuid;
        request.fields['value'] = value.toString();
        request.fields['description'] = description;
        request.headers["Authorization"] = 'Bearer $token';
        var response = await request.send();
        setState(() {
          tampil_data();
        });
        if (response.statusCode > 2) {
          print("image upload");
        } else {
          print("image failed");
        }
      } else {
        var stream =
            http.ByteStream(DelegatingStream.typed(_imageFile_path.openRead()));
        var length = await _imageFile_path.length();
        var uri = Uri.parse(
            URL_HTTP+'/api/v2/user/business/' +
                widget.list_business.uuid +
                '/review');
        var request = http.MultipartRequest("POST", uri);
        request.fields['user_uuid'] = uuid;
        request.fields['value'] = value.toString();
        request.files.add(http.MultipartFile("image_path", stream, length,
            filename: path.basename(_imageFile_path.path)));
        request.fields['description'] = description;
        request.headers["Authorization"] = 'Bearer $token';
        var response = await request.send();
        setState(() {
          tampil_data();
        });
        if (response.statusCode > 2) {
          print("image upload");
        } else {
          print("image failed");
        }
      }
    } else {
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => HandlingInet()));
    }
  }

  // startTime() async {
  //   var _duration = new Duration(seconds: 2);
  //    setState(() {
  //        loading = true;

  //       });
  //   return Timer(_duration, () {
  //      setState(() {
  //        loading = true;
  //        tampil_data();
  //       });

  //   });

  // }

  @override
  void initState() {
    super.initState();
    getPref();
    tampil_data();
    _sliderController = CarouselSliderController();
  }

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
            widget.list_business.name,
            style: GoogleFonts.roboto(
                color: Colors.black87,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      floatingActionButton: widget.list_business.whatsapp == ""
          ? Container()
          : Container(
              height: size.height * 0.05,
              child: FloatingActionButton.extended(
                // splashColor: Colors.green,
                onPressed: () async {
                  openwhatsapp();
                },
                label: Text(
                  'Pesan',
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                icon: Icon(
                  LineIcons.whatSApp,
                  color: Colors.white,
                ),
                backgroundColor: Color(0xFF18b15a),
              ),
            ),
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Color(0xFFFFC600),
        onRefresh: tampil_data,
        key: _refresh,
        child: loading
            // ? Center(
            //     heightFactor: 10,
            //     child: Container(
            //       height: 60,
            //       width: 60,
            //       child: CircularProgressIndicator(
            //         strokeWidth: 6,
            //         valueColor: AlwaysStoppedAnimation(Colors.grey[
            //             300]), // Defaults to the current Theme's accentColor.
            //         backgroundColor: Color(
            //             0xFFFFC600), // Defaults to the current Theme's backgroundColor.
            //       ),
            //     ))
            // :
            ? buildSkeletonDetail(context)
            : image_path == null
                ? buildSkeletonDetail(context)
                : ListView(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 16 / 9.8,
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: CarouselSlider.builder(
                            autoSliderDelay: Duration(seconds: 4),
                            autoSliderTransitionTime: Duration(seconds: 3),
                            // autoSliderTransitionCurve: Curves.easeInBack,
                            unlimitedMode: true,
                            controller: _sliderController,
                            slideBuilder: (index) {
                              return AspectRatio(
                                aspectRatio: 16 / 9,
                                child: ClipRRect(
                                    // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    child: Stack(
                                  children: <Widget>[
                                    CachedNetworkImage(
                                      imageUrl:
                                          URL_FULL +
                                              image_path[index],
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          AspectRatio(
                                              aspectRatio: 16 / 9,
                                              child:
                                                  buildSkeletonList(context)),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ],
                                )),
                              );
                            },
                            slideTransform: CubeTransform(),
                            slideIndicator: CircularSlideIndicator(
                              itemSpacing: 13,
                              indicatorRadius: 5,
                              indicatorBorderWidth: 0,
                              indicatorBackgroundColor: Colors.green[100],
                              currentIndicatorColor: Color(0xFF18b15a),
                              // padding: EdgeInsets.only(bottom: 32),
                              // indicatorBorderColor: Colors.black,
                            ),
                            itemCount: image_path.length,
                            initialPage: 0,
                            enableAutoSlider: true,
                          ),
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(top: size.height * 0.3),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SelectableText(
                                widget.list_business.name,
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    height: 1.5,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                width: size.width * 0.38,
                                height: size.height * 0.005,
                                decoration: BoxDecoration(
                                    color: Color(0xFFFFC600),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              SizedBox(
                                height: size.height * 0.0235,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    widget.list_business.address,
                                    style: GoogleFonts.inter(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Row(
                                children: [
                                  widget.list_business.location == ""
                                      ? Container()
                                      : Expanded(
                                          child: RaisedButton.icon(
                                            onPressed: () {
                                              launchURL(widget
                                                  .list_business.location);
                                            },
                                            icon: Icon(
                                              LineIcons.mapMarked,
                                              color: Colors.black87,
                                            ),
                                            label: Text(
                                              "Lihat di Peta",
                                              style: GoogleFonts.roboto(
                                                  color: Colors.black87,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ),
                                            color: Color(0xFFFFC600),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                        ),
                                  widget.list_business.location == ""
                                      ? Container()
                                      : SizedBox(
                                          width: size.width * 0.02,
                                        ),
                                  widget.list_business.qr_code == null
                                      ? Container()
                                      : Expanded(
                                          child: RaisedButton.icon(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        CustomDialog(
                                                  image: widget
                                                      .list_business.image_path,
                                                  title:
                                                      widget.list_business.name,
                                                  description:
                                                      "Scan untuk melakukan pembayaran pada UMKM " +
                                                          widget.list_business
                                                              .name,
                                                  buttonText: "Tutup",
                                                  qrcode: widget
                                                      .list_business.qr_code,
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              LineIcons.qrcode,
                                              color: Colors.black87,
                                            ),
                                            label: Text(
                                              "QR Code",
                                              style: GoogleFonts.roboto(
                                                  color: Colors.black87,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ),
                                            color: Color(0xFFFFC600),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                        ),
                                  // SizedBox(
                                  //   width: size.width * 0.02,
                                  // ),
                                  // RaisedButton.icon(
                                  //   onPressed: () {
                                  //     // Navigator.of(context).push(MaterialPageRoute(
                                  //     //     builder: (context) => HalamanKomunitas()));
                                  //   },
                                  //   icon: Icon(
                                  //     LineIcons.comment,
                                  //     color: Colors.black87,
                                  //   ),
                                  //   label: Text(
                                  //     "Ulasan",
                                  //     style: GoogleFonts.roboto(
                                  //         color: Colors.black87,
                                  //         fontSize: 13,
                                  //         fontWeight: FontWeight.w600),
                                  //     textAlign: TextAlign.center,
                                  //   ),
                                  //   color: Color(0xFFFFC600),
                                  //   shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(5)),
                                  // ),
                                ],
                              ),
                              // Row(
                              //   children: <Widget>[
                              //     Container(
                              //       decoration: BoxDecoration(
                              //           border: Border.all(color: Colors.grey),
                              //           borderRadius: BorderRadius.circular(3)),
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(6.0),
                              //         child: SelectableText(
                              //           widget.list_business.kategori,
                              //           style: GoogleFonts.inter(),
                              //         ),
                              //       ),
                              //     ),
                              //     // SizedBox(
                              //     //   width: size.width * 0.024,
                              //     // ),
                              //     // Container(
                              //     //   decoration: BoxDecoration(
                              //     //       border: Border.all(color: Colors.grey),
                              //     //       borderRadius: BorderRadius.circular(3)),
                              //     //   child: Padding(
                              //     //     padding: const EdgeInsets.all(6.0),
                              //     //     child: SelectableText(
                              //     //       widget.list_business.alamat,
                              //     //       style: GoogleFonts.inter(),
                              //     //     ),
                              //     //   ),
                              //     // ),
                              //   ],
                              // ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              SelectableText(
                                widget.list_business.description,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.inter(height: 1.6),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              widget.list_business.youtube == "" &&
                                      widget.list_business.instagram == "" &&
                                      widget.list_business.facebook == ""
                                  ? Container()
                                  : SelectableText(
                                      'Media Sosial',
                                      style: GoogleFonts.inter(
                                          fontSize: 17,
                                          height: 1.5,
                                          fontWeight: FontWeight.bold),
                                    ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Row(
                                children: [
                                  widget.list_business.instagram == ""
                                      ? Container()
                                      : Expanded(
                                          child: RaisedButton.icon(
                                            onPressed: () {
                                              openApp(
                                                  url: widget
                                                      .list_business.instagram,
                                                  inApp: false);
                                            },
                                            icon: Icon(
                                              LineIcons.instagram,
                                              color: Colors.black87,
                                            ),
                                            label: Text(
                                              "Instagram",
                                              style: GoogleFonts.roboto(
                                                  color: Colors.black87,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ),
                                            color: Color(0xFFFFC600),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                        ),
                                  widget.list_business.youtube == ""
                                      ? Container()
                                      : widget.list_business.instagram == ""
                                          ? Container()
                                          : SizedBox(
                                              width: size.width * 0.02,
                                            ),
                                  widget.list_business.youtube == ""
                                      ? Container()
                                      : Expanded(
                                          child: RaisedButton.icon(
                                            onPressed: () {
                                              setState(() {
                                                openApp(
                                                    url: widget
                                                        .list_business.youtube,
                                                    inApp: false);
                                              });
                                            },
                                            icon: Icon(
                                              LineIcons.youtube,
                                              color: Colors.black87,
                                            ),
                                            label: Text(
                                              "Youtube",
                                              style: GoogleFonts.roboto(
                                                  color: Colors.black87,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ),
                                            color: Color(0xFFFFC600),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                        ),
                                ],
                              ),
                              // SizedBox(
                              //   height: size.height * 0.02,
                              // ),
                              Row(
                                children: [
                                  widget.list_business.facebook == ""
                                      ? Container()
                                      : Expanded(
                                          child: RaisedButton.icon(
                                            onPressed: () {
                                              setState(() {
                                                // String user = "4HrweW4IqJc";
                                                openApp(
                                                    url: widget
                                                        .list_business.facebook,
                                                    inApp: false);
                                              });
                                            },
                                            icon: Icon(
                                              LineIcons.facebookSquare,
                                              color: Colors.black87,
                                            ),
                                            label: Text(
                                              "Facebook",
                                              style: GoogleFonts.roboto(
                                                  color: Colors.black87,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ),
                                            color: Color(0xFFFFC600),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.017,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Ulasan teratas",
                                    style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        height: 1.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Reviews(widget.list_business.uuid),
                                      ),
                                    ),
                                    child: Text(
                                      "Selengkapnya",
                                      style: GoogleFonts.roboto(
                                          color: Color(0xFF18b15a),
                                          fontSize: 15,
                                          height: 1.5,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              ListView.separated(
                                // reverse: true,
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
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              RaisedButton.icon(
                                onPressed: () {
                                  // final y = jsonDecode(
                                  //     widget.list_business.image_path);
                                  // final image = y[1];
                                  var size = MediaQuery.of(context).size;
                                  var placeholder_path = Container(
                                    child: Image.asset(
                                      "assets/images/gambar.png",
                                      width: size.width * 0.333,
                                      height: size.height * 0.105,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Consts.padding),
                                            ),
                                            elevation: 0.0,
                                            backgroundColor: Colors.transparent,
                                            child: StatefulBuilder(builder:
                                                (BuildContext context,
                                                    StateSetter setState) {
                                              return ListView(
                                                children: [
                                                  Stack(
                                                    children: <Widget>[
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: Consts
                                                                  .avatarRadius +
                                                              Consts.padding,
                                                          bottom:
                                                              Consts.padding,
                                                          left: Consts.padding,
                                                          right: Consts.padding,
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            top: Consts
                                                                .avatarRadius),
                                                        decoration:
                                                            new BoxDecoration(
                                                          color: Colors.white,
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(Consts
                                                                      .padding),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black12,
                                                              blurRadius: 10.0,
                                                              offset:
                                                                  const Offset(
                                                                      0.0,
                                                                      15.0),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  10.0,
                                                                  10.0,
                                                                  10.0,
                                                                  0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min, // To make the card compact
                                                            children: <Widget>[
                                                              Text(
                                                                widget
                                                                    .list_business
                                                                    .name,
                                                                style:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontSize:
                                                                      20.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    size.height *
                                                                        0.015,
                                                              ),
                                                              Text(
                                                                "Berikan penilaian & ulasan Anda pada UMKM " +
                                                                    widget
                                                                        .list_business
                                                                        .name,
                                                              ),
                                                              // SizedBox(
                                                              //   height: size.height * 0.015,
                                                              // ),
                                                              // Row(
                                                              //   children: [
                                                              //     Container(
                                                              //       height: 35.0,
                                                              //       width: 35.0,
                                                              //       margin: EdgeInsets.only(right: 12.0),
                                                              //       decoration: BoxDecoration(
                                                              //         image: DecorationImage(
                                                              //           image: AssetImage("assets/images/profil1.jpeg"),
                                                              //           fit: BoxFit.cover,
                                                              //         ),
                                                              //         borderRadius: BorderRadius.circular(44.0),
                                                              //       ),
                                                              //     ),
                                                              //     Expanded(
                                                              //       child: Text(
                                                              //         "Chandra Tirta",
                                                              //         style: GoogleFonts.roboto(
                                                              //           fontSize: 15.0,
                                                              //           fontWeight: FontWeight.bold,
                                                              //         ),
                                                              //       ),
                                                              //     ),
                                                              //     // IconButton(
                                                              //     //   onPressed: () {
                                                              //     //     // Navigator.of(context).push(MaterialPageRoute(
                                                              //     //     //     builder: (context) => BeriUlasan()));
                                                              //     //   },
                                                              //     //   icon: Icon(Icons.more_vert),
                                                              //     // ),
                                                              //   ],
                                                              // ),
                                                              SizedBox(
                                                                height:
                                                                    size.height *
                                                                        0.015,
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    size.height *
                                                                        0.015,
                                                              ),
                                                              Form(
                                                                key: _key,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    TextFormField(
                                                                      style: GoogleFonts.inter(
                                                                          color:
                                                                              Color(0xFF414141)),
                                                                      maxLength:
                                                                          1000,
                                                                      maxLines:
                                                                          7,
                                                                      validator:
                                                                          (e) {
                                                                        if (e.length <
                                                                                3 &&
                                                                            e.length >
                                                                                0) {
                                                                          return "Masukkan minimal 3 karakter";
                                                                        }
                                                                        if (e
                                                                            .isEmpty) {
                                                                          return "Komentar kosong, silahkan masukkan";
                                                                        }
                                                                      },
                                                                      onSaved: (e) =>
                                                                          description =
                                                                              e,
                                                                      decoration: textInputDecoration.copyWith(
                                                                          labelText:
                                                                              "Komentar",
                                                                          hintText:
                                                                              "Maksimal 1000 karakter"),
                                                                    ),
                                                                    SizedBox(
                                                                      height: size
                                                                              .height *
                                                                          0.015,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        SmoothStarRating(
                                                                          rating:
                                                                              0,
                                                                          onRated: (e) =>
                                                                              value = e,
                                                                          // onRated: (v) {
                                                                          //   setState(() {
                                                                          //     value;
                                                                          //   });
                                                                          // },
                                                                          starCount:
                                                                              5,

                                                                          size:
                                                                              50.0,
                                                                          color:
                                                                              Colors.orange,
                                                                          borderColor:
                                                                              Colors.orange,
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                kFixPadding),
                                                                        // Text(
                                                                        //   date,
                                                                        //   style: GoogleFonts.roboto(fontSize: 14.0, fontWeight: FontWeight.w600,),
                                                                        // ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    size.height *
                                                                        0.015,
                                                              ),
                                                              Column(
                                                                children: <
                                                                    Widget>[
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Future
                                                                              pickImage_path(ImageSource source) async {
                                                                            var size =
                                                                                MediaQuery.of(context).size;
                                                                            try {
                                                                              final image = await ImagePicker().pickImage(source: source, imageQuality: 50);
                                                                              if (image == null)
                                                                                return;

                                                                              final imageTemporary = File(image.path);
                                                                              // setState(() => this._imageFile_path = imageTemporary);
                                                                              setState(() {
                                                                                this._imageFile_path = imageTemporary;
                                                                                Image.file(_imageFile_path, width: size.width * 0.333, height: size.height * 0.105, fit: BoxFit.cover);
                                                                              });
                                                                            } on PlatformException catch (e) {
                                                                              print('Failed to pick image: $e');
                                                                            }
                                                                          }

                                                                          setState(
                                                                              () {
                                                                            pickImage_path(ImageSource.gallery);
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          child: ClipRRect(
                                                                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                                              child: _imageFile_path != null ? Image.file(_imageFile_path, width: size.width * 0.333, height: size.height * 0.105, fit: BoxFit.cover) : placeholder_path),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: size.width *
                                                                            0.04,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          child: Text(
                                                                              'Silahkan upload gambar ulasan (opsional)',
                                                                              style: GoogleFonts.inter(color: Colors.black87, fontSize: 13)),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    size.height *
                                                                        0.01,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: size
                                                                            .width *
                                                                        0.04,
                                                                  ),
                                                                  GestureDetector(
                                                                    child: Text(
                                                                        "Pilih Foto",
                                                                        style: GoogleFonts.inter(
                                                                            color:
                                                                                Color(0xFF18b15a),
                                                                            fontWeight: FontWeight.w600)),
                                                                    onTap: () {
                                                                      Future pickImage_path(
                                                                          ImageSource
                                                                              source) async {
                                                                        var size =
                                                                            MediaQuery.of(context).size;
                                                                        try {
                                                                          final image = await ImagePicker().pickImage(
                                                                              source: source,
                                                                              imageQuality: 50);
                                                                          if (image ==
                                                                              null)
                                                                            return;

                                                                          final imageTemporary =
                                                                              File(image.path);
                                                                          // setState(() => this._imageFile_path = imageTemporary);
                                                                          setState(
                                                                              () {
                                                                            this._imageFile_path =
                                                                                imageTemporary;
                                                                            Image.file(_imageFile_path,
                                                                                width: size.width * 0.333,
                                                                                height: size.height * 0.105,
                                                                                fit: BoxFit.cover);
                                                                          });
                                                                        } on PlatformException catch (e) {
                                                                          print(
                                                                              'Failed to pick image: $e');
                                                                        }
                                                                      }

                                                                      setState(
                                                                          () {
                                                                        pickImage_path(
                                                                            ImageSource.gallery);
                                                                      });
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    size.height *
                                                                        0.02,
                                                              ),
                                                              Center(
                                                                child: SizedBox(
                                                                  width:
                                                                      size.width *
                                                                          0.99,
                                                                  height:
                                                                      size.height *
                                                                          0.050,
                                                                  child:
                                                                      RaisedButton(
                                                                    color: Color(
                                                                        0xFF18b15a),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(50)),
                                                                    onPressed:
                                                                        () {
                                                                      check();
                                                                      setState(
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      });
                                                                    },
                                                                    child: Text(
                                                                      "Kirim ulasan",
                                                                      style: GoogleFonts.inter(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment: Alignment
                                                                    .bottomCenter,
                                                                child:
                                                                    FlatButton(
                                                                  textColor: Color(
                                                                      0xFF18b15a),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(); // To close the dialog
                                                                  },
                                                                  child: Text(
                                                                      "Tutup"),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 8.0),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: Consts.padding,
                                                        right: Consts.padding,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: Consts
                                                              .avatarRadius,
                                                          child: ClipOval(
                                                            child:
                                                                CachedNetworkImage(
                                                              height: 120,
                                                              width: 120,
                                                              imageUrl: URL_FULL +
                                                                  widget
                                                                      .list_business
                                                                      .image_path,
                                                              fit: BoxFit.cover,
                                                              //                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                              // CircularProgressIndicator(value: downloadProgress.progress),
                                                              placeholder: (context,
                                                                      url) =>
                                                                  buildSkeletonPhotoReview(
                                                                      context),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Icon(Icons
                                                                      .error),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            }),
                                          );
                                        });
                                      });
                                },
                                icon: Icon(
                                  LineIcons.comment,
                                  color: Colors.black87,
                                ),
                                label: Text(
                                  "Beri Ulasan",
                                  style: GoogleFonts.roboto(
                                      color: Colors.black87,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                                color: Color(0xFFFFC600),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              SizedBox(
                                height: size.height * 0.04,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  // dialogContent(BuildContext context) {
  //   var size = MediaQuery.of(context).size;
  //   var placeholder_path = Container(
  //     child: Image.asset(
  //       "assets/images/ktp.png",
  //       width: size.width * 0.333,
  //       height: size.height * 0.105,
  //       fit: BoxFit.cover,
  //     ),
  //   );
  //   retur
  // }
}

class Consts {
  Consts._();

  static const double padding = 10.0;
  static const double avatarRadius = 66.0;
}
