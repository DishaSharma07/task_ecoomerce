import 'dart:math';

import 'package:flutter/material.dart';

//to convert hexadecimal string into int
hexStringToHexInt(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff' + hex : hex;
  int val = int.parse(hex, radix: 16);
  return val;
}


final whiteColor = Color(hexStringToHexInt("#FFFFFF"));
final greyColor = Color(hexStringToHexInt("#949494"));
final primaryColor = Colors.blue;


