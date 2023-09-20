import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
//import 'package:html/dom.dart' as htmlDom;

/*String url = 'https://chatgpt.ai/gpt-4/';
List<String> model = ['gpt-4'];
bool supportsStream = false;
bool needsAuth = false;*/

Future<String> _createCompletion(List<Map<String, String>> messages) async {
  String chat = '';
  for (var message in messages) {
    chat += '${message['role']}: ${message['content']}\n';
  }
  chat += 'assistant: ';

  final response = await http.get(Uri.parse('https://chatgpt.ai/'));

  final document = htmlParser.parse(response.body);
  final elements = document.querySelectorAll(
      '[data-nonce][data-post-id][data-url][data-bot-id][data-width]');
  final nonce = elements[0].attributes['data-nonce']!;
  final postId = elements[0].attributes['data-post-id']!;
  final botId = elements[0].attributes['data-bot-id']!;

  final headers = {
    'authority': 'chatgpt.ai',
    'accept': '*/*',
    'accept-language':
        'en,fr-FR;q=0.9,fr;q=0.8,es-ES;q=0.7,es;q=0.6,en-US;q=0.5,am;q=0.4,de;q=0.3',
    'cache-control': 'no-cache',
    'origin': 'https://chatgpt.ai',
    'pragma': 'no-cache',
    'referer': 'https://chatgpt.ai/gpt-4/',
    'sec-ch-ua':
        '"Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"',
    'sec-ch-ua-mobile': '?0',
    'sec-ch-ua-platform': '"Windows"',
    'sec-fetch-dest': 'empty',
    'sec-fetch-mode': 'cors',
    'sec-fetch-site': 'same-origin',
    'user-agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36',
  };

  final data = {
    '_wpnonce': nonce,
    'post_id': postId,
    'url': 'https://chatgpt.ai/gpt-4',
    'action': 'wpaicg_chat_shortcode_message',
    'message': chat,
    'bot_id': botId
  };

  final response2 = await http.post(
    Uri.parse('https://chatgpt.ai/wp-admin/admin-ajax.php'),
    headers: headers,
    body: data,
  );

  return response2.body;
}

Future<String> chatGPTResponseTest(String message) {
  return _createCompletion(
    [
      {'role': 'user', 'content': 'Hello, GPT-4!'},
      {
        'role': 'assistant',
        'content': 'Hi there!, what can I assist you about Breast Cancer?'
      },
      {'role': 'user', 'content': message},
    ],
  );
}

/*void main() async {
  final result = await _createCompletion(
    model[0],
    [
      {'role': 'user', 'content': 'Hello, GPT-4!'},
      {'role': 'assistant', 'content': 'Hi there!'},
    ],
    supportsStream,
  );

  print(result);
}*/
