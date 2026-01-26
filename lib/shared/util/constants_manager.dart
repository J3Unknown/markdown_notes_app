import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ConstantsManager{
  static double screenWidth(context) => MediaQuery.of(context).size.width;
  static double screenHeight(context) => MediaQuery.of(context).size.height;

  static final markdownStyle = MarkdownStyleSheet(
    // Links
    a: const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),

    // Paragraphs
    p: const TextStyle(fontSize: 16.0, height: 1.4),
    pPadding: const EdgeInsets.symmetric(vertical: 4.0),

    // Code spans
    code: const TextStyle(
      fontSize: 14.0,
      fontFamily: 'monospace',
      backgroundColor: Color(0xFFEFEFEF),
    ),

    // Headings
    h1: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
    h1Padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),

    h2: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    h2Padding: const EdgeInsets.only(top: 14.0, bottom: 6.0),

    h3: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
    h3Padding: const EdgeInsets.only(top: 12.0, bottom: 6.0),

    h4: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
    h4Padding: const EdgeInsets.only(top: 10.0, bottom: 4.0),

    h5: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
    h5Padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),

    h6: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
    h6Padding: const EdgeInsets.only(top: 6.0, bottom: 2.0),

    // Bold / Italic / Strikethrough
    strong: const TextStyle(fontWeight: FontWeight.bold),
    em: const TextStyle(fontStyle: FontStyle.italic),
    del: const TextStyle(decoration: TextDecoration.lineThrough),

    // Blockquote
    blockquote: const TextStyle(fontSize: 16.0, height: 1.5),
    blockquotePadding: const EdgeInsets.all(12.0),
    blockquoteDecoration: const BoxDecoration(
      border: Border(left: BorderSide(color: Colors.grey, width: 4.0)),
      color: Color(0xFFF7F7F7),
    ),

    // Images
    img: const TextStyle(),

    // Checkboxes
    checkbox: const TextStyle(fontSize: 16.0),

    // Spacing between elements
    blockSpacing: 12.0,

    // Lists
    listIndent: 24.0,
    listBullet: const TextStyle(fontSize: 18.0),
    listBulletPadding: const EdgeInsets.only(right: 8.0),

    // Tables
    tableHead: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16.0,
    ),
    tableBody: const TextStyle(fontSize: 16.0),
    tableHeadAlign: TextAlign.left,
    tablePadding: const EdgeInsets.all(6.0),
    tableBorder: const TableBorder(
      horizontalInside: BorderSide(color: Colors.grey),
      verticalInside: BorderSide(color: Colors.grey),
    ),
    tableScrollbarThumbVisibility: true,
    tableCellsPadding: const EdgeInsets.all(6.0),
    tableCellsDecoration: const BoxDecoration(
      color: Colors.white,
    ),
    tableVerticalAlignment: TableCellVerticalAlignment.middle,

    // Code blocks
    codeblockPadding: const EdgeInsets.all(12.0),
    codeblockDecoration: const BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),

    // Horizontal rule
    horizontalRuleDecoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 1.0, color: Colors.grey),
      ),
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