import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/util/functions/string_manipulations_and_search.dart';
import '../../../../../core/util/widgets/custom_card.dart';
import '../../../../../core/util/widgets/linkify_text.dart';

class NoteDescription extends StatelessWidget {
  const NoteDescription({
    required this.icon,
    required this.title,
    this.description,
    this.child,
    Key? key,
  }) : super(key: key);

  final Icon icon;
  final String title;
  final String? description;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(25),
      elevation: 5,
      onTap: () {},
      child: Column(
        children: [
          Row(
            // textDirection: TextDirection.rtl, // for arabic languge
            children: [
              icon,
              const SizedBox(width: 10),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 15),
          LinkifyText(
            text: description ?? "",
            textDirection: firstCharIsArabic(description ?? "")
                ? TextDirection.rtl
                : TextDirection.ltr,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
            linkStyle: const TextStyle(
              fontSize: 16,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            onOpen: (link, linkType) {
              if (linkType == TextType.phoneNumber) {
                launchUrl(Uri.parse('tel:$link'));
              } else if (linkType == TextType.email) {
                launchUrl(Uri.parse('mailto:$link'));
              } else if (link.startsWith('www.')) {
                launchUrl(
                  Uri.parse('https:$link'),
                  mode: LaunchMode.externalApplication,
                );
              } else {
                launchUrl(
                  Uri.parse(link),
                  mode: LaunchMode.externalApplication,
                );
              }
            },
          ),
          if (child != null) ...[const SizedBox(height: 10), child!],
        ],
      ),
    );
  }
}
