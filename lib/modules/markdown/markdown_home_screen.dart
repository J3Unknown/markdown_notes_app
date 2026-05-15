import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:package_tester/core/bloc/main_bloc.dart';
import 'package:package_tester/models/markdown_note/note_data_model.dart';
import 'package:package_tester/shared/themes/colors_manager.dart';
import 'package:package_tester/shared/themes/themes_manager.dart';
import 'package:package_tester/shared/util/components.dart';
import 'package:package_tester/shared/util/icons_manager.dart';
import 'package:package_tester/shared/util/routes_manager.dart';

import '../../shared/repo/notes_repo.dart';

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
      floatingActionButton: SpeedDial(
        icon: IconsManager.addIcon,
        activeIcon: Icons.close,
        spacing: 8,
        children: [
          SpeedDialChild(
            child: Icon(IconsManager.addIcon),
            label: 'New Note',
            foregroundColor: ColorsManager.black,
            labelStyle: TextStyle(color: ColorsManager.black),
            onTap: () {
              GoRouter.of(context).push(RoutesManager.editor);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.file_open_outlined),
            label: 'Import .md',
            foregroundColor: ColorsManager.black,
            labelStyle: TextStyle(color: ColorsManager.black),
            onTap: () => _importMarkdownFile(),
          ),
        ],
      ),
    );
  }

  Future<void> _importMarkdownFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['md'],
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final content = await file.readAsString();

      final int newId = getNextId();
      final note = NoteDataModel(
        id: newId,
        title: '',
        content: content,
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
        colorHex: ThemesManager.accent.value.toRadixString(16).replaceAll('0xff', ''),
      );

      await boxes.put('key_$newId', note);
      cubit.addNote(note);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Markdown file imported successfully'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }
}
