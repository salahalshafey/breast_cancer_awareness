import 'dart:convert';
import 'dart:async';

import 'package:firebase_ai/firebase_ai.dart' hide ServerException;
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions_without_message.dart';
import '../../../../core/util/functions/string_manipulations_and_search.dart';

import 'api_keys.dart';

abstract class AIChat {
  Future<String> chatResult(String message);
}

abstract class AIChatStream {
  Stream<String> chatResult(String message);
}

// dart
// Requires: import 'dart:async'; import 'dart:convert';
//           import 'package:http/http.dart' as http;
// And your own exceptions: ServerException, FilterException

// dart
// pubspec: firebase_core, firebase_ai, http (if you still need it elsewhere)
// Make sure you have your own ServerException / FilterException types as before.

class Gemini25ProFirebase implements AIChat {
  Gemini25ProFirebase();

  // Keep your original instruction block (shortened here)
  static const String _preamble = """
Role: Act as a Doctor, and you are My Breast Cancer Assistant.
Main Task: provide useful information about Breast Cancer.
Goal: Make awareness about Breast Cancer and help patients.
Constraints: Max 500 words. Avoid medical jargon. Be helpful and clear.
If I ask in another language, answer in that language.
""";

  // Optional: your original canned model reply (keeps the "history" behavior)
  static const String _seedReply =
      "Absolutely, I'm ready! Breast cancer is a serious but treatable condition..."
      " Together, let's promote early detection and healthier living.";

  @override
  Future<String> chatResult(String message) async {
    try {
      // Build the model without thinkingConfig (Firebase AI SDK doesn't support it)
      final model = FirebaseAI.googleAI().generativeModel(
        model: 'gemini-2.5-flash',
        generationConfig: GenerationConfig(
          temperature: 0.9,
          topK: 1,
          topP: 1.0,
          maxOutputTokens: 2048,
        ),
      );

      // Keep your prior conversation style (preamble + model greeting)
      final history = <Content>[
        Content('user', [TextPart(_preamble)]),
        Content('model', [TextPart(_seedReply)]),
      ];

      final chat = model.startChat(history: history);

      final response = await chat.sendMessage(
        Content('user', [TextPart(message)]),
      );

      print(response);

      final text = response.text?.trim();
      if (text == null || text.isEmpty) {
        // Mirrors your old behavior when candidates were filtered/empty
        throw FilterException();
      }
      return text;
    } catch (_) {
      // Keep same surface behavior as your old code

      print(_);
      throw ServerException();
    }
  }
}

///////////////////////////////////////////////////////////
////////////////////////////////////////
/////////////////////

class MakerSuite implements AIChat {
  @override
  Future<String> chatResult(String message) async {
    const apiKey = makerSuiteAPIKey;

    final breastCancer =
        firstCharIsArabic(message) ? "\"سرطان الثدي\"" : "\"Breast Cancer\"";

    // Define the request data
    Map<String, dynamic> requestData = {
      "prompt": {
        "context": "Breast Cancer Assistant",
        "examples": [
          {
            "input": {"content": "hi there"},
            "output": {
              "content":
                  "Hi there! How can I help you today about breast cancer?"
            }
          }
        ],
        "messages": [
          {"content": '$message $breastCancer'}
        ]
      },
      "temperature": 0.25,
      "top_k": 40,
      "top_p": 0.95,
      "candidate_count": 1
    };

    // Convert the request data to JSON
    final requestDataJson = jsonEncode(requestData);

    // Define the URL
    const apiUrl =
        'https://generativelanguage.googleapis.com/v1beta2/models/chat-bison-001:generateMessage?key=$apiKey';

    // Send a POST request
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: requestDataJson,
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }

    //print(response.body);

    final responseMap = jsonDecode(response.body) as Map<String, dynamic>;

    if (responseMap["candidates"] == null) {
      throw FilterException();
    }

    return responseMap["candidates"][0]["content"];
  }
}

///////////////////////////////////////////////////////////
////////////////////////////////////////
/////////////////////

class ChatGPT implements AIChat {
  @override
  Future<String> chatResult(String message) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    const apiKey = chatGPTApiKey;

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final body = jsonEncode({
      'model': 'gpt-3.5-turbo',
      'messages': [
        {'role': 'user', 'content': message}
      ],
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final responseMap = jsonDecode(response.body) as Map<String, dynamic>;

    return responseMap["choices"][0]["message"]["content"];
  }
}

///////////////////////////////////////////////////////////
////////////////////////////////////////
/////////////////////

class ChatGPTStream implements AIChatStream {
  @override
  Stream<String> chatResult(String message) async* {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    const apiKey = chatGPTApiKey;

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final body = jsonEncode({
      'model': 'gpt-3.5-turbo',
      'messages': [
        {'role': 'user', 'content': message}
      ],
      'stream': true,
    });

    final client = http.Client();
    final request = http.Request('POST', url);
    request.headers.addAll(headers);
    request.body = body;

    final response = await client.send(request);
    await for (String subresponse in response.stream.transform(utf8.decoder)) {
      // print(subresponse.substring(6));
      subresponse = subresponse.substring(6);
      //print(subresponse);
      try {
        final subresponseMap = jsonDecode(subresponse) as Map<String, dynamic>;

        yield (subresponseMap["choices"][0]["delta"]["content"] as String?) ??
            "";
      } catch (error) {
        throw ServerException();
      }
    }
  }
}
