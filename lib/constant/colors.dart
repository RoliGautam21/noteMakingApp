import 'dart:math';

import 'package:flutter/material.dart';

Color changeColor() {
  var _color = Color.fromARGB(Random().nextInt(256), Random().nextInt(256),
      Random().nextInt(256), Random().nextInt(256));
  return _color;
}
