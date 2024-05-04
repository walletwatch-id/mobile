import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFontStyle {
  static TextStyle boldText =
      const TextStyle(fontSize: 16, fontFamily: "Baloo", height: 1);
  static TextStyle normalText = const TextStyle(
      fontSize: 14, fontFamily: "Baloo2", height: 1, color: Colors.black);
  static TextStyle simpleListText =
      const TextStyle(fontSize: 16, fontFamily: "Baloo");

  static TextStyle homeHeaderText = TextStyle(
    fontSize: 35.sp,
    color: const Color(0xFF007bd9),
    fontFamily: 'EduTAS',
  );

        static TextStyle chartLabelText = const TextStyle(
    fontSize: 12,
    fontFamily: 'Baloo2', fontWeight: FontWeight.bold
  );

        static TextStyle chartAxisText = const TextStyle(
    fontSize: 14,
    fontFamily: 'Baloo2', fontWeight: FontWeight.bold
  );

    static TextStyle topBarTitleText =
      TextStyle(fontSize: 24.sp, fontFamily: "Baloo",
                              height: .1);

  static TextStyle homeSubHeaderText = TextStyle(
      fontSize: 28.sp,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.bold,
      height: 1.1,
      color: Colors.black);

        static TextStyle homeMonitorIndicatorText = TextStyle(
      fontSize: 42.sp,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.bold,
      height: 1.1,
      color: Colors.black);

        static TextStyle homeSubTitleText = TextStyle(
      fontSize: 18.sp,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.bold,
      height: .8,
      color: Colors.black);

              static TextStyle homeCardTitleText = TextStyle(
      fontSize: 22.sp,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.bold,
      height: 1.1,
      color: Colors.black);

    static TextStyle homeNormalText = TextStyle(
      fontSize: 14.sp,
      fontFamily: 'Nunito',
      color: Colors.black);

          static TextStyle homeTabText = TextStyle(
      fontSize: 18.sp,
      fontFamily: 'Nunito',
      color: Colors.black);

  static TextStyle homeListHeaderText = TextStyle(
      fontSize: 22.sp,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.bold,
      color: Colors.black);

  static TextStyle homeItemText = TextStyle(
    fontSize: 16.sp,
    fontFamily: "Baloo",
    height: 1,
  );

  static TextStyle dialogTitleText = TextStyle(
    fontSize: 24.sp,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle dialogText = TextStyle(
    fontSize: 14.sp,
    fontFamily: 'Nunito',
    color: Colors.black,
  );

  static TextStyle dialogButtonText = TextStyle(
    fontSize: 18.sp,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle topBarText = TextStyle(
    fontSize: 19.sp,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle sectionSubTitleText = TextStyle(
    fontSize: 26.sp,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle sectionButtonText = TextStyle(
    fontSize: 18.sp,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle accountUsernameText = TextStyle(
    fontSize: 14.sp,
    fontFamily: "Baloo2",
    height: 1.1,
  );

    static TextStyle accountNameText = const TextStyle(
    fontSize: 18,
    fontFamily: "Baloo",
    height: 1.1,
  );

  static TextStyle authTitleText = TextStyle(
    fontSize: 22.sp,
    fontFamily: "Baloo2",
    fontWeight: FontWeight.bold,
    height: 1.1
  );

    static TextStyle authSubTitleText = TextStyle(
    fontSize: 16.sp,
    fontFamily: "Nunito",
    fontWeight: FontWeight.bold,
    height: 1.1
  );

  static TextStyle authLabelText = TextStyle(
    fontSize: 18.sp,
    fontFamily: "Baloo",
  );

    static TextStyle authSubLabelText = TextStyle(
    fontSize: 14.sp,
    fontFamily: "Nunito",
    fontWeight: FontWeight.bold
  );

  static TextStyle customInputText = TextStyle(
    fontSize: 15.sp,
    fontFamily: "Baloo2",
  );

  static TextStyle authHintText = TextStyle(
    color: const Color(0xFF9EA3A2),
    fontSize: 15.sp,
    fontFamily: "Baloo2",
  );

  static TextStyle authSmallText = TextStyle(
    fontSize: 15.sp,
    fontFamily: "Baloo2",
  );


  static TextStyle authSmallBoldText = TextStyle(
      fontSize: 12.sp,
      fontFamily: "Baloo2",
      fontWeight: FontWeight.bold,
      shadows: const [
        Shadow(
          blurRadius: 8,
          color: Color(0x663CEAC1),
        ),
        Shadow(
          blurRadius: 8,
          color: Color(0x6600C0DA),
        ),
      ],
      foreground: Paint()
        ..shader = const LinearGradient(
          colors: [
            Color(0xFF3CEAC1),
            Color(0xFF00C0DA),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)));

  static TextStyle tabText = TextStyle(
      fontSize: 28.sp,
      fontFamily: "Baloo",
      color: const Color(0xFF6E6E6E).withOpacity(.5),
      height: .1);

  static TextStyle tabActiveText = TextStyle(
      fontSize: 28.sp,
      fontFamily: "Baloo",
      height: .1,
      shadows: const [
        Shadow(
          blurRadius: 8,
          color: Color(0x663CEAC1),
        ),
        Shadow(
          blurRadius: 8,
          color: Color(0x6600C0DA),
        ),
      ],
      foreground: Paint()
        ..shader = const LinearGradient(
          colors: [
            Color(0xFF3CEAC1),
            Color(0xFF00C0DA),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)));
}
