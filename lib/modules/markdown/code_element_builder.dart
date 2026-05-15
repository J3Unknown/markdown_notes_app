import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/atom-one-dark.dart';
import 'package:flutter_highlighter/themes/atom-one-light.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:package_tester/shared/themes/themes_manager.dart';

class CodeElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    var language = '';

    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String;
      language = lg.replaceFirst('language-', '');
    }

    // If there is no language, it might be an inline code or just a generic code block.
    // We can fallback to default flutter_markdown rendering for inline code by returning null,
    // or just render it using HighlightView without a specific language.
    // Usually inline codes don't have a newline in textContent, but it's not a strict rule.
    // Let's render as HighlightView if there's a language, otherwise if it's block (contains \n) render as HighlightView without language.
    bool isBlock = element.textContent.contains('\n');

    if (language.isEmpty && !isBlock) {
      // Let the default flutter_markdown handle inline code
      return null;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemesManager.isDark
            ? const Color(0xff282c34)
            : const Color(0xfffafafa),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SelectionArea(
          child: HighlightView(
            element.textContent,
            language: language.isEmpty ? 'plaintext' : language,
            theme: ThemesManager.isDark ? atomOneDarkTheme : atomOneLightTheme,
            padding: const EdgeInsets.all(8),
            textStyle: TextStyle(
              fontFamily: preferredStyle?.fontFamily ?? 'monospace',
              fontSize: preferredStyle?.fontSize ?? 14.0,
            ),
          ),
        ),
      ),
    );
  }
}
