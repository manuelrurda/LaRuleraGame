import 'package:flutter/material.dart';
import 'package:la_ruleta/constants/colors.dart';

const kInputDecoration = InputDecoration(
  hintText: 'Value',
  hintStyle: TextStyle(color: Colors.grey),
  fillColor: kColorLightGrey,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);

const kRouletteTextStyle =
    TextStyle(fontFamily: 'LuckiestGuy', color: kColorBlack, fontSize: 22);
