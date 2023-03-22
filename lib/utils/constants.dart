import 'dart:math';
import 'package:flutter/material.dart';

class Constant {
  static const double fontRegular = 15.0;
  static const int mainColor = 0xFF771415;

  static var textInputDecoration = const InputDecoration(
    isDense: true,
    isCollapsed: true,
    contentPadding: EdgeInsets.all(20),
    // contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    // fillColor: Color(0xffE3E3E3),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(mainColor), width: 2.0),
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
    ),
  );

  static var chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  static final Random rnd = Random();

  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
}
