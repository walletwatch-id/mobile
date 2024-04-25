import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/data/user.dart';
import 'package:wallet_watch/common/enum/paylater_state.dart';
import 'package:intl/intl.dart';

final User user = User(
  id: 1,
  name: "Agus Setiawan",
  username: "Agusetiawan19",
  email: 'agussetiawan@gmail.com',
  role: 'Student',
  image: "assets/images/user_default.png",
);

Widget getPaylaterImage(PaylaterState state, {double size = 1}) {
  if (state == PaylaterState.akulaku) {
    return SizedBox(
      height: 55.h * size,
      child: Image.asset("assets/images/paylater/akulaku.png"),
    );
  } else if (state == PaylaterState.kredivo) {
    return SizedBox(
      height: 32.h * size,
      child: Image.asset("assets/images/paylater/kredivo.png"),
    );
  } else if (state == PaylaterState.shopee) {
    return SizedBox(
      height: 28.h * size,
      child: Image.asset("assets/images/paylater/shopee.png"),
    );
  }

  return SizedBox(
    width: 55.w,
    child: const Icon(Icons.payment),
  );
}

String summarizeDigits(int number) {
  if (number < 1000) {
    return number.toString();
  } else if (number < 1000000) {
    double result = number / 1000.0;
    return '${result.toStringAsFixed(2)}K';
  } else {
    double result = number / 1000000.0;
    return '${result.toStringAsFixed(2)}M';
  }
}

String formatCurrency(double value, {int digits = 2}) {
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: digits,
  );
  return formatter.format(value);
}
