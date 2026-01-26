import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:package_tester/core/bloc/main_bloc.dart';
import 'package:package_tester/models/markdown_note/note_data_model.dart';
import 'package:package_tester/shared/themes/colors_manager.dart';
import 'package:package_tester/shared/themes/themes_manager.dart';
import 'package:package_tester/shared/util/icons_manager.dart';
import 'package:package_tester/shared/util/routes_manager.dart';

import '../../shared/repo/notes_repo.dart';
import 'markdown_preview.dart';

class MarkdownHomeScreen extends StatefulWidget {
  const MarkdownHomeScreen({super.key});

  @override
  State<MarkdownHomeScreen> createState() => _MarkdownHomeScreenState();
}

class _MarkdownHomeScreenState extends State<MarkdownHomeScreen> {
  late final MainCubit cubit;

  @override
  void initState() {
    cubit = context.read<MainCubit>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: (){
              GoRouter.of(context).push(RoutesManager.settings);
            },
            icon: Icon(IconsManager.settingsIcon)
          )
        ],
      ),
      body: BlocBuilder(
        bloc: cubit,
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.separated(
            itemBuilder: (context, index) {
              NoteDataModel note = boxes.getAt(index);
              return CupertinoContextMenu(
                enableHapticFeedback: true,
                actions: [
                  CupertinoContextMenuAction(
                    onPressed: () {
                      MainCubit.get(context).deleteNote(index);
                      Navigator.pop(context);
                    },
                    isDefaultAction: true,
                    isDestructiveAction: true,
                    trailingIcon: IconsManager.deleteIcon,
                    child: Text('Delete'),
                  ),
                ],
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 150,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                    color: ThemesManager.isDark?ColorsManager.darkThemePrimaryColor:ColorsManager.lightThemePrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          spacing: 10,
                          children: [
                            Text(note.title, style: Theme.of(context).textTheme.headlineMedium, maxLines: 1, overflow: TextOverflow.ellipsis,),
                            Text(note.content, style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorsManager.darkThemeSecondaryColor), maxLines: 2, overflow: TextOverflow.ellipsis,)
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(IconsManager.eyeIcon),
                            onPressed: () {
                              GoRouter.of(context).push(RoutesManager.preview, extra: boxes.getAt(index));
                            },
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(IconsManager.editIcon),
                            onPressed: () {
                              GoRouter.of(context).push(RoutesManager.editor, extra: boxes.getAt(index));
                            },
                          ),

                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 10,),
            itemCount: boxes.length,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          GoRouter.of(context).push(RoutesManager.editor);
        },
        child: Icon(IconsManager.addIcon),
      ),
    );
  }
}
