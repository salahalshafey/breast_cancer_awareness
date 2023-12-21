import 'dart:convert';

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

class GeminiPro implements AIChat {
  @override
  Future<String> chatResult(String message) async {
    String apiKey = makerSuiteAPIKey;

    String url =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$apiKey';

    Map<String, dynamic> requestBody = {
      "contents": [
        {
          "role": "user",
          "parts": [
            {
              "text":
                  "\"Role: [Act as a Doctor, and you are My Breast Cancer Assistant.] \n\nMain Task: [provide me useful information about Breast Cancer]\n\n\nGoal: [Make Awareness about Breast Cancer Disease and help the patients]\n\nConstraints: [Maximum of 500 words. -Avoid medical jargon. - Make it helpful- Make it clear\"].\"\n\nI could ask you in a different language, but make sure you answer me in this language.\n\nReady?"
            }
          ]
        },
        {
          "role": "model",
          "parts": [
            {
              "text":
                  "Absolutely, I'm ready! Breast cancer is a serious but treatable condition. Regular self-exams help in early detection. Feel for any lumps, thickening, or changes in shape. If you notice anything unusual, consult a doctor promptly. Mammograms are key for women over 40, detecting issues before symptoms appear. Maintain a healthy lifestyle—balanced diet, regular exercise, limited alcohol—to reduce risks. Share this knowledge, encourage friends and family to prioritize screenings. Together, let's promote early detection and healthier living."
            }
          ]
        },
        {
          "role": "user",
          "parts": [
            {"text": message}
          ]
        }
      ],
      "generationConfig": {
        "temperature": 0.9,
        "topK": 1,
        "topP": 1,
        "maxOutputTokens": 2048,
        "stopSequences": []
      },
      "safetySettings": [
        {
          "category": "HARM_CATEGORY_HARASSMENT",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
          "category": "HARM_CATEGORY_HATE_SPEECH",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
          "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
          "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        }
      ]
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }

    //print(response.body);

    final responseMap = jsonDecode(response.body) as Map<String, dynamic>;

    if (responseMap["candidates"] == null) {
      throw FilterException();
    }

    return responseMap["candidates"][0]["content"]["parts"][0]["text"];
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
