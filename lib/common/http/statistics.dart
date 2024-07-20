import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:walletwatch_mobile/common/data/statistic.dart';
import 'package:walletwatch_mobile/common/helper.dart';

Future<List<Statistic>> fetchStatistics() async {
  const String url = '${apiUrl}statistics?per_page=12';
  final List<Statistic> results = [];

  final prefs = await getPrefs();

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer ${prefs.accessToken}',
    },
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);

    final statistics = responseBody['data']['statistics'] as List<dynamic>;

    for (var statistic in statistics) {

      final result = Statistic(
        id: statistic['id'] as String,
        month: statistic['month'] as int,
        year: statistic['year'] as int,
        personality: statistic['personality'] as String,
        totalTransaction: (statistic['total_transaction'] as int).toDouble(),
        totalInstallment: (statistic['total_installment'] as int).toDouble(),
        totalIncome: (statistic['total_income'] as int).toDouble(),
        ratio: double.parse(statistic['ratio'] as String),
      );

      results.add(result);
    }

    return results;
  } else {
    print('Request failed with status: ${response.statusCode}');
    return List.empty();
  }
}
