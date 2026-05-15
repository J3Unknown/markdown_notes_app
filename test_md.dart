import 'package:markdown/markdown.dart' as md;

void main() {
  var document = md.Document(extensionSet: md.ExtensionSet.gitHubWeb);
  var nodes = document.parseInline('<a id="foo"></a>');
  print(nodes.first);
}
