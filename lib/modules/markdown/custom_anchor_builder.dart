import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

/// Syntax to parse `<a name="some-name"></a>` or `<a id="some-id"></a>`
class HtmlAnchorSyntax extends md.InlineSyntax {
  HtmlAnchorSyntax() : super(r'<a\s+(?:name|id)="([^"]+)">\s*</a>');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final anchorName = match[1]!;
    final element = md.Element('custom_anchor', [md.Text('')]);
    element.attributes['id'] = anchorName;
    parser.addNode(element);
    return true;
  }
}

/// Builder for `<custom_anchor>` tags
class CustomAnchorElementBuilder extends MarkdownElementBuilder {
  final Map<String, GlobalKey> keys;

  CustomAnchorElementBuilder({required this.keys});

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final id = element.attributes['id'];
    if (id != null) {
      final key = GlobalKey();
      keys[id] = key;
      return SizedBox(
        key: key,
        width: 0,
        height: 0,
      );
    }
    return null;
  }
}
