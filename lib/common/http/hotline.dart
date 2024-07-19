import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:walletwatch_mobile/common/data/hotline.dart';
import 'package:walletwatch_mobile/common/helper.dart';

Future<List<Hotline>> fetchHotlines() async {
  const String url = '${apiUrl}paylaters?include=hotlines&per_page=100';
  final List<Hotline> hotlines = [];

  final prefs = await getPrefs();

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer ${prefs.accessToken}',
    },
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);

    final paylaters = responseBody['data']['paylaters'] as List<dynamic>;

    for (var paylater in paylaters) {
      final hotlinesData = paylater['hotlines'] as List<dynamic>;

      for (var hotline in hotlinesData) {
        final hotlineName = paylater['name'] as String;
        final hotlineType = hotline['type'] as String;
        final hotlineValue = hotline['hotline'] as String;

        Hotline hotlineInstance;
        switch (hotlineType) {
          case 'PHONE':
            hotlineInstance = Hotline(
              hotlineName,
              id: paylater['id'] as String,
              phoneNumber: hotlineValue,
            );
            break;
          case 'EMAIL':
            hotlineInstance = Hotline(
              hotlineName,
              id: paylater['id'] as String,
              email: hotlineValue,
            );
            break;
          case 'URL':
            hotlineInstance = Hotline(
              hotlineName,
              id: paylater['id'] as String,
              url: hotlineValue,
            );
            break;
          default:
            continue; // Skip unknown types
        }

        hotlines.add(hotlineInstance);
      }
    }

    return hotlines;
  } else {
    print('Request failed with status: ${response.statusCode}');
    return List.empty();
  }
}
