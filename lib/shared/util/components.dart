import 'dart:async';
import 'package:flutter/material.dart';
import 'package:package_tester/shared/themes/themes_manager.dart';

import '../repo/notes_repo.dart';
import '../themes/colors_manager.dart';

class DeBouncer {
  final int milliseconds;
  Timer? _timer;

  DeBouncer({this.milliseconds = 500});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

int getNextId() {
  final keys = boxes.keys.where((k) => k.toString().startsWith('key_'));
  if (keys.isEmpty) return 1;

  final ids = keys.map((k) => int.parse(k.toString().replaceFirst('key_', ''))).toList();
  return (ids.reduce((a, b) => a > b ? a : b)) + 1;
}

buildChipChoice(Accents accent, String label, bool selected, ValueChanged<bool> onSelected, {bool isTextReverted = false}) {
  return ChoiceChip(
    label: Text(label, style: TextStyle(color: isTextReverted?(ThemesManager.isDark?ColorsManager.black:ColorsManager.white):null),),
    color: WidgetStatePropertyAll(getAccentColor(accent)),
    selected: selected,
    onSelected: (value) => onSelected(value),
    checkmarkColor: isTextReverted?(ThemesManager.isDark?ColorsManager.black:ColorsManager.white):null,
    side: BorderSide(color: ColorsManager.transparent),
  );
}


class DefaultTextField extends StatelessWidget {
  DefaultTextField({
    super.key,
    required TextEditingController titleController,
    required String hint,
    int? maxLines,
    int? minLines,
    double fontSize = 18,
    TextInputType? keyboardType,
    VoidCallback? onChanged,
  }) : _titleController = titleController,
        _maxLines = maxLines,
        _minLines = minLines,
        _fontSize = fontSize,
        _hint = hint,
        _onChanged = onChanged,
        _keyboardType = keyboardType;

  final TextEditingController _titleController;
  final int? _maxLines;
  final int? _minLines;
  final double _fontSize;
  final VoidCallback? _onChanged;
  final String _hint;
  final TextInputType? _keyboardType;
  final DeBouncer _debouncer = DeBouncer(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: _keyboardType,
      controller: _titleController,
      maxLines: _maxLines,
      minLines: _minLines,
      onChanged: (value) {
        _debouncer.run(() {
          if(_onChanged != null){
            _onChanged();
          }
        });
      },
      cursorColor: Theme.of(context).primaryColor,
      cursorOpacityAnimates: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        hint: Text(_hint, style: Theme.of(context).textTheme.headlineSmall),
      ),
      style: TextStyle(color: ThemesManager.isDark?ColorsManager.white:ColorsManager.black, fontSize: _fontSize),
      onTapOutside: (pointer) {
        FocusScope.of(
          context,
        ).unfocus(disposition: UnfocusDisposition.previouslyFocusedChild);
      },
    );
  }
}