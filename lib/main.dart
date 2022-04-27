import 'package:digipark/env.dart';
import 'package:flutter/material.dart'; 
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import '1logindll/halaman_awal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String title = "DigiPark";


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final firestoreInstance = FirebaseFirestore.instance;
  void _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    firestoreInstance.collection("product").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.get("name"));
        var url = result.get("name");
        var http = result.get("price");
        prefs.setString('URL', url);
        URL = url;
        URL_HTTP = http+url;
        URL_FULL = URL_HTTP+"/";
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    _incrementCounter();
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
