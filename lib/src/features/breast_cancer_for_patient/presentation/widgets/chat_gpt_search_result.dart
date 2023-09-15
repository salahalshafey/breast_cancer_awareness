import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:wakelock/wakelock.dart';

import '../../../../core/util/widgets/custom_error_widget.dart';
import '../../../../core/util/widgets/dots_loading.dart';

class ChatGPTSearchResult extends StatefulWidget {
  const ChatGPTSearchResult({
    super.key,
    required this.searchWord,
    required this.textToSpeech,
    required this.flutterTts,
  });

  final String searchWord;
  final bool textToSpeech;
  final FlutterTts flutterTts;

  @override
  State<ChatGPTSearchResult> createState() => _ChatGPTSearchResultState();
}

class _ChatGPTSearchResultState extends State<ChatGPTSearchResult> {
  @override
  void initState() {
    widget.flutterTts.setCompletionHandler(() {
      Wakelock.disable();
    });

    widget.flutterTts.setCancelHandler(() {
      Wakelock.disable();
    });

    super.initState();
  }

  @override
  void dispose() {
    widget.flutterTts.stop();
    Wakelock.disable();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: chatGPT(widget.searchWord),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: CustomErrorWidget(error: snapshot.error.toString()),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: DotsLoading());
        }

        final data = snapshot.data!;
        if (widget.textToSpeech) {
          widget.flutterTts.speak(data);
          Wakelock.enable();
        }

        return ListView(
          padding: const EdgeInsets.all(0),
          children: [
            Text(
              data,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color.fromRGBO(199, 40, 107, 1),
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
          ], //.animate(interval: 100.ms).fade().moveX(),
        );
      },
    );
  }
}

Future<String> chatGPT(String searchWord) => Future.delayed(
      const Duration(seconds: 3),
      () {
        //throw Error();
        return "search results for $searchWord ..... \n\n" * 20;
      },
    );

extension on String {
  String operator *(int num) {
    String res = "";
    for (int i = 0; i < num; i++) {
      res += this;
    }
    return res;
  }
}
