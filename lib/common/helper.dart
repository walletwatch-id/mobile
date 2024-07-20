import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walletwatch_mobile/common/data/preference.dart';
import 'package:walletwatch_mobile/common/data/user.dart';
import 'package:walletwatch_mobile/common/enum/item_state.dart';
import 'package:intl/intl.dart';
import 'package:walletwatch_mobile/views/splash/splash.dart';

const _baseUrl = "https://www.walletwatch.id/";
const apiUrl = "${_baseUrl}api/v1/";
const oauthUrl = "${_baseUrl}oauth2/";
const authUrl = "${_baseUrl}auth/";
// ignore: constant_identifier_names
const SURVEY_ID = "0190cc8f-38db-7e53-9fd1-b7600c63680b";

User user = User(
  id: "1",
  name: "Agus Setiawan",
  email: 'agussetiawan@gmail.com',
  role: 'Student',
  image: Image.asset("assets/images/user_default.png"),
);

bool isAdmin() {
  return user.role == 'ADMIN';
}

@pragma('vm:entry-point')
String? emptyNull(String? text) {
  return text == '' ? null : text;
}

@pragma('vm:entry-point')
Future<void> savePrefs({String? accessToken}) async {
  final prefs = await SharedPreferences.getInstance();

  if (accessToken != null) {
    prefs.setString('access_token', accessToken);
  }
}

@pragma('vm:entry-point')
Future<void> resetPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
  // final service = FlutterBackgroundService();
  // service.invoke("resetService");
}

@pragma('vm:entry-point')
Future<Preference> getPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  return Preference(
    accessToken: emptyNull(prefs.getString('access_token')),
  );
}

Future<void> signOut(BuildContext context) async {
  resetPrefs();

  // final service = FlutterBackgroundService();
  // service.invoke('stopService');
  // ignore: use_build_context_synchronously
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => const Splash()),
    (Route<dynamic> route) => false,
  );
}

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

String getStateTitle(ItemState state) {
  if (state == ItemState.akulaku) {
    return "Akulaku";
  } else if (state == ItemState.kredivo) {
    return "Kredivo";
  } else if (state == ItemState.shopee) {
    return "SpayLater";
  } else if (state == ItemState.ojk) {
    return "Otoritas Jasa Keuangan";
  } else if (state == ItemState.kominfo) {
    return "Kominfo";
  }

  return "";
}

Map<int, String> summarizeValues(double number) {
  if (number < 1000) {
    return {1: ''};
  } else if (number < 1000000) {
    return {1000: 'ribu'};
  } else {
    return {1000000: 'juta'};
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

String convertIntToMonth(int month) {
  List<String> months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  if (month < 1 || month > 12) {
    throw ArgumentError("Invalid month: $month. Must be between 1 and 12.");
  }

  return months[month - 1];
}
