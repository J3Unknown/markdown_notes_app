import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:package_tester/models/markdown_note/note_data_model.dart';
import 'package:package_tester/shared/themes/colors_manager.dart';
import 'package:package_tester/shared/themes/themes_manager.dart';
import 'package:package_tester/shared/util/icons_manager.dart';

import '../../shared/repo/notes_repo.dart';
import '../../shared/util/components.dart';
import 'markdown_preview.dart';

class MarkdownEditorScreen extends StatefulWidget {
  const MarkdownEditorScreen({super.key, this.noteDataModel});
  final NoteDataModel? noteDataModel;
  @override
  State<MarkdownEditorScreen> createState() => _MarkdownEditorScreenState();
}

class _MarkdownEditorScreenState extends State<MarkdownEditorScreen> {
  late NoteDataModel? note;
  int? currentId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.noteDataModel != null) {
      note = widget.noteDataModel;
      currentId = note!.id;
      _titleController.text = note!.title;
      _contentController.text = note!.content;
    } else {
      note = NoteDataModel(id: 0, title: '', content: '', createdAt: '', updatedAt: '', colorHex: '');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editor')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10,
            children: [
              DefaultTextField(
                titleController: _titleController,
                maxLines: 1,
                keyboardType: TextInputType.text,
                fontSize: 30,
                hint: 'title',
                onChanged: () {
                  if(_contentController.text.trim().isEmpty && _titleController.text.trim().isEmpty){
                    var val = boxes.get('key_${note!.id}');
                    if(val != null)boxes.deleteAt(val.id);
                    return;
                  }
                  saveProgress();
                },
              ),
              DefaultTextField(
                titleController: _contentController,
                keyboardType: TextInputType.multiline,
                minLines: 15,
                fontSize: 24,
                hint: 'content',
                onChanged: () {
                  if(_contentController.text.trim().isEmpty && _titleController.text.trim().isEmpty){
                    NoteDataModel? val = boxes.get('key_${note!.id}');
                    if(val != null)boxes.deleteAt(val.id);
                    return;
                  }
                  saveProgress();
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        children: [
          SpeedDialChild(
            child: Icon(IconsManager.previewIcon),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => DefaultMarkdownPreviewAlert(
                  markdown: _contentController.text,
                ),
              );
            },
            label: 'Preview',
            foregroundColor: ColorsManager.black,
            labelStyle: TextStyle(color: ColorsManager.black)
          ),
        ],
        spacing: 5,
        activeBackgroundColor: ColorsManager.black,
        icon: IconsManager.toolsIcon,
      ),
    );
  }

  void saveProgress() async {
    int currentId;
    if(this.currentId != null) {
      currentId = this.currentId!;
    } else{
      currentId = getNextId();
    }

    final note = NoteDataModel(
      id: currentId,
      title: _titleController.text,
      content: _contentController.text,
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
      colorHex: ThemesManager.accent.value.toRadixString(16).replaceAll('0xff', '').toString(),
    );

    boxes.put(
      'key_$currentId',
      note
    ).then((value){
      setState(() {
        this.currentId = currentId;
        this.note = note;
      });
    });
  }
}
