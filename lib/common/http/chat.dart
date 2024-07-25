import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:walletwatch_mobile/common/data/chat_session.dart';
import 'package:walletwatch_mobile/common/data/chat_message.dart';
import 'package:walletwatch_mobile/common/helper.dart';

Future<List<ChatSession>> fetchChats() async {
  const String url = '${apiUrl}chat-sessions?per_page=100';
  final List<ChatSession> results = [];

  final prefs = await getPrefs();

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer ${prefs.accessToken}',
    },
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);

    final sessions = responseBody['data']['chat_sessions'] as List<dynamic>;

    for (var session in sessions) {
      final result = ChatSession(
          id: session['id'] as String, title: session['title'] as String);

      results.add(result);
    }

    return results;
  } else {
    print('Request failed with status: ${response.statusCode}');
    return List.empty();
  }
}

Future<List<ChatMessage>> fetchChatMessages(ChatSession session) async {
  final String url =
      '${apiUrl}chat-sessions/${session.id}/chat-messages?per_page=1000&sort=created_at';
  final List<ChatMessage> results = [];

  final prefs = await getPrefs();

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer ${prefs.accessToken}',
    },
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);

    final messages = responseBody['data']['chat_messages'] as List<dynamic>;

    for (var message in messages) {
      ChatMessage result = ChatMessage(
          id: message['id'] as String,
          sender: message['sender'] as String,
          message: message['message'] as String,
          hash: message['hash'] as String,
          status: message['status'] as String,
          createdAt: DateTime.parse(message['created_at']).millisecondsSinceEpoch,
      );
      results.add(result);
    }

    return results;
  } else {
    print('Request failed with status: ${response.statusCode}');
    return List.empty();
  }
}

Future<bool> storeChatMessages(
    {required String message, required ChatSession session}) async {
  final String url = '${apiUrl}chat-sessions/${session.id}/chat-messages';

  final Map<String, dynamic> messageData = {
    'message': message,
  };

  final prefs = await getPrefs();

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.accessToken}',
      },
      body: jsonEncode(messageData),
    );

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> storeChatSession({required String title}) async {
  const String url = '${apiUrl}chat-sessions';

  final Map<String, dynamic> messageData = {
    'user_id': user.id,
    'title': title,
  };

  final prefs = await getPrefs();

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.accessToken}',
      },
      body: jsonEncode(messageData),
    );

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
