import 'package:flutter/material.dart'; 
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import '1logindll/halaman_awal.dart';

const String title = "DigiPark";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFFEFEFE),
          fontFamily: "Roboto",
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            bodyText2: TextStyle(color: Color(0xFF4B4B4B)),
          )),
      home: AnimatedSplashScreen(
        splashTransition: SplashTransition.fadeTransition,
        curve: Curves.linear,
        duration: 500,
        splash: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.fitWidth,
        ),
        nextScreen: new HalamanAwal(
          title: title,
        ),
      ),
    );
  }
}
