import 'package:flutter/material.dart';

import '../../../../core/util/widgets/custom_error_widget.dart';
import '../../../../core/util/widgets/dots_loading.dart';

class ChatGPTSearchResult extends StatelessWidget {
  const ChatGPTSearchResult({
    super.key,
    required this.searchWord,
    required this.textToSpeech,
  });
  final String searchWord;
  final bool textToSpeech;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: chatGPT(searchWord),
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
        if (textToSpeech) {
          // handleTextToSpeech(date);
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
        // throw Error();
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
