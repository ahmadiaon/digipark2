import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black54),
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(color: Colors.black54)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(color: Color(0xFF18b15a),)),
  hintStyle: TextStyle(fontFamily: 'GoogleFonts.roboto', color: Colors.grey),
  disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(color: Color.fromARGB(255, 169, 169, 169))),
);

const textInputDecoration2 = InputDecoration(
  labelStyle: TextStyle(color: Color(0xFF18b15a)),
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(color: Colors.black54)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(color: Color(0xFF18b15a))),
  hintStyle: TextStyle(fontFamily: 'GoogleFonts.roboto', color: Colors.grey),
);

const textInputDecoration3 = InputDecoration(
  labelStyle: TextStyle(color: Colors.black54),
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Colors.black54)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Color(0xFF18b15a))),
  hintStyle: TextStyle(fontFamily: 'GoogleFonts.roboto', color: Colors.grey),
);

const textInputDecoration4 = InputDecoration(
  labelStyle: TextStyle(color: Colors.black54),
  fillColor: Colors.white,
  filled: true,
  // enabledBorder: OutlineInputBorder(
  //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
  //   borderSide: BorderSide(color: Colors.black54)
  // ),
  // focusedBorder: OutlineInputBorder(
  //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
  //   borderSide: BorderSide(color: Color(0xFF0053A3))
  // ),
  border: InputBorder.none,
  // focusedBorder: InputBorder.none,
  // enabledBorder: InputBorder.none,
  // errorBorder: InputBorder.none,
  // disabledBorder: InputBorder.none,
  hintStyle: TextStyle(fontFamily: 'GoogleFonts.roboto', color: Colors.grey),
);
