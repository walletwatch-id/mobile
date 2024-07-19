import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:walletwatch_mobile/common/helper.dart';

Future<bool> storeTransaction(
    {required BuildContext context,
    required String paylaterId,
    required double monthlyInstallment,
    required int period,
    required String firstInstallmentDateTime}) async {
  const String url = '${apiUrl}transactions';
  final Map<String, dynamic> transactionData = {
    'user_id': user.id,
    'paylater_id': paylaterId,
    'monthly_installment': monthlyInstallment,
    'period': period,
    'first_installment_datetime': firstInstallmentDateTime,
    'transaction_datetime': DateFormat('yyyy-MM-ddTHH:mm:ss+00:00')
                                        .format(DateTime.now().toUtc()),
  };

  final prefs = await getPrefs();

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.accessToken}',
      },
      body: jsonEncode(transactionData),
    );

    final responseBody = json.decode(response.body);

    if (response.statusCode == 201) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Tambah Transaksi Berhasil")));
      return true;
    } else {
      // ignore: use_build_context_synchronously
      print(responseBody);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: ${responseBody}")));
    }
  } catch (e) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Error: $e")));
  } finally {
    // ignore: control_flow_in_finally
    return false;
  }
}
