import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/data/user.dart';
import 'package:wallet_watch/common/enum/item_state.dart';
import 'package:intl/intl.dart';

final User user = User(
  id: 1,
  name: "Agus Setiawan",
  username: "Agusetiawan19",
  email: 'agussetiawan@gmail.com',
  role: 'Student',
  image: "assets/images/user_default.png",
);

Widget getStateImage(ItemState? state, {double size = 1}) {
  if (state == ItemState.akulaku) {
    return SizedBox(
      height: 55.h * size,
      child: Image.asset("assets/images/paylater/akulaku.png"),
    );
  } else if (state == ItemState.kredivo) {
    return SizedBox(
      height: 32.h * size,
      child: Image.asset("assets/images/paylater/kredivo.png"),
    );
  } else if (state == ItemState.shopee) {
    return SizedBox(
      height: 28.h * size,
      child: Image.asset("assets/images/paylater/shopee.png"),
    );
  } else if (state == ItemState.ojk) {
    return SizedBox(
      height: 55.h * size,
      child: Image.asset("assets/images/government/ojk.png"),
    );
  } else if (state == ItemState.kominfo) {
    return SizedBox(
      height: 55.h * size,
      child: Image.asset("assets/images/government/kominfo.png"),
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

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

