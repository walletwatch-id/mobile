import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:walletwatch_mobile/common/data/user.dart';
import 'package:walletwatch_mobile/common/helper.dart';

Future<User?> fetchUser() async {
  const String url = '${authUrl}user';

  final prefs = await getPrefs();
  final accessToken = prefs.accessToken;

  if (accessToken == null) {
    print('No access token found.');
    return null;
  }

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    final user = responseBody['data']['user'];

    return User(
      id: user['id'] as String,
      name: user['name'] as String,
      email: user['email'] as String,
      role: user['role'] as String,
      image: user['picture'] as String? ?? 'assets/images/user_default.png',
    );
  } else {
    print('Request failed with status: ${response.statusCode}');
    return null;
  }
}
