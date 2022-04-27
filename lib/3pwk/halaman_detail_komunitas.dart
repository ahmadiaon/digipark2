import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart'; 
import 'package:digipark/0lainlain/modal.dart';  
import 'package:digipark/3pwk/mendaftar_komunitas.dart';
import 'package:digipark/skeleton/skeleton.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart'; 
import 'package:google_fonts/google_fonts.dart'; 
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart'; 
import '../widgets/handlinginet.dart';

class DetailKomunitas extends StatefulWidget {
  final CommunityModal list_community;
  DetailKomunitas(this.list_community);
  @override
  _DetailKomunitasState createState() => _DetailKomunitasState();
}

class _DetailKomunitasState extends State<DetailKomunitas> {
  bool _isPlaying = false;

  CarouselSliderController _sliderController;

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

  List<CommunityModal> list_komunitas = [];

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
    });
    //_lihatData();
  }

  String token = "";
  var datanya, image_path;
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
      list_komunitas.clear();
      setState(() {
        loading = true;
      });
      final response = await http.get(
          Uri.http('digiadministrator.falaraborneo.com',
              'api/v2/user/detail-community/' + widget.list_community.uuid),
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

        setState(() {
          loading = false;
        });
      }
      setState(() {
        loading = false;
      });
      print('Token : ${token}');
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HandlingInet(tampil_data: tampil_data)));
    }
  }

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
            widget.list_community.name,
            style: GoogleFonts.roboto(
                color: Colors.black87,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      floatingActionButton: Container(
        height: size.height * 0.05,
        child: FloatingActionButton.extended(
          // splashColor: Colors.green,
          onPressed: () async {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MendaftarKomunitas(
                    widget.list_community.uuid,
                    widget.list_community.name,
                    widget.list_community.path)));
          },
          label: Text(
            'Mendaftar',
            style: GoogleFonts.roboto(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
          ),
          icon: Icon(
            Icons.app_registration_rounded,
            color: Colors.white,
          ),
          backgroundColor: Color(0xFF18b15a),
        ),
      ),
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Color(0xFFFFC600),
        onRefresh: tampil_data,
        child: loading
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
                                          "http://digiadministrator.falaraborneo.com/" +
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
                                widget.list_community.name,
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
                                    widget.list_community.address,
                                    style: GoogleFonts.inter(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              widget.list_community.location == ""
                                  ? Container()
                                  : RaisedButton.icon(
                                      onPressed: () {
                                        launchURL(
                                            widget.list_community.location);
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
                              // Row(
                              //   children: <Widget>[
                              //     Container(
                              //       decoration: BoxDecoration(
                              //           border: Border.all(color: Colors.grey),
                              //           borderRadius: BorderRadius.circular(3)),
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(6.0),
                              //         child: SelectableText(
                              //           widget.list_community.kategori,
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
                              //     //       widget.list_community.alamat,
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
                                widget.list_community.description,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.inter(height: 1.6),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              widget.list_community.youtube == "" &&
                                      widget.list_community.instagram == "" &&
                                      widget.list_community.facebook == ""
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
                                  widget.list_community.instagram == ""
                                      ? Container()
                                      : Expanded(
                                          child: RaisedButton.icon(
                                            onPressed: () {
                                              openApp(
                                                  url: widget
                                                      .list_community.instagram,
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
                                  widget.list_community.youtube == ""
                                      ? Container()
                                      : widget.list_community.instagram == ""
                                          ? Container()
                                          : SizedBox(
                                              width: size.width * 0.02,
                                            ),
                                  widget.list_community.youtube == ""
                                      ? Container()
                                      : Expanded(
                                          child: RaisedButton.icon(
                                            onPressed: () {
                                              openApp(
                                                  url: widget
                                                      .list_community.youtube,
                                                  inApp: false);
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
                                  widget.list_community.facebook == ""
                                      ? Container()
                                      : Expanded(
                                          child: RaisedButton.icon(
                                            onPressed: () {
                                              openApp(
                                                  url: widget
                                                      .list_community.facebook,
                                                  inApp: false);
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
                                height: size.height * 0.06,
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
}
