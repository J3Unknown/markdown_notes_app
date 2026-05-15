import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:package_tester/models/markdown_note/note_data_model.dart';
import 'package:package_tester/shared/themes/colors_manager.dart';
import 'package:package_tester/shared/themes/themes_manager.dart';
import 'package:package_tester/shared/util/constants_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkdownFullPreviewScreen extends StatefulWidget {
  const MarkdownFullPreviewScreen({super.key, required this.note});
  final NoteDataModel note;
  @override
  State<MarkdownFullPreviewScreen> createState() => _MarkdownFullPreviewScreenState();
}

class _MarkdownFullPreviewScreenState extends State<MarkdownFullPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Preview'),),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.note.title,
              style: TextStyle(color: ThemesManager.isDark?ColorsManager.white:ColorsManager.black, fontSize: 34, fontWeight: FontWeight.bold),
            ),
            Divider(color: Theme.of(context).primaryColor,),
            Expanded(
              child: Markdown(
                data: widget.note.content,
                selectable: true,
                styleSheet: ConstantsManager.getMarkdownStyle(ThemesManager.isDark),
                onTapLink: (text, link, title) async {
                  if (link != null) {
                    if (await canLaunchUrl(Uri.parse(link))) {
                      launchUrl(Uri.parse(link));
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
