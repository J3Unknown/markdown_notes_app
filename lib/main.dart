import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_tester/models/markdown_note/note_data_model.dart';
import 'package:package_tester/shared/repo/notes_repo.dart';
import 'package:package_tester/shared/themes/themes_manager.dart';
import 'package:package_tester/shared/util/routes_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/bloc/main_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteDataModelAdapter());
  boxes = await Hive.openBox<NoteDataModel>('notes');
  ThemesManager theme = ThemesManager();
  await theme.init();
  runApp(MyApp(themesManager: theme,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.themesManager});
  final ThemesManager? themesManager;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: themesManager,
      child: Consumer<ThemesManager>(
        builder: (_, theme, _) => BlocProvider(
          create: (context) => MainCubit(),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemesManager.lightTheme,
            darkTheme: ThemesManager.darkTheme,
            themeMode: ThemesManager.themeMode,
            routerConfig: RoutesManager.routes,
          ),
        ),
      ),
    );
  }
}