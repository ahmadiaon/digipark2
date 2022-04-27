import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'package:line_icons/line_icons.dart'; 
import 'halaman1_deskripsi.dart';
import 'halaman2_gambar.dart';
import 'halaman3_rekening.dart';
import 'halaman4_pinjam_dana.dart';

class MenuJasaKeuangan extends StatefulWidget {
  @override
  _MenuJasaKeuanganState createState() => _MenuJasaKeuanganState();
}

class _MenuJasaKeuanganState extends State<MenuJasaKeuangan> {
  String phone_number = "", token = "", uuid = "", role = "";

  int _selectedIndex = 0; //default index
  Widget _currentPage;

  List<Widget> _widgetOptions;
  Widget _page1;
  Widget _page2;
  Widget _page3;
  Widget _page4;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _page1 = BankDeskripsi();
    _page2 = BankGambar();
    _page3 = BankRekening();
    _page4 = BankPinjamDana();

    getPref();
    // print(phone_number);
    // print(token);
    // print(uuid);
    // tampil_data();

    _widgetOptions = [_page1, _page2, _page3, _page4];

    _selectedIndex = 0;
    _currentPage = _page1;
  }

  DateTime backbuttonpressedTime;

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
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
                  icon: LineIcons.user,
                  text: 'Profil',
                  iconSize: 24,
                  textStyle: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600),
                ),
                GButton(
                  icon: LineIcons.image,
                  text: 'Gambar',
                  iconSize: 26,
                  textStyle: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600),
                ),
                GButton(
                  icon: LineIcons.userCircle,
                  text: 'Buka Rekening',
                  iconSize: 24,
                  textStyle: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600),
                ),
                GButton(
                  icon: LineIcons.moneyBill,
                  text: 'Pinjam Dana',
                  iconSize: 24,
                  textStyle: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600),
                ),
              ]),
        ),
      ),
    );
  }
}
