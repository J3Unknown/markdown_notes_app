import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class HeadingElementBuilder extends MarkdownElementBuilder {
  final Map<String, GlobalKey> keys = {};
  final MarkdownStyleSheet styleSheet;

  HeadingElementBuilder({required this.styleSheet});

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    String text = element.textContent;
    // create a clean ID from the text that matches standard markdown (e.g., "1. Syntax & Types" -> "1-syntax--types")
    String id = text.toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '') // Remove punctuation
        .replaceAll(RegExp(r'\s'), '-');      // Replace spaces with hyphens
    
    final key = GlobalKey();
    keys[id] = key;

    EdgeInsets padding = EdgeInsets.zero;
    switch (element.tag) {
      case 'h1':
        padding = styleSheet.h1Padding ?? EdgeInsets.zero;
        break;
      case 'h2':
        padding = styleSheet.h2Padding ?? EdgeInsets.zero;
        break;
      case 'h3':
        padding = styleSheet.h3Padding ?? EdgeInsets.zero;
        break;
      case 'h4':
        padding = styleSheet.h4Padding ?? EdgeInsets.zero;
        break;
      case 'h5':
        padding = styleSheet.h5Padding ?? EdgeInsets.zero;
        break;
      case 'h6':
        padding = styleSheet.h6Padding ?? EdgeInsets.zero;
        break;
    }

    return Padding(
      key: key,
      padding: padding,
      child: SizedBox(
        width: double.infinity,
        child: SelectableText(
          text,
          style: preferredStyle,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
