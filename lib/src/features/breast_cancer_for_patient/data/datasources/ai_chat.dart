import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/functions/string_manipulations_and_search.dart';

import 'api_keys.dart';

abstract class AIChat {
  Future<String> chatResult(String message);
}

class MakerSuite implements AIChat {
  @override
  Future<String> chatResult(String message) async {
    /* const apiKey = makerSuiteAPIKey;

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

    return responseMap["candidates"][0]["content"];*/

    return testString;
  }
}

const testString =
    """Flutter Speech to Text is a **plugin that** allows you to easily integrate `speech recognition` into your Flutter apps. It uses the Google Cloud Speech-to-Text API to convert audio to text, and it supports a variety of languages.

To use `Flutter Speech to Text`, you first need to create a project in the Google Cloud Platform Console. Once you have created a project, you need to enable the Google Cloud Speech-to-Text API.

After you have enabled the API, you need to create a service account and download the JSON key file. You will need to provide the JSON key file to the Flutter Speech to Text plugin.

To **install** the Flutter Speech to Text plugin, you can use the following command:

```
pub add flutter_speech_to_text
```

Once the plugin is installed, you can use it in your Flutter app. The following code snippet shows how to use the Flutter Speech to Text plugin to convert audio to text:

```
import 'package:flutter/material.dart';
import 'package:flutter_speech_to_text/flutter_speech_to_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Speech to Text',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Speech to Text'),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () async {
              // Create a SpeechToText object.
              final speechToText = SpeechToText();

              // Set the language code.
              speechToText.setLanguageCode('en-US');

              // Start listening for speech.
              final result = await speechToText.listen();

              // Print the result.
              print(result.text);
            },
            child: Text('Listen'),
          ),
        ),
      ),
    );
  }
}
```

When you run the **app**, you will see a button that says "Listen". When you click on the button, the app will start listening for speech. The text that is spoken will be converted to text and printed to the `console`.

* that is `awesom` man you are **great** if you think
* **you** can visit thi link www.google.com to chech fo ervery thing and https://www.hyth.com
* `Emial` is salahalshafey@gmail.com is valid.

Flutter Speech to Text is a powerful tool that can be used to add speech recognition to your Flutter apps. It is easy to use and supports a variety of languages.
""";

const testString2 =
    """فلاتر Speech to Text هو **مكون إضافي** يسمح لك بدمج `التعرف على الكلام` بسهولة في تطبيقات Flutter. ويستخدم Google Cloud Speech-to-Text API لتحويل الصوت إلى نص، ويدعم مجموعة متنوعة من اللغات.

لاستخدام `Flutter Speech to Text`، تحتاج أولاً إلى إنشاء مشروع في Google Cloud Platform Console. بمجرد إنشاء مشروع، تحتاج إلى تمكين Google Cloud Speech-to-Text API.

بعد تمكين واجهة برمجة التطبيقات (API)، يتعين عليك إنشاء حساب خدمة وتنزيل ملف مفتاح JSON. سوف تحتاج إلى تقديم ملف مفتاح JSON إلى البرنامج المساعد Flutter Speech to Text.

**لتثبيت** المكون الإضافي Flutter Speech to Text، يمكنك استخدام الأمر التالي:

```
حانة إضافة Flutter_Speech_to_text
```

بمجرد تثبيت المكون الإضافي، يمكنك استخدامه في تطبيق Flutter. يوضح مقتطف الكود التالي كيفية استخدام البرنامج المساعد Flutter Speech to Text لتحويل الصوت إلى نص:

```
import 'package:flutter/material.dart';
import 'package:flutter_speech_to_text/flutter_speech_to_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Speech to Text',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Speech to Text'),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () async {
              // Create a SpeechToText object.
              final speechToText = SpeechToText();

              // Set the language code.
              speechToText.setLanguageCode('en-US');

              // Start listening for speech.
              final result = await speechToText.listen();

              // Print the result.
              print(result.text);
            },
            child: Text('Listen'),
          ),
        ),
      ),
    );
  }
}
```

عند تشغيل **التطبيق**، سترى زرًا مكتوبًا عليه "استمع". عند النقر على الزر، سيبدأ التطبيق في الاستماع للكلام. سيتم تحويل النص المنطوق إلى نص وطباعته على "وحدة التحكم".

* هذا رجل رائع، أنت ** عظيم ** إذا كنت تعتقد ذلك
* **أنت** يمكنك زيارة الرابط www.google.com للتحقق من كل شيء وhttps://www.hyth.com
* و`Emial` هو salahalshafey@gmail.com صالح.

يعد Flutter Speech to Text أداة قوية يمكن استخدامها لإضافة ميزة التعرف على الكلام إلى تطبيقات Flutter. إنه سهل الاستخدام ويدعم مجموعة متنوعة من اللغات.
""";
