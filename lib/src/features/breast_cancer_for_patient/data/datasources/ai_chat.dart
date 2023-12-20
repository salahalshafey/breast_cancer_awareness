import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions_without_message.dart';
import '../../../../core/util/functions/string_manipulations_and_search.dart';

import 'api_keys.dart';

abstract class AIChat {
  Future<String> chatResult(String message);
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

/*const test = """**Breast Cancer: A Comprehensive Overview**

**1. Understanding Breast Cancer:**

* Breast cancer is a malignant tumor that forms in the breast tissue.
* It primarily affects women but can also occur in men.
* Risk factors include age, family history, genetic mutations, and lifestyle choices.

**2. Types of Breast Cancer:**

* Invasive ductal carcinoma: Most common type, starts in the milk ducts and spreads to surrounding breast tissue.
* Invasive lobular carcinoma: Begins in the milk-producing glands and spreads to surrounding breast tissue.
* Ductal carcinoma in situ (DCIS): Non-invasive cancer confined to the milk ducts.
* Lobular carcinoma in situ (LCIS): Non-invasive cancer confined to the milk-producing glands.

**3. Breast Cancer Symptoms:**

* Breast lump or thickening
* Changes in breast size, shape, or appearance
* Nipple changes, such as retraction, discharge, or pain
* Skin changes, like dimpling, puckering, or redness
* Swollen lymph nodes under the arm or near the collarbone

**4. Diagnosis:**

* Clinical breast exam
* Mammogram: X-ray of the breast
* Ultrasound: High-frequency sound waves to create images of the breast
* MRI: Magnetic resonance imaging to detect cancer and determine its extent
* Biopsy: Removal of a small tissue sample for examination under a microscope

**5. Treatment Options:**

* Surgery: Lumpectomy (removal of the tumor) or mastectomy (removal of the entire breast)
* Radiation therapy: High-energy X-rays or other forms of radiation to kill cancer cells
* Chemotherapy: Drugs to kill cancer cells throughout the body
* Targeted therapy: Drugs that target specific molecules involved in cancer growth
* Hormone therapy: Drugs to block the effects of hormones that fuel cancer growth
* Immunotherapy: Drugs that boost the body's immune system to fight cancer

**6. Prognosis and Survival Rates:**

* Breast cancer survival rates have significantly improved over the past few decades.
* Survival rates depend on various factors, including cancer stage, type, and treatment response.
* Early detection and prompt treatment are crucial for improving survival outcomes.

**7. Prevention:**

* Maintaining a healthy weight
* Regular physical activity
* Limiting alcohol consumption
* Avoiding tobacco smoke
* Breastfeeding, if possible
* Genetic testing and risk-reducing surgery for individuals with a high risk of breast cancer

**8. Support and Resources:**

* Support groups for breast cancer patients and their families
* Online resources and helplines
* Access to affordable and comprehensive healthcare services

**Remember, breast cancer is treatable, and early detection is key. Regular self-exams, screenings, and prompt medical attention can significantly improve outcomes.** 
""";*/

/*
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
""";*/
