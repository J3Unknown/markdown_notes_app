import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:package_tester/models/markdown_note/note_data_model.dart';
import 'package:package_tester/modules/markdown/code_element_builder.dart';
import 'package:package_tester/modules/markdown/custom_anchor_builder.dart';
import 'package:package_tester/modules/markdown/heading_element_builder.dart';
import 'package:package_tester/shared/themes/colors_manager.dart';
import 'package:package_tester/shared/themes/themes_manager.dart';
import 'package:package_tester/shared/util/constants_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkdownFullPreviewScreen extends StatefulWidget {
  const MarkdownFullPreviewScreen({super.key, required this.note});
  final NoteDataModel note;
  @override
  State<MarkdownFullPreviewScreen> createState() =>
      _MarkdownFullPreviewScreenState();
}

class _MarkdownFullPreviewScreenState extends State<MarkdownFullPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    final styleSheet = ConstantsManager.getMarkdownStyle(ThemesManager.isDark);
    final headingBuilder = HeadingElementBuilder(styleSheet: styleSheet);

    return Scaffold(
      appBar: AppBar(title: Text('Preview')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.note.title,
              style: TextStyle(
                color: ThemesManager.isDark
                    ? ColorsManager.white
                    : ColorsManager.black,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(color: Theme.of(context).primaryColor),
            MarkdownBody(
              data: widget.note.content,
              selectable: true,
              styleSheet: styleSheet,
              inlineSyntaxes: [HtmlAnchorSyntax()],
              builders: {
                'custom_anchor': CustomAnchorElementBuilder(
                  keys: headingBuilder.keys,
                ),
                'code': CodeElementBuilder(),
                'h1': headingBuilder,
                'h2': headingBuilder,
                'h3': headingBuilder,
                'h4': headingBuilder,
                'h5': headingBuilder,
                'h6': headingBuilder,
              },
              onTapLink: (text, link, title) async {
                if (link != null) {
                  if (link.startsWith('#')) {
                    final targetId = link.substring(1);
                    final key = headingBuilder.keys[targetId];
                    if (key != null && key.currentContext != null) {
                      Scrollable.ensureVisible(
                        key.currentContext!,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  } else if (await canLaunchUrl(Uri.parse(link))) {
                    launchUrl(Uri.parse(link));
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
