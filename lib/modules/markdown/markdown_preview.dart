import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:package_tester/modules/markdown/code_element_builder.dart';
import 'package:package_tester/modules/markdown/custom_anchor_builder.dart';
import 'package:package_tester/modules/markdown/heading_element_builder.dart';
import 'package:package_tester/shared/themes/colors_manager.dart';
import 'package:package_tester/shared/themes/themes_manager.dart';
import 'package:package_tester/shared/util/constants_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class DefaultMarkdownPreviewAlert extends StatelessWidget {
  const DefaultMarkdownPreviewAlert({super.key, required this.markdown});
  final String markdown;
  @override
  Widget build(BuildContext context) {
    final isDark = ThemesManager.isDark;
    final styleSheet = ConstantsManager.getMarkdownStyle(isDark);
    final headingBuilder = HeadingElementBuilder(styleSheet: styleSheet);
    return AlertDialog(
      title: Text(
        'Preview',
        style: TextStyle(
          color: isDark ? ColorsManager.white : ColorsManager.black,
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shadowColor: ColorsManager.gray,
      elevation: 0,
      surfaceTintColor: ColorsManager.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isDark
            ? BorderSide(color: ColorsManager.gray.withAlpha(120), width: 1)
            : BorderSide.none,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        child: SingleChildScrollView(
          child: MarkdownBody(
            data: markdown,
            styleSheet: styleSheet,
            selectable: true,
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
        ),
      ),
    );
  }
}
