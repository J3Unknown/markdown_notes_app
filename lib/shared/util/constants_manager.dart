import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ConstantsManager {
  static double screenWidth(context) => MediaQuery.of(context).size.width;
  static double screenHeight(context) => MediaQuery.of(context).size.height;

  static MarkdownStyleSheet getMarkdownStyle(bool isDark) {
    final textColor = isDark
        ? const Color(0xFFE0E0E0)
        : const Color(0xFF1A1A1A);
    final headingColor = isDark
        ? const Color(0xFFF5F5F5)
        : const Color(0xFF111111);
    final linkColor = isDark
        ? const Color(0xFF64B5F6)
        : const Color(0xFF1976D2);
    final codeBackground = isDark
        ? const Color(0xFF2A2A2A)
        : const Color(0xFFEFEFEF);
    final codeBlockBackground = isDark
        ? const Color(0xFF1E1E1E)
        : const Color(0xFFFAFAFA);
    final blockquoteBackground = isDark
        ? const Color(0xFF1A1A2E)
        : const Color(0xFFF7F7F7);
    final blockquoteBorderColor = isDark
        ? const Color(0xFF64B5F6)
        : Colors.grey;
    final tableCellColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final tableBorderColor = isDark ? const Color(0xFF555555) : Colors.grey;
    final hrColor = isDark ? const Color(0xFF555555) : Colors.grey;
    final codeTextColor = isDark
        ? const Color(0xFFCE9178)
        : const Color(0xFF333333);

    return MarkdownStyleSheet(
      // Links
      a: TextStyle(color: linkColor, decoration: TextDecoration.underline),

      // Paragraphs
      p: TextStyle(fontSize: 16.0, height: 1.4, color: textColor),
      pPadding: const EdgeInsets.symmetric(vertical: 4.0),

      // Code spans
      code: TextStyle(
        fontSize: 14.0,
        fontFamily: 'monospace',
        backgroundColor: codeBackground,
        color: codeTextColor,
      ),

      // Headings
      h1: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: headingColor,
      ),
      h1Padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),

      h2: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: headingColor,
      ),
      h2Padding: const EdgeInsets.only(top: 14.0, bottom: 6.0),

      h3: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: headingColor,
      ),
      h3Padding: const EdgeInsets.only(top: 12.0, bottom: 6.0),

      h4: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: headingColor,
      ),
      h4Padding: const EdgeInsets.only(top: 10.0, bottom: 4.0),

      h5: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: headingColor,
      ),
      h5Padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),

      h6: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: headingColor,
      ),
      h6Padding: const EdgeInsets.only(top: 6.0, bottom: 2.0),

      // Bold / Italic / Strikethrough
      strong: TextStyle(fontWeight: FontWeight.bold, color: textColor),
      em: TextStyle(fontStyle: FontStyle.italic, color: textColor),
      del: TextStyle(decoration: TextDecoration.lineThrough, color: textColor),

      // Blockquote
      blockquote: TextStyle(
        fontSize: 16.0,
        height: 1.5,
        color: textColor.withAlpha(200),
      ),
      blockquotePadding: const EdgeInsets.all(12.0),
      blockquoteDecoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: blockquoteBorderColor, width: 4.0),
        ),
        color: blockquoteBackground,
      ),

      // Images
      img: TextStyle(color: textColor),

      // Checkboxes
      checkbox: TextStyle(fontSize: 16.0, color: textColor),

      // Spacing between elements
      blockSpacing: 12.0,

      // Lists
      listIndent: 24.0,
      listBullet: TextStyle(fontSize: 18.0, color: textColor),
      listBulletPadding: const EdgeInsets.only(right: 8.0),

      // Tables
      tableHead: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
        color: headingColor,
      ),
      tableBody: TextStyle(fontSize: 16.0, color: textColor),
      tableHeadAlign: TextAlign.left,
      tablePadding: const EdgeInsets.all(6.0),
      tableBorder: TableBorder(
        horizontalInside: BorderSide(color: tableBorderColor),
        verticalInside: BorderSide(color: tableBorderColor),
      ),
      tableScrollbarThumbVisibility: true,
      tableCellsPadding: const EdgeInsets.all(6.0),
      tableCellsDecoration: BoxDecoration(color: tableCellColor),
      tableVerticalAlignment: TableCellVerticalAlignment.middle,

      // Code blocks
      codeblockPadding: const EdgeInsets.all(12.0),
      codeblockDecoration: BoxDecoration(
        color: codeBlockBackground,
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      ),

      // Horizontal rule
      horizontalRuleDecoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1.0, color: hrColor)),
      ),

      // Alignment defaults
      textAlign: WrapAlignment.start,
      h1Align: WrapAlignment.start,
      h2Align: WrapAlignment.start,
      h3Align: WrapAlignment.start,
      h4Align: WrapAlignment.start,
      h5Align: WrapAlignment.start,
      h6Align: WrapAlignment.start,
      unorderedListAlign: WrapAlignment.start,
      orderedListAlign: WrapAlignment.start,
      blockquoteAlign: WrapAlignment.start,
      codeblockAlign: WrapAlignment.start,

      // Typography
      superscriptFontFeatureTag: 'sups',
    );
  }
}
