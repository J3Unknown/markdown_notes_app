import 'package:go_router/go_router.dart';
import 'package:package_tester/models/markdown_note/note_data_model.dart';
import 'package:package_tester/modules/markdown/markdown_full_preview_screen.dart';
import 'package:package_tester/modules/markdown/markdown_home_screen.dart';

import '../../modules/markdown/markdown_editor_screen.dart';
import '../../modules/markdown/settings_screen.dart';

class RoutesManager {
  static const String home = '/';
  static const String editor = '/editor';
  static const String settings = '/settings';
  static const String preview = '/preview';

  static final GoRouter routes = GoRouter(
    routes: [
      GoRoute(path: home, builder: (context, state) => MarkdownHomeScreen()),
      GoRoute(
        path: editor,
        builder: (context, state) =>
            MarkdownEditorScreen(noteDataModel: state.extra as NoteDataModel?),
      ),
      GoRoute(path: settings, builder: (context, state) => SettingsScreen()),
      GoRoute(
        path: preview,
        builder: (context, state) =>
            MarkdownFullPreviewScreen(note: state.extra as NoteDataModel),
      ),
    ],
  );
}
