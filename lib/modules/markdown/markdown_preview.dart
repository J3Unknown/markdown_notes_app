import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:package_tester/shared/themes/colors_manager.dart';
import 'package:package_tester/shared/util/constants_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class DefaultMarkdownPreviewAlert extends StatelessWidget {
  const DefaultMarkdownPreviewAlert({super.key, required this.markdown});
  final String markdown;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Preview'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shadowColor: ColorsManager.gray,
      elevation: 0,
      surfaceTintColor: ColorsManager.transparent,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Markdown(
          data: markdown,
          styleSheet: ConstantsManager.markdownStyle,
          selectable: true,
          onTapLink: (text, link, title) async {
            if (link != null) {
              if (await canLaunchUrl(Uri.parse(link))) {
                launchUrl(Uri.parse(link));
              }
            }
          },
        ),
      ),
    );
  }
}