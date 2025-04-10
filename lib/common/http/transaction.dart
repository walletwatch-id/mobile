import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:walletwatch_mobile/common/data/transaction.dart';
import 'package:walletwatch_mobile/common/helper.dart';

Future<List<Transaction>> fetchTransactions() async {
  const String url = '${apiUrl}transactions?per_page=999';

  final prefs = await getPrefs();

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer ${prefs.accessToken}',
    },
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);

    final transactions = responseBody['data']['transactions'] as List<dynamic>;

    final results = transactions.map((transaction) => Transaction.fromJson(transaction)).toList();

    return results;
  } else {
    print('Request failed with status: ${response.statusCode}');
    return List.empty();
  }
}


Future<bool> storeTransaction(
    {required BuildContext context,
    required String paylaterId,
    required double monthlyInstallment,
    required int period,
    required String firstInstallmentDateTime}) async {
  const String url = '${apiUrl}transactions';
  final Map<String, dynamic> transactionData = {
    'paylater_id': paylaterId,
    'monthly_installment': monthlyInstallment,
    'period': period,
    'first_installment_datetime': firstInstallmentDateTime,
    'transaction_datetime':
        DateFormat('yyyy-MM-ddTHH:mm:ss+00:00').format(DateTime.now().toUtc()),
  };

  if (isAdmin()) {
    transactionData['user_id'] = user.id;
  }

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
      EasyLoading.showSuccess('Transaksi telah berhasil ditambahkan!');
      return true;
    } else {
      // ignore: use_build_context_synchronously
      print(responseBody);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $responseBody")));
      return false;
    }
  } catch (e) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Error: $e")));

    return false;
  }
}
