import 'package:intl/intl.dart';
import 'package:walletwatch_mobile/common/data/survey_answer.dart';
import 'package:walletwatch_mobile/common/data/suvey_question.dart';
import 'package:walletwatch_mobile/common/helper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<SurveyQuestion>> fetchPersonalityQuestions(String surveyId) async {
  const String url =
      '${apiUrl}personality-surveys/0190cc8f-38db-7e53-9fd1-b7600c63680b/survey-questions?per_page=100';
  final List<SurveyQuestion> results = [];

  final prefs = await getPrefs();

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer ${prefs.accessToken}',
    },
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);

    final sessions = responseBody['data']['survey_questions'] as List<dynamic>;

    for (var session in sessions) {
      final result = SurveyQuestion(
          id: session['id'] as String,
          question: session['question'] as String,
          type: session['type'] as String);

      results.add(result);
    }

    return results;
  } else {
    print('Request failed with status: ${response.statusCode}');
    return List.empty();
  }
}

Future<String?> storePersonalitySurveyResult() async {
  const String url = '${apiUrl}personality-surveys/$SURVEY_ID/survey-results';

  final Map<String, dynamic> resultData = {
    'survey_id': SURVEY_ID,
    'date':
        DateFormat('yyyy-MM-ddTHH:mm:ss+00:00').format(DateTime.now().toUtc()),
  };

    if (isAdmin()) {
    resultData['user_id'] = user.id;
  }

  final prefs = await getPrefs();

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.accessToken}',
      },
      body: jsonEncode(resultData),
    );

    print(response.body);

    final responseBody = jsonDecode(response.body);

    final surveyResult = responseBody['data']['survey_result'] as dynamic;
    return surveyResult['id'] as String;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<bool> storePersonalitySurveyAnswers(
    {required String resultId,
    required List<SurveyAnswer> surveyAnswers}) async {
  final String url = '${apiUrl}survey-results/$resultId/survey-result-answers';

  final prefs = await getPrefs();

  try {
    for (var answer in surveyAnswers) {
      final Map<String, dynamic> answerData = {
        'question_id': answer.questionId,
        'answer': (answer.answer + 1).toString(),
      };

      print(answer.questionId);

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.accessToken}',
        },
        body: jsonEncode(answerData),
      );

      print(response.body);

      if (response.statusCode == 201) {
        continue;
      } else {
        return false;
      }
    }

    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
