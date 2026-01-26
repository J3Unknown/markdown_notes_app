
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_tester/models/markdown_note/note_data_model.dart';
import 'package:package_tester/shared/repo/notes_repo.dart';

import 'main_bloc_states.dart';

class MainCubit extends Cubit<MainCubitStates>{
  MainCubit() : super(MainInitState());

  static MainCubit get(context) => BlocProvider.of(context);

  void addNote(NoteDataModel note){
    emit(MainAddNoteLoadingState());
    boxes.put('key_${note.id}', note).then((value){
      emit(MainAddNoteSuccessState());
    });
  }

  void deleteNote(int index){
    emit(MainDeleteNoteLoadingState());
    boxes.deleteAt(index).then((value){
      emit(MainDeleteNoteSuccessState());
    });
  }
}