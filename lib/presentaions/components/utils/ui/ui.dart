import 'package:flutter/material.dart';

class AppColors {
  // static const primary = Color(0xFFEE3C3B);
  static const primary = MaterialColor(0xFF013566, {
    800: Color(0xFF221366),
    400: Color(0xFF404B52),
    200: Color(0xFF404B52),
  });
  static const secondary = MaterialColor(0xFFFED709, {
    800: Color(0xFF221366),
    400: Color(0xFF221366),
    200: Color(0xFF221366),
  });
  static const third = Color(0xFF001D3D);
  static const fourth = Color(0xFFF1F5F9);
  static const fifth = Color(0xFF1E293B);
  static const sixth = Color(0xFF475569);
  static const titleColor = Color(0xff111214);
  static const inactiveTrackColor = Color(0xFFE2E8F0);
  static const loadingBackground = Color(0xFFE3E3E3);
  static const active = Color(0xFF13B969);
  static const success = Color(0xFF3DAB25);
  static const activeGreen = Color(0xFF14B8A6);
  static const warning = Color(0xFFFABE3C);
  static const error = Color(0xFFEB5A5A);
  static const border = Color(0xFFE7EEF5);
  static const dashedBorder = Color(0xFFB3C1CF);
  static const white = Color(0xFFFFFFFF);
  static const lightGrey = Color(0xFFF2F2F7);
  static const grey = Color(0xff7a76728f);
  static const greyDark = Color(0xFF9E9E9E);
  static const greyBackground = Color(0xFFC6D1DB);
  static const black = Color(0xFF333333);
  static const hide = Color(0x00000000);
  static const startGradient = primary;
  static const endGradient = secondary;
  static const noteGoldColor = Color(0xffA98734);
  static const orange = Color(0xffFF7D5B);
  static const urgentBorder = Color(0xffEF662A);
  static const urgentBackground = Color(0xffFFF2EC);
  static const barBackground = Color(0xffF0F0F0);
  static const transparent = Colors.transparent;
  static const burgundy = Color(0xffCE1126);
  static const screenBackground = Color(0xffF9F9F9);
  static const bidBackground = Color(0xff4ADE80);
  static const pendingBorder = Color(0xff2196F3);
  static const pendingBackground = Color(0xffE3F2FD);
  static const acceptBorder = Color(0xff84CC16);
  static const acceptBackground = Color(0xffECFCCB);
  static const reject = Colors.redAccent;
  static const pending = Colors.yellowAccent;
  static const inprogress = Colors.orangeAccent;
  static const arrowColor = Color(0xff94A3B8);
  static const blueColor = Color(0xff2563EB);
  static const gray = Color(0xff393C43);
  static const errorBackground = Color(0xffFFE4E6);
}

class AppDimens {
  // margin and sizedBox dimensions
  static const tiny = 4.0;
  static const small = 8.0;
  static const medium = 12.0;
  static const large = 16.0;
  static const xlarge = 20.0;
  static const xxLarge = 24.0;
  static const xxxLarge = 30.0;
  static const big = 40.0;
  static const huge = 60.0;
  static const extraHug = 90.0;
  static const heightRadius = 25.0;
  static const buttonHeight = 50.0;
  static const border = 1.5;
  static const toolbarHeight = 64.0;
}

class AppFonts {
  static const heading1 = 48.0;
  static const heading2 = 36.0;
  static const heading3 = 32.0;
  static const heading4 = 24.0;
  static const heading5 = 20.0;
  static const subtitle1 = 16.0;
  static const subtitle2 = 14.0;
  static const body1 = 16.0;
  static const body2 = 14.0;
  static const caption = 14.0;
}

class Fonts {
  static const dmSans = "DMSans";
  static const cairo = "Cairo";
}
