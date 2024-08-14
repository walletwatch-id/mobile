import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:walletwatch_mobile/common/data/user.dart';
import 'package:walletwatch_mobile/common/helper.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

Future<User?> fetchUser() async {
  const String url = '${authUrl}user';

  final prefs = await getPrefs();
  final accessToken = prefs.accessToken;

  if (accessToken == null) {
    print('No access token found.');
    return null;
  }

  try {
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
        image: (user['picture'] as String?) != null
            ? Image.network(
                user['picture'] as String,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
            : Image.asset(
                'assets/images/user_default.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
      );
    } else {
      print('Request failed with status: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<bool> updateUser(
    {String? name, String? email, String? phoneNumber, File? picture}) async {
  final String url = '${apiUrl}users/${user.id}';

  final prefs = await getPrefs();

  try {
    final request = http.MultipartRequest('PUT', Uri.parse(url))
      ..headers.addAll({
        'Authorization': 'Bearer ${prefs.accessToken}',
      });

    if (name != null && name != user.name && name.isNotEmpty) {
      request.fields['name'] = name;
    }

    if (email != null && email != user.email && email.isNotEmpty) {
      request.fields['email'] = email;
    }

    if (phoneNumber != null &&
        phoneNumber != user.phoneNumber &&
        phoneNumber.isNotEmpty) {
      request.fields['phone_number'] = phoneNumber;
    }

    if (picture != null) {
      final fileBytes = await picture.readAsBytes();
      final mimeType = _getMimeType(picture.path);
      request.files.add(
        http.MultipartFile.fromBytes(
          'picture',
          fileBytes,
          filename: path.basename(picture.path),
          contentType: MediaType.parse(mimeType),
        ),
      );
    }

    final response = await request.send();
    if (response.statusCode == 201) {
      return true;
    }
  } catch (e) {
    print(e);
  } finally {
    // ignore: control_flow_in_finally
    return false;
  }
}

String _getMimeType(String filePath) {
  final extension = path.extension(filePath).toLowerCase();
  switch (extension) {
    case '.jpg':
    case '.jpeg':
      return 'image/jpeg';
    case '.png':
      return 'image/png';
    case '.webp':
      return 'image/webp';
    default:
      return 'application/octet-stream';
  }
}
