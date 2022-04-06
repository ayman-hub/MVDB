import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Context {
  BuildContext context;

  Context(this.context);

  double getHeight() {
    return MediaQuery.of(context).size.height * 1.h;
  }

  double getWidth() {
    return MediaQuery.of(context).size.width * 1.h;
  }

  ThemeData getTheme() {
    return Theme.of(context);
  }
}
