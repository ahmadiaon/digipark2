import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart'; 
import 'package:digipark/0lainlain/modal.dart';  
import 'package:digipark/2menu/drawer.dart';
import 'package:digipark/8video/halaman_video.dart';
import 'package:digipark/env.dart';
import 'package:digipark/skeleton/skeleton.dart';
import 'package:digipark/3pwk/halaman_detail_komunitas.dart';
import 'package:digipark/3pwk/halaman_komunitas.dart';
import 'package:digipark/4wisata/halaman_detail_wisata.dart';
import 'package:digipark/4wisata/halaman_wisata.dart';
import 'package:digipark/5umkm/halaman_detail_umkm.dart';
import 'package:digipark/5umkm/halaman_umkm.dart';
import 'package:digipark/6info/halaman_detail_info.dart';
import 'package:digipark/6info/halaman_info.dart';
import 'package:digipark/7bank/halaman_bank.dart';
import 'package:digipark/7bank/halaman_detail_bank.dart';
import 'package:digipark/widgets/handlinginet.dart'; 
import 'package:flutter/material.dart'; 
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'dart:io';
import 'package:http/http.dart' as http; 
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart'; 
import 'package:line_icons/line_icons.dart';

class MenuUtama extends StatefulWidget {
  MenuUtama({Key key, this.title, this.signOut}) : super(key: key);
  final String title;
  final VoidCallback signOut;
  @override
  _MenuUtamaState createState() => _MenuUtamaState();
}

class _MenuUtamaState extends State<MenuUtama> {
  String phone_number = "", token = "", uuid = "", role = "";
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  int _selectedIndex = 0; //default index
  Widget _currentPage;

  List<Widget> _widgetOptions;
  Widget _page1;
  Widget _page2;
  Widget _page3;
  Widget _page4;
  Widget _page5;

  onNext_manu2() async {
    setState(() {
      _selectedIndex = 1;
      _currentPage = _page2;
      // _widgetOptions.elementAt(1);
    });
  }

  onNext_manu3() async {
    setState(() {
      _selectedIndex = 2;
      _currentPage = _page3;
      // _widgetOptions.elementAt(2);
    });
  }

  onNext_manu4() async {
    setState(() {
      _selectedIndex = 3;
      _currentPage = _page4;
      // _widgetOptions.elementAt(3);
    });
  }

  onNext_manu5() async {
    setState(() {
      _selectedIndex = 4;
      _currentPage = _page5;
      // _widgetOptions.elementAt(1);
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      print("freeeeeeeeeeeeeeeeeeeeeep : ");
      print(URL);
      phone_number = preferences.getString("phone_number");
      token = preferences.getString("token");
      uuid = preferences.getString("uuid");
      role = preferences.getString("role");
    });
    //_lihatData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _page1 = CarouselWithIndicatorDemo(
        onNext_manu2: onNext_manu2,
        onNext_manu3: onNext_manu3,
        onNext_manu4: onNext_manu4,
        onNext_manu5: onNext_manu5);
    _page2 = HalamanKomunitas();
    _page3 = HalamanWisata();
    _page4 = HalamanUmkm();
    _page5 = HalamanBank();
    getPref();
    // print(phone_number);
    // print(token);
    // print(uuid);
    // tampil_data();

    _widgetOptions = [_page1, _page2, _page3, _page4, _page5];

    _selectedIndex = 0;
    _currentPage = _page1;
  }

  DateTime backbuttonpressedTime;

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButton = backbuttonpressedTime == null ||
        currentTime.difference(backbuttonpressedTime) > Duration(seconds: 2);

    if (backButton) {
      backbuttonpressedTime = currentTime;
      Fluttertoast.showToast(
        msg: "Tekan kembali lagi untuk keluar",
      );
      return false;
    }
    exit(0);
  }

  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
      _currentPage = _widgetOptions[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.052),
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          automaticallyImplyLeading: false,
          elevation: 0,
          // flexibleSpace: Container(
          //   margin: EdgeInsets.only(top: size.height * 0.040),
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       // colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop),
          //       image: AssetImage(
          //         'assets/images/digipark_black.png',
          //       ),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          backgroundColor: Color(0xFFFFC600),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Container(
                    width: size.width * 0.25,
                    child: Image.asset('assets/images/digipark_black.png')),
              ),
            ],
          ),
          // actions: <Widget>[
          //   Container(
          //     // margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
          //     child: Stack(
          //       children: <Widget>[

          //         Positioned(
          //           right: 2.0,
          //           bottom: 5.0,
          //           child: Stack(
          //             children: <Widget>[
          //               IconButton(
          //                 onPressed: () {
          //                   // Navigator.of(context).push(MaterialPageRoute(
          //                   //     builder: (context) =>
          //                   //         NotifMasya(_jumlahNotif)));
          //                 },
          //                 icon: Icon(Icons.brightness_1),
          //                 iconSize: 41,
          //                 // Icons.brightness_1,
          //                 // size: 25.0,
          //                 color: Color(0xFF18b15a),
          //               ),
          //               // Positioned(
          //               //   top: 16.0,
          //               //   right: 20.0,
          //               //   child: Text(
          //               //     'jumlah_notif',
          //               //     style: TextStyle(
          //               //         color: Colors.white,
          //               //         fontSize: 13.0,
          //               //         fontWeight: FontWeight.bold),
          //               //   ),
          //               // )
          //             ],
          //           ),
          //         ),
          //         IconButton(
          //           onPressed: () {
          //             // Navigator.of(context).push(MaterialPageRoute(
          //             //     builder: (context) => NotifMasya(_jumlahNotif)));
          //           },
          //           icon: Icon(Icons.notifications),
          //         ),
          //         Positioned(
          //                 top: 30.0,
          //                 left: 0.0,
          //                 right: 0.0,
          //                 child: Text(
          //                   'Belum Login',
          //                   style: TextStyle(
          //                       color: Colors.white,
          //                       fontSize: 13.0,
          //                       fontWeight: FontWeight.bold),
          //                 ),
          //               )

          //       ],
          //     ),
          //   ),
          // ],
        ),
      ),
      endDrawer: Drawer_siderbar(signOut: signOut),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 10,
        child: Container(
          height: 48,
          child: GNav(
              rippleColor: Color(0xFFFFC600),
              hoverColor: Colors.grey[300],
              gap: 8,
              activeColor: Colors.black87,
              // iconSize: 24,
              curve: Curves.easeOutExpo,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Color(0xFFFFC600),
              backgroundColor: Colors.white,
              color: Colors.black, // navigation bar padding
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                  iconSize: 24,
                  textStyle: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600),
                ),
                GButton(
                  icon: LineIcons.users,
                  text: 'PWK',
                  iconSize: 26,
                  textStyle: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600),
                ),
                GButton(
                  icon: LineIcons.mapMarked,
                  text: 'Wisata',
                  iconSize: 24,
                  textStyle: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600),
                ),
                GButton(
                  icon: LineIcons.store,
                  text: 'UMKM',
                  iconSize: 24,
                  textStyle: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600),
                ),
                GButton(
                  icon: LineIcons.university,
                  text: 'Bank',
                  iconSize: 26,
                  textStyle: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600),
                )
              ]),
        ),
      ),
    );
  }

  // Widget getBody() {
  //   var size = MediaQuery.of(context).size;
  //   return GetMaterialApp(
  //     initialRoute: AppRoutes.HOME,
  //     getPages: AppPages.list,
  //     debugShowCheckedModeBanner: false,
  //     themeMode: ThemeMode.system,
  //   );
  // }
}

// final List<String> imgList = [
//   'assets/images/contoh3.jpg',
//   'assets/images/contoh4.jpg',
//   'assets/images/contoh5.jpg',
//   'assets/images/contoh6.jpg',
//   'assets/images/contoh7.jpg',
// ];

// final List<Widget> imageSliders = imgList
//     .map((item) => Container(
//           child: Container(
//             // margin: EdgeInsets.all(5.0),
//             child: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 child: Stack(
//                   children: <Widget>[
//                     // Image.network(item, fit: BoxFit.cover, width: 1000.0),
//                     Image.asset(item, fit: BoxFit.cover, width: 1000.0),
//                     Positioned(
//                       bottom: 0.0,
//                       left: 0.0,
//                       right: 0.0,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               Color.fromARGB(200, 0, 0, 0),
//                               Color.fromARGB(0, 0, 0, 0)
//                             ],
//                             begin: Alignment.topCenter,
//                             end: Alignment.topCenter,
//                           ),
//                         ),
//                         padding: EdgeInsets.symmetric(
//                             vertical: 10.0, horizontal: 20.0),
//                         child: Text(
//                           'No. ${imgList.indexOf(item) + 1} image',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )),
//           ),
//         ))
//     .toList();

class CarouselWithIndicatorDemo extends StatefulWidget {
  final VoidCallback onNext_manu2;
  final VoidCallback onNext_manu3;
  final VoidCallback onNext_manu4;
  final VoidCallback onNext_manu5;

  const CarouselWithIndicatorDemo(
      {Key key,
      this.onNext_manu2,
      this.onNext_manu3,
      this.onNext_manu4,
      this.onNext_manu5})
      : super(key: key);
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
  // State<StatefulWidget> createState() {
  //   return _CarouselWithIndicatorState();
  // }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  onNext_manu2() {
    setState(() {
      widget.onNext_manu2();
    });
  }

  onNext_manu3() {
    setState(() {
      widget.onNext_manu3();
    });
  }

  onNext_manu4() {
    setState(() {
      widget.onNext_manu4();
    });
  }

  onNext_manu5() {
    setState(() {
      widget.onNext_manu5();
    });
  }

  int _current = 0;
  final CarouselController _controller = CarouselController();

  int _selectedIndex = 0; //default index
  Widget _currentPage;

  List<Widget> _widgetOptions;
  Widget _page1;
  Widget _page2;
  Widget _page3;
  Widget _page4;
  Widget _page5;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _page1 = CarouselWithIndicatorDemo();
  //   _page2 = HalamanAwal();
  //   _page3 = CarouselWithIndicatorDemo();
  //   _page4 = HalamanAwal();
  //   _page5 = CarouselWithIndicatorDemo();

  //   _widgetOptions = [_page1, _page2, _page3, _page4, _page5];

  //   _selectedIndex = 0;
  //   _currentPage = _page1;
  // }

  // void changeTab(int index) {
  //   setState(() {
  //     _selectedIndex = index + 1;
  //     _currentPage = _widgetOptions[index];
  //     _tabController.animateTo(_tabIndex);
  //   });
  // }

  // int _tabIndex = 0;

  // TabController _tabController;
  // List<IsiKomunitas> list_community;
  // List<IsiWisata> data_wisata;
  // List<IsiUmkm> data_umkm;
  // List<IsiInfo> data_info;
  // List<IsiBank> data_bank;

  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
      _currentPage = _widgetOptions[index];
    });
  }

  String phone_number = "", token = "", uuid = "", role = "";
  List<SlideModal> _list_slide = [];

  List<CommunityModal> list_community = [];
  List<GalleryModal> list_gallery = [];
  List<TourModal> list_tour = [];
  List<FinancialModal> list_financial = [];
  List<BusinessModal> list_business = [];
  List<NewsModal> list_news = [];
  List<Youtube> list_youtube = [];

  var loading = false;
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  Future<void> tampil_data() async {
    // print(token);
    var koneksi;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //print('connected');
        koneksi = 1;
      }
    } on SocketException catch (_) {
      //print('not connected');
      koneksi = 0;
    }

    if (koneksi == 1) {
      _list_slide.clear();
      list_community.clear();
      list_tour.clear();
      list_financial.clear();
      list_business.clear();
      setState(() {
        loading = true;
      });
      final response = await http.get(
          Uri.http(
              URL, 'api/v2/user/slide/list'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            "phone": phone_number,
          });
      if (response.contentLength == 2) {
      } else {
        final data = jsonDecode(response.body);
        // print(data);
        // String message = data['meta']['message'];
        // print(message);
        data['data'].forEach((api) {
          final ab = new SlideModal(
            api['id'],
            api['uuid'],
            api['gallery_uuid'],
            api['admin_uuid'],
            api['title'],
            api['status'],
            api['created_at'],
            api['updated_at'],
            api['path'],
          );
          _list_slide.add(ab);
        });
        // print(data['data']);
        setState(() {
          loading = false;
        });
      }
      //print('Token : ${token}');
      print('UUID : ${uuid}');
      //print('Role : ${role}');

      final response2 = await http.get(
          Uri.http(URL,
              'api/v2/user/community/list'),
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
          final ab = new CommunityModal(
            api['id'],
            api['uuid'],
            api['community_category_uuid'],
            api['name'],
            api['logo_path'],
            api['address'],
            api['city'],
            api['province'],
            api['description'],
            api['image_path'],
            api['location'],
            api['facebook'],
            api['instagram'],
            api['youtube'],
            api['status'],
            api['created_at'],
            api['updated_at'],
            api['path'],
          );
          list_community.add(ab);
        });

        //print(data['data']);
        setState(() {
          loading = false;
        });
      }

      final response5 = await http.get(
          Uri.http(
              URL, 'api/v2/user/tour/list'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            // "phone": phone_number,
          });
      if (response5.contentLength == 2) {
      } else {
        final data = jsonDecode(response5.body);
        // print(data);
        // String message = data['meta']['message'];
        // print(message);

        data['data'].forEach((api) {
          final ab = new TourModal(
            api['id'],
            api['uuid'],
            api['name'],
            api['address'],
            api['city'],
            api['province'],
            api['description'],
            api['image_path'],
            api['location'],
            api['facebook'],
            api['instagram'],
            api['youtube'],
            api['status'],
            api['created_at'],
            api['updated_at'],
          );
          list_tour.add(ab);
        });

        print(data['data']);
        setState(() {
          loading = false;
        });
      }

      final response3 = await http.get(
          Uri.http(URL,
              'api/v2/user/financial-service/list'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            // "phone": phone_number,
          });
      if (response3.contentLength == 2) {
      } else {
        final data = jsonDecode(response3.body);
        // print(data);
        // String message = data['meta']['message'];
        // print(message);
        data['data'].forEach((api) {
          final ab = new FinancialModal(
            api['id'],
            api['uuid'],
            api['name'],
            api['logo_path'],
            api['address'],
            api['city'],
            api['province'],
            api['description'],
            api['image_path'],
            api['location'],
            api['facebook'],
            api['instagram'],
            api['youtube'],
            api['status'],
            api['created_at'],
            api['updated_at'],
            api['path'],
          );
          list_financial.add(ab);
        });
        //print(data['data']);
        setState(() {
          loading = false;
        });
      }

      final response4 = await http.get(
          Uri.http(URL,
              'api/v2/user/business/list'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            // "phone": phone_number,
          });
      if (response4.contentLength == 2) {
      } else {
        final data = jsonDecode(response4.body);
        // print(data);
        // String message = data['meta']['message'];
        // print(message);
        data['data'].forEach((api) {
          final ab = new BusinessModal(
            api['id'],
            api['uuid'],
            api['business_category_uuid'],
            api['name'],
            api['address'],
            api['city'],
            api['province'],
            api['description'],
            api['image_path'],
            api['location'],
            api['facebook'],
            api['instagram'],
            api['youtube'],
            api['whatsapp'],
            api['qr_code'],
            api['category'],
            api['status'],
            api['created_at'],
            api['updated_at'],
          );
          list_business.add(ab);
        });
        //print(data['data']);
        setState(() {
          loading = false;
        });
      }

      final response6 = await http.get(
          Uri.http(URL,
              'api/v2/user/news/list/single'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            // "phone": phone_number,
          });
      if (response6.contentLength == 2) {
      } else {
        final data = jsonDecode(response6.body);
        // print(data);
        // String message = data['meta']['message'];
        // print(message);
        data['data'].forEach((api) {
          final ab = new NewsModal(
            api['id'],
            api['uuid'],
            api['title'],
            api['content'],
            api['image_path'],
            api['status'],
            api['created_at'],
            api['updated_at'],
          );
          list_news.add(ab);
        });
        //print(data['data']);
        setState(() {
          loading = false;
        });
      }

      final response7 = await http.get(
          Uri.http(
              URL, 'api/v2/user/youtube/list'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            // "phone": phone_number,
          });
      if (response7.contentLength == 2) {
      } else {
        final data = jsonDecode(response7.body);
        // print(data);
        // String message = data['meta']['message'];
        // print(message);
        data['data'].forEach((api) {
          final ab = new Youtube(
            api['id'],
            api['uuid'],
            api['name'],
            api['url'],
            api['url_thumbnail'],
            api['status'],
            api['created_at'],
            api['updated_at'],
          );
          list_youtube.add(ab);
        });
        //print(data['data']);
        setState(() {
          loading = false;
        });
      }
      // print("response");
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HandlingInet(tampil_data: tampil_data)));
    }
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      phone_number = preferences.getString("phone_number");
      token = preferences.getString("token");
      uuid = preferences.getString("uuid");
      role = preferences.getString("role");
    });
    //_lihatData();
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

  String getYoutubeThumbnail(String videoUrl) {
    final Uri uri = Uri.tryParse(videoUrl);
    if (uri == null) {
      return null;
    }

    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }

  @override
  void initState() {
    // list_community = menu_komunitas;
    // data_wisata = menu_wisata;
    // data_umkm = menu_umkm;
    // data_info = menu_info;
    // data_bank = menu_bank;
    getPref();
    tampil_data();
    //print(phone_number);
    //print(token);
    //print(uuid);
  }

  // void _toggleTab() {
  //   _tabIndex = _tabController.index + 1;
  //   _tabController.animateTo(_tabIndex);
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return RefreshIndicator(
      backgroundColor: Colors.white,
      color: Color(0xFFFFC600),
      onRefresh: tampil_data,
      key: _refresh,
      child: loading
          ? buildSkeletonMenuUtama(context)
          : _list_slide.length == 0
              ? buildSkeletonMenuUtama(context)
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
              : Theme(
                  data: Theme.of(context).copyWith(
                      scrollbarTheme: ScrollbarThemeData(
                    thumbColor: MaterialStateProperty.all(Color(0xFF18b15a)),
                  )),
                  child: Scrollbar(
                    thickness: 3,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: CarouselSlider.builder(
                            // items: imageSliders,
                            itemCount: _list_slide.length,
                            itemBuilder: (context, i, realIndex) {
                              final x = _list_slide[i];

                              return Container(
                                child: Row(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) => DetailBeritaProvinsi(
                                        //               index: index,
                                        //             )));
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                child: Stack(
                                                  children: <Widget>[
                                                    CachedNetworkImage(
                                                      imageUrl:
                                                          URL_FULL+
                                                              x.path,
                                                      fit: BoxFit.cover,
                                                      width: 1000.0,
                                                      placeholder: (context,
                                                              url) =>
                                                          buildSkeletonSlide(
                                                              context),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                    // Image.asset(
                                                    //     carousel_slide[index].gambar,
                                                    //     fit: BoxFit.cover,
                                                    //     width: 1000.0),
                                                    // Positioned(
                                                    //   bottom: 0.0,
                                                    //   left: 0.0,
                                                    //   right: 0.0,
                                                    //   child: Container(
                                                    //     decoration: BoxDecoration(
                                                    //       gradient: LinearGradient(
                                                    //         colors: [
                                                    //           Color.fromARGB(255, 0, 83, 163),
                                                    //           Color.fromARGB(0, 0, 83, 163)
                                                    //         ],
                                                    //         begin: Alignment.bottomCenter,
                                                    //         end: Alignment.topCenter,
                                                    //       ),
                                                    //     ),
                                                    //     padding: EdgeInsets.symmetric(
                                                    //         vertical: 10.0, horizontal: 20.0),
                                                    //     child: Text(
                                                    //       x.gallery_uuid,
                                                    //       maxLines: 2,
                                                    //       overflow: TextOverflow.ellipsis,
                                                    //       style: GoogleFonts.inter(
                                                    //         color: Colors.white,
                                                    //         fontSize: 20.0,
                                                    //         fontWeight: FontWeight.bold,
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // IconButton(
                                    //   onPressed: () {},
                                    //   icon: Icon(
                                    //     Icons.add_circle,
                                    //     color: Colors.brown[600],
                                    //     size: 36,
                                    //   ),
                                    // )
                                  ],
                                ),
                              );
                            },
                            carouselController: _controller,
                            options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 16 / 9,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children:
                                    _list_slide.asMap().entries.map((entry) {
                                  return GestureDetector(
                                    onTap: () =>
                                        _controller.animateToPage(entry.key),
                                    child: Container(
                                      width: size.height * 0.01,
                                      height: size.height * 0.01,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: (Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Color(0xFF18b15a)
                                                  : Color.fromRGBO(0, 0, 0, 0))
                                              .withOpacity(_current == entry.key
                                                  ? 1
                                                  : 0.2)),
                                    ),
                                  );
                                }).toList(),
                              ),
                              // GestureDetector(
                              //   child: Text(
                              //     'Selengkapnya...',
                              //     style: GoogleFonts.roboto(
                              //         color: Color(0xFF18b15a),
                              //         fontSize: 12.0,
                              //         fontWeight: FontWeight.w800),
                              //   ),
                              //   onTap: () {
                              //     Navigator.of(context).push(MaterialPageRoute(
                              //         builder: (context) => BeritaProvinsi()));
                              //   },
                              // )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                         AspectRatio(
                          aspectRatio: 16 / 3.2,
                          child: Container(
                            // color: Color(0xFF18b15a),
                            // height: size.height * 0.12,
                            margin: const EdgeInsets.only(
                                left: 14, right: 14, top: 0, bottom: 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            onNext_manu2();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  10, 10, 10, 10),
                                              child: Image.asset(
                                                "assets/images/1pwk.png",
                                                // height: size.height * 0.10,
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Text(
                                          'PWK',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              color: Colors.black87,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            onNext_manu3();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  10, 10, 10, 10),
                                              child: Image.asset(
                                                "assets/images/2wisata.png",
                                                // height: size.height * 0.10,
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Text(
                                          'Wisata',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              color: Colors.black87,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            onNext_manu4();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  10, 10, 10, 10),
                                              child: Image.asset(
                                                "assets/images/3umkm.png",
                                                // height: size.height * 0.10,
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Text(
                                          'UMKM',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              color: Colors.black87,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HalamanInfo()));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  10, 10, 10, 10),
                                              child: Image.asset(
                                                "assets/images/4info.png",
                                                // height: size.height * 0.10,
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Text(
                                          'Info',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              color: Colors.black87,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            onNext_manu5();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  10, 10, 10, 10),
                                              child: Image.asset(
                                                "assets/images/5bank.png",
                                                // height: size.height * 0.10,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Text(
                                          'Bank',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              color: Colors.black87,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //         child: Text(
                        //           'PWK',
                        //           textAlign: TextAlign.center,
                        //           style: GoogleFonts.roboto(
                        //               color: Colors.black87,
                        //               fontSize: 13.0,
                        //               fontWeight: FontWeight.w700),
                        //         ),
                        //       ),
                        //       Expanded(
                        //         child: Text(
                        //           'Wisata',
                        //           textAlign: TextAlign.center,
                        //           style: GoogleFonts.roboto(
                        //               color: Colors.black87,
                        //               fontSize: 13.0,
                        //               fontWeight: FontWeight.w700),
                        //         ),
                        //       ),
                        //       Expanded(
                        //         child: Text(
                        //           'UMKM',
                        //           textAlign: TextAlign.center,
                        //           style: GoogleFonts.roboto(
                        //               color: Colors.black87,
                        //               fontSize: 13.0,
                        //               fontWeight: FontWeight.w700),
                        //         ),
                        //       ),
                        //       Expanded(
                        //         child: Text(
                        //           'Info',
                        //           textAlign: TextAlign.center,
                        //           style: GoogleFonts.roboto(
                        //               color: Colors.black87,
                        //               fontSize: 13.0,
                        //               fontWeight: FontWeight.w700),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: size.height * 0.268,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      AspectRatio(
                                        aspectRatio: 20 / 6,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //   bottom: 5.0,
                                      //   left: 0.0,
                                      //   // right: 0.0,
                                      //   child: Image.asset('assets/images/line.png',
                                      //       height: size.height * 0.02,
                                      //       color: Color(0xFF18b15a),
                                      //       fit: BoxFit.fitHeight),
                                      // ),
                                      Positioned(
                                        bottom: size.height * 0.010,
                                        left: 0.0,
                                        // right: 0.0,
                                        child: Image.asset(
                                            'assets/images/line2.png',
                                            height: size.height * 0.008,
                                            color: Color(0xFF18b15a),
                                            fit: BoxFit.fitHeight),
                                      ),
                                      Positioned(
                                        top: 19,
                                        bottom: 3.0,
                                        left: 0.0,
                                        right: 0.0,
                                        // top: size.height * 0.01,
                                        child: Text(
                                          'Komunitas',
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black87,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        AspectRatio(
                          aspectRatio: 16 / 9.5,
                          child: Container(
                            color: Color(0xFFFFC600),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 20, top: 15, bottom: 15),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    scrollbarTheme: ScrollbarThemeData(
                                  thumbColor: MaterialStateProperty.all(
                                      Color(0xFF18b15a)),
                                )),
                                child: Scrollbar(
                                  thickness: 3,
                                  // isAlwaysShown: true,
                                  child: ListView.builder(
                                    // padding: EdgeInsets.only(left: 16),
                                    itemCount: list_community.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      final x = list_community[i];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailKomunitas(
                                                        // daftarkmunitas: index,
                                                        x),
                                              ));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 16),
                                          width: size.height * 0.268,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Stack(
                                                children: <Widget>[
                                                  AspectRatio(
                                                    aspectRatio: 16 / 9,
                                                    child: Container(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              URL_HTTP + "/"+
                                                                  x.image_path,
                                                          //                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                          // CircularProgressIndicator(value: downloadProgress.progress),
                                                          placeholder: (context,
                                                                  url) =>
                                                              buildSkeletonSlide(
                                                                  context),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    child: SvgPicture.asset(
                                                        'assets/svg/travlog_top_corner.svg',
                                                        color: Colors.white70),
                                                    right: size.height * 0,
                                                  ),
                                                  Positioned(
                                                    top: size.height * 0.006,
                                                    right: size.height * 0.005,
                                                    child: Container(
                                                      width:
                                                          size.height * 0.050,
                                                      child: Image.asset(
                                                          'assets/images/logo.png',
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: size.height * 0,
                                                    child: SvgPicture.asset(
                                                        'assets/svg/travlog_bottom_gradient.svg',
                                                        fit: BoxFit.fitWidth,
                                                        width:
                                                            size.height * 0.268,
                                                        color:
                                                            Color(0xFF18b15a)),
                                                  ),
                                                  Positioned(
                                                    bottom:
                                                        size.height * 0.0095,
                                                    left: size.height * 0.0095,
                                                    right: size.height * 0.0095,
                                                    child: Text(
                                                      x.name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color: Color(
                                                              0xFFFFFFFF)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height * 0.0095,
                                              ),
                                              // Text(carousel_slide[index].sumber,
                                              //     maxLines: 1,
                                              //     overflow: TextOverflow.ellipsis,
                                              //     style: GoogleFonts.roboto(
                                              //         fontSize: 12,
                                              //         fontWeight: FontWeight.w800,
                                              //         color: Colors.black87)),
                                              // SizedBox(
                                              //   height: size.height * 0.0095,
                                              // ),
                                              Text(x.description,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black87)),
                                              SizedBox(
                                                height: size.height * 0.0095,
                                              ),
                                              Text(
                                                x.address,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.black87,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Center(
                          child: SizedBox(
                            // width: size.width * 0.35,
                            height: size.height * 0.035,
                            child: RaisedButton(
                              color: Color(0xFF18b15a),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () {
                                onNext_manu2();
                              },
                              child: Text(
                                "Lihat Komunitas",
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: size.height * 0.268,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      AspectRatio(
                                        aspectRatio: 20 / 6,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //   bottom: 5.0,
                                      //   left: 0.0,
                                      //   // right: 0.0,
                                      //   child: Image.asset('assets/images/line.png',
                                      //       height: size.height * 0.02,
                                      //       color: Color(0xFF18b15a),
                                      //       fit: BoxFit.fitHeight),
                                      // ),
                                      Positioned(
                                        bottom: size.height * 0.010,
                                        left: 0.0,
                                        // right: 0.0,
                                        child: Image.asset(
                                            'assets/images/line2.png',
                                            height: size.height * 0.008,
                                            color: Color(0xFF18b15a),
                                            fit: BoxFit.fitHeight),
                                      ),
                                      Positioned(
                                        top: 19,
                                        bottom: 3.0,
                                        left: 0.0,
                                        right: 0.0,
                                        // top: size.height * 0.01,
                                        child: Text(
                                          'Wisata',
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black87,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        AspectRatio(
                         aspectRatio: 16 / 9.5,
                          child: Container(
                            color: Color(0xFFFFC600),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 20, top: 15, bottom: 15),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    scrollbarTheme: ScrollbarThemeData(
                                  thumbColor: MaterialStateProperty.all(
                                      Color(0xFF18b15a)),
                                )),
                                child: Scrollbar(
                                  thickness: 3,
                                  // isAlwaysShown: true,
                                  child: ListView.builder(
                                    // padding: EdgeInsets.only(left: 16),
                                    itemCount: list_tour.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      final x = list_tour[i];
                                      // final y = jsonDecode(x.image_path);
                                      // final image = y[1];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailWisata(x)));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 16),
                                          width: size.height * 0.268,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Stack(
                                                children: <Widget>[
                                                  AspectRatio(
                                                    aspectRatio: 16 / 9,
                                                    child: Container(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              URL_HTTP + "/"+
                                                                  x.image_path,
                                                          //                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                          // CircularProgressIndicator(value: downloadProgress.progress),
                                                          placeholder: (context,
                                                                  url) =>
                                                              buildSkeletonSlide(
                                                                  context),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    child: SvgPicture.asset(
                                                        'assets/svg/travlog_top_corner.svg',
                                                        color: Colors.white70),
                                                    right: size.height * 0,
                                                  ),
                                                  Positioned(
                                                    top: size.height * 0.006,
                                                    right: size.height * 0.005,
                                                    child: Container(
                                                      width:
                                                          size.height * 0.050,
                                                      child: Image.asset(
                                                          'assets/images/logo.png',
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: size.height * 0,
                                                    child: SvgPicture.asset(
                                                        'assets/svg/travlog_bottom_gradient.svg',
                                                        fit: BoxFit.fitWidth,
                                                        width:
                                                            size.height * 0.268,
                                                        color:
                                                            Color(0xFF18b15a)),
                                                  ),
                                                  Positioned(
                                                    bottom:
                                                        size.height * 0.0095,
                                                    left: size.height * 0.0095,
                                                    right: size.height * 0.0095,
                                                    child: Text(
                                                      x.name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color: Color(
                                                              0xFFFFFFFF)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height * 0.0095,
                                              ),
                                              // Text(carousel_slide[index].sumber,
                                              //     maxLines: 1,
                                              //     overflow: TextOverflow.ellipsis,
                                              //     style: GoogleFonts.roboto(
                                              //         fontSize: 12,
                                              //         fontWeight: FontWeight.w800,
                                              //         color: Colors.black87)),
                                              // SizedBox(
                                              //   height: size.height * 0.0095,
                                              // ),
                                              Text(x.description,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black87)),
                                              SizedBox(
                                                height: size.height * 0.0095,
                                              ),
                                              Text(
                                                x.address,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.black87,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Center(
                          child: SizedBox(
                            // width: size.width * 0.35,
                            height: size.height * 0.035,
                            child: RaisedButton(
                              color: Color(0xFF18b15a),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () {
                                onNext_manu3();
                              },
                              child: Text(
                                "Lihat Wisata",
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: size.height * 0.268,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      AspectRatio(
                                        aspectRatio: 20 / 6,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //   bottom: 5.0,
                                      //   left: 0.0,
                                      //   // right: 0.0,
                                      //   child: Image.asset('assets/images/line.png',
                                      //       height: size.height * 0.02,
                                      //       color: Color(0xFF18b15a),
                                      //       fit: BoxFit.fitHeight),
                                      // ),
                                      Positioned(
                                        bottom: size.height * 0.010,
                                        left: 0.0,
                                        // right: 0.0,
                                        child: Image.asset(
                                            'assets/images/line2.png',
                                            height: size.height * 0.008,
                                            color: Color(0xFF18b15a),
                                            fit: BoxFit.fitHeight),
                                      ),
                                      Positioned(
                                        top: 19,
                                        bottom: 3.0,
                                        left: 0.0,
                                        right: 0.0,
                                        // top: size.height * 0.01,
                                        child: Text(
                                          'UMKM',
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black87,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        AspectRatio(
                          aspectRatio: 16 / 9.5,
                          child: Container(
                            color: Color(0xFFFFC600),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 20, top: 15, bottom: 15),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    scrollbarTheme: ScrollbarThemeData(
                                  thumbColor: MaterialStateProperty.all(
                                      Color(0xFF18b15a)),
                                )),
                                child: Scrollbar(
                                  thickness: 3,
                                  // isAlwaysShown: true,
                                  child: ListView.builder(
                                    // padding: EdgeInsets.only(left: 16),
                                    itemCount: list_business.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      final x = list_business[i];
                                      // final y = jsonDecode(x.image_path);
                                      // final image = y[1];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailUmkm(
                                                        x,
                                                      )));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 16),
                                          width: size.height * 0.268,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Stack(
                                                children: <Widget>[
                                                  AspectRatio(
                                                    aspectRatio: 16 / 9,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              URL_HTTP + "/"+
                                                                  x.image_path,
                                                          // progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                          // CircularProgressIndicator(value: downloadProgress.progress),
                                                          placeholder: (context,
                                                                  url) =>
                                                              buildSkeletonSlide(
                                                                  context),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    child: SvgPicture.asset(
                                                        'assets/svg/travlog_top_corner.svg',
                                                        color: Colors.white70),
                                                    right: size.height * 0,
                                                  ),
                                                  Positioned(
                                                    top: size.height * 0.006,
                                                    right: size.height * 0.005,
                                                    child: Container(
                                                      width:
                                                          size.height * 0.050,
                                                      child: Image.asset(
                                                          'assets/images/logo.png',
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: size.height * 0,
                                                    child: SvgPicture.asset(
                                                        'assets/svg/travlog_bottom_gradient.svg',
                                                        fit: BoxFit.fitWidth,
                                                        width:
                                                            size.height * 0.268,
                                                        color:
                                                            Color(0xFF18b15a)),
                                                  ),
                                                  Positioned(
                                                    bottom:
                                                        size.height * 0.0095,
                                                    left: size.height * 0.0095,
                                                    right: size.height * 0.0095,
                                                    child: Text(
                                                      x.name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color: Color(
                                                              0xFFFFFFFF)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height * 0.0095,
                                              ),
                                              // Text(carousel_slide[index].sumber,
                                              //     maxLines: 1,
                                              //     overflow: TextOverflow.ellipsis,
                                              //     style: GoogleFonts.roboto(
                                              //         fontSize: 12,
                                              //         fontWeight: FontWeight.w800,
                                              //         color: Colors.black87)),
                                              // SizedBox(
                                              //   height: size.height * 0.0095,
                                              // ),
                                              Text(x.description,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black87)),
                                              SizedBox(
                                                height: size.height * 0.0095,
                                              ),
                                              Text(
                                                x.address,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.black87,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Center(
                          child: SizedBox(
                            // width: size.width * 0.35,
                            height: size.height * 0.035,
                            child: RaisedButton(
                              color: Color(0xFF18b15a),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () {
                                onNext_manu4();
                              },
                              child: Text(
                                "Lihat UMKM",
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: size.height * 0.268,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      AspectRatio(
                                        aspectRatio: 20 / 6,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //   bottom: 5.0,
                                      //   left: 0.0,
                                      //   // right: 0.0,
                                      //   child: Image.asset('assets/images/line.png',
                                      //       height: size.height * 0.02,
                                      //       color: Color(0xFF18b15a),
                                      //       fit: BoxFit.fitHeight),
                                      // ),
                                      Positioned(
                                        bottom: size.height * 0.010,
                                        left: 0.0,
                                        // right: 0.0,
                                        child: Image.asset(
                                            'assets/images/line2.png',
                                            height: size.height * 0.008,
                                            color: Color(0xFF18b15a),
                                            fit: BoxFit.fitHeight),
                                      ),
                                      Positioned(
                                        top: 19,
                                        bottom: 3.0,
                                        left: 0.0,
                                        right: 0.0,
                                        // top: size.height * 0.01,
                                        child: Text(
                                          'Info',
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black87,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        AspectRatio(
                          aspectRatio: 16 / 8.2,
                          child: Container(
                            color: Color(0xFFFFC600),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 20, top: 15, bottom: 15),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    scrollbarTheme: ScrollbarThemeData(
                                  thumbColor: MaterialStateProperty.all(
                                      Color(0xFF18b15a)),
                                )),
                                child: Scrollbar(
                                  thickness: 3,
                                  // isAlwaysShown: true,
                                  child: ListView.builder(
                                    // padding: EdgeInsets.only(left: 16),
                                    itemCount: list_news.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      final x = list_news[i];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DetailInfo(
                                                    // daftarkmunitas: index,
                                                    x),
                                              ));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 16),
                                          width: size.height * 0.268,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Stack(
                                                children: <Widget>[
                                                  AspectRatio(
                                                    aspectRatio: 16 / 9,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              URL_HTTP + "/"+
                                                                  x.image_path,
                                                          //                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                          // CircularProgressIndicator(value: downloadProgress.progress),
                                                          placeholder: (context,
                                                                  url) =>
                                                              buildSkeletonSlide(
                                                                  context),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    child: SvgPicture.asset(
                                                        'assets/svg/travlog_top_corner.svg',
                                                        color: Colors.white70),
                                                    right: size.height * 0,
                                                  ),
                                                  Positioned(
                                                    top: size.height * 0.006,
                                                    right: size.height * 0.005,
                                                    child: Container(
                                                      width:
                                                          size.height * 0.050,
                                                      child: Image.asset(
                                                          'assets/images/logo.png',
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: size.height * 0,
                                                    child: SvgPicture.asset(
                                                        'assets/svg/travlog_bottom_gradient.svg',
                                                        fit: BoxFit.fitWidth,
                                                        width:
                                                            size.height * 0.268,
                                                        color:
                                                            Color(0xFF18b15a)),
                                                  ),
                                                  Positioned(
                                                    bottom:
                                                        size.height * 0.0095,
                                                    left: size.height * 0.0095,
                                                    right: size.height * 0.0095,
                                                    child: Text(
                                                      x.title,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color: Color(
                                                              0xFFFFFFFF)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height * 0.0095,
                                              ),
                                              // Text(carousel_slide[index].sumber,
                                              //     maxLines: 1,
                                              //     overflow: TextOverflow.ellipsis,
                                              //     style: GoogleFonts.roboto(
                                              //         fontSize: 12,
                                              //         fontWeight: FontWeight.w800,
                                              //         color: Colors.black87)),
                                              // SizedBox(
                                              //   height: size.height * 0.0095,
                                              // ),
                                              Text(x.content,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black87)),
                                              // SizedBox(
                                              //   height: size.height * 0.0095,
                                              // ),
                                              // Text(
                                              //   menu_info[index].alamat,
                                              //   maxLines: 2,
                                              //   overflow: TextOverflow.ellipsis,
                                              //   style: GoogleFonts.roboto(
                                              //     fontSize: 11,
                                              //     fontWeight: FontWeight.w800,
                                              //     color: Colors.black87,
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Center(
                          child: SizedBox(
                            // width: size.width * 0.35,
                            height: size.height * 0.035,
                            child: RaisedButton(
                              color: Color(0xFF18b15a),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HalamanInfo()));
                              },
                              child: Text(
                                "Lihat Info",
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: size.height * 0.268,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      AspectRatio(
                                        aspectRatio: 20 / 6,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //   bottom: 5.0,
                                      //   left: 0.0,
                                      //   // right: 0.0,
                                      //   child: Image.asset('assets/images/line.png',
                                      //       height: size.height * 0.02,
                                      //       color: Color(0xFF18b15a),
                                      //       fit: BoxFit.fitHeight),
                                      // ),
                                      Positioned(
                                        bottom: size.height * 0.010,
                                        left: 0.0,
                                        // right: 0.0,
                                        child: Image.asset(
                                            'assets/images/line2.png',
                                            height: size.height * 0.008,
                                            color: Color(0xFF18b15a),
                                            fit: BoxFit.fitHeight),
                                      ),
                                      Positioned(
                                        top: 19,
                                        bottom: 3.0,
                                        left: 0.0,
                                        right: 0.0,
                                        // top: size.height * 0.01,
                                        child: Text(
                                          'Jasa Keuangan',
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black87,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        AspectRatio(
                          aspectRatio: 16 / 8.2,
                          child: Container(
                            color: Color(0xFFFFC600), 
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 20, top: 15, bottom: 15),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    scrollbarTheme: ScrollbarThemeData(
                                  thumbColor: MaterialStateProperty.all(
                                      Color(0xFF18b15a)),
                                )),
                                child: Scrollbar(
                                  thickness: 3,
                                  // isAlwaysShown: true,
                                  child: ListView.builder(
                                    // padding: EdgeInsets.only(left: 16),
                                    itemCount: list_financial.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      final x = list_financial[i];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailBank(
                                                        x,
                                                      )));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 16),
                                          width: size.height * 0.268,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Stack(
                                                children: <Widget>[
                                                  AspectRatio(
                                                    aspectRatio: 16 / 9,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                URL_HTTP + "/"+
                                                                    x.path,
                                                            //                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                            // CircularProgressIndicator(value: downloadProgress.progress),
                                                            placeholder: (context,
                                                                    url) =>
                                                                buildSkeletonSlide(
                                                                    context),
                                                            errorWidget: (context,
                                                                    url, error) =>
                                                                Icon(Icons.error),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    child: SvgPicture.asset(
                                                        'assets/svg/travlog_top_corner.svg',
                                                        color: Colors.white70),
                                                    right: size.height * 0,
                                                  ),
                                                  Positioned(
                                                    top: size.height * 0.006,
                                                    right: size.height * 0.005,
                                                    child: Container(
                                                      width: size.height * 0.050,
                                                      child: Image.asset(
                                                          'assets/images/logo.png',
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: size.height * 0,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8),
                                                          ),
                                                          gradient:
                                                              LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                              Color.fromRGBO(255,
                                                                  255, 255, 0),
                                                              Colors.green,
                                                            ],
                                                          )),
                                                      child: SvgPicture.asset(
                                                        'assets/svg/travlog_bottom_gradient.svg',
                                                        fit: BoxFit.fitWidth,
                                                        width: size.height * 0.4,
                                                        color: Colors.transparent,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: size.height * 0.0095,
                                                    left: size.height * 0.0095,
                                                    right: size.height * 0.0095,
                                                    child: Text(
                                                      x.name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color:
                                                              Color(0xFFFFFFFF)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height * 0.0095,
                                              ),
                                              // Text(carousel_slide[index].sumber,
                                              //     maxLines: 1,
                                              //     overflow: TextOverflow.ellipsis,
                                              //     style: GoogleFonts.roboto(
                                              //         fontSize: 12,
                                              //         fontWeight: FontWeight.w800,
                                              //         color: Colors.black87)),
                                              // SizedBox(
                                              //   height: size.height * 0.0095,
                                              // ),
                                              Text(x.description,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black87)),
                                              // SizedBox(
                                              //   height: size.height * 0.0095,
                                              // ),
                                              // Text(
                                              //   menu_info[index].alamat,
                                              //   maxLines: 2,
                                              //   overflow: TextOverflow.ellipsis,
                                              //   style: GoogleFonts.roboto(
                                              //     fontSize: 11,
                                              //     fontWeight: FontWeight.w800,
                                              //     color: Colors.black87,
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Center(
                          child: SizedBox(
                            // width: size.width * 0.41,
                            height: size.height * 0.035,
                            child: RaisedButton(
                              color: Color(0xFF18b15a),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () {
                                onNext_manu5();
                              },
                              child: Text(
                                "Lihat Jasa Keuangan",
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: size.height * 0.268,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      AspectRatio(
                                        aspectRatio: 20 / 6,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //   bottom: 5.0,
                                      //   left: 0.0,
                                      //   // right: 0.0,
                                      //   child: Image.asset('assets/images/line.png',
                                      //       height: size.height * 0.02,
                                      //       color: Color(0xFF18b15a),
                                      //       fit: BoxFit.fitHeight),
                                      // ),
                                      Positioned(
                                        bottom: size.height * 0.010,
                                        left: 0.0,
                                        // right: 0.0,
                                        child: Image.asset(
                                            'assets/images/line2.png',
                                            height: size.height * 0.008,
                                            color: Color(0xFF18b15a),
                                            fit: BoxFit.fitHeight),
                                      ),
                                      Positioned(
                                        top: 19,
                                        bottom: 3.0,
                                        left: 0.0,
                                        right: 0.0,
                                        // top: size.height * 0.01,
                                        child: Text(
                                          'Video',
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black87,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                       AspectRatio(
                          aspectRatio: 16 / 6.7,
                          child: Container(
                            color: Color(0xFFFFC600), 
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 20, top: 15, bottom: 15),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    scrollbarTheme: ScrollbarThemeData(
                                  thumbColor: MaterialStateProperty.all(
                                      Color(0xFF18b15a)),
                                )),
                                child: Scrollbar(
                                  thickness: 3,
                                  // isAlwaysShown: true,
                                  child: ListView.builder(
                                    // padding: EdgeInsets.only(left: 16),
                                    itemCount: list_youtube.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      final x = list_youtube[i];
                                      return GestureDetector(
                                        onTap: () {
                                          openApp(url: x.url, inApp: false);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 16),
                                          width: size.height * 0.268,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Stack(
                                                children: <Widget>[
                                                  AspectRatio(
                                                    aspectRatio: 16 / 9,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                        child: CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          imageUrl:
                                                              getYoutubeThumbnail(
                                                                  x.url),
                                                          //                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                          // CircularProgressIndicator(value: downloadProgress.progress),
                                                          placeholder: (context,
                                                                  url) =>
                                                              buildSkeletonSlide(
                                                                  context),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    child: SvgPicture.asset(
                                                        'assets/svg/travlog_top_corner.svg',
                                                        color: Colors.white70),
                                                    right: size.height * 0,
                                                  ),
                                                  Positioned(
                                                    top: size.height * 0.006,
                                                    right: size.height * 0.005,
                                                    child: Container(
                                                      width: size.height * 0.050,
                                                      child: Image.asset(
                                                          'assets/images/logo.png',
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: size.height * 0,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8),
                                                          ),
                                                          gradient:
                                                              LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                              Color.fromRGBO(255,
                                                                  255, 255, 0),
                                                              Colors.green,
                                                            ],
                                                          )),
                                                      child: SvgPicture.asset(
                                                        'assets/svg/travlog_bottom_gradient.svg',
                                                        fit: BoxFit.fitWidth,
                                                        width: size.height * 0.4,
                                                        color: Colors.transparent,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: size.height * 0.0095,
                                                    left: size.height * 0.0095,
                                                    right: size.height * 0.0095,
                                                    child: Text(
                                                      x.name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color:
                                                              Color(0xFFFFFFFF)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height * 0.0095,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Center(
                          child: SizedBox(
                            // width: size.width * 0.41,
                            height: size.height * 0.035,
                            child: RaisedButton(
                              color: Color(0xFF18b15a),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HalamanVideo()));
                              },
                              child: Text(
                                "Lihat Video",
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                      ]),
                    ),
                  ),
                ),
    );
  }
}
