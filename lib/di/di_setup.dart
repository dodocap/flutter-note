import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:orm_note/data/data_source/source_hive.dart';
import 'package:orm_note/data/dto/note_hive_dao.dart';
import 'package:orm_note/data/repository/note_repository_hive.dart';
import 'package:orm_note/domain/repository/note_repository.dart';
import 'package:orm_note/domain/use_case/add_note_use_case.dart';
import 'package:orm_note/domain/use_case/get_all_note_use_case.dart';
import 'package:orm_note/domain/use_case/remove_note_use_case.dart';
import 'package:orm_note/domain/use_case/update_note_use_case.dart';
import 'package:orm_note/presenter/add_edit/add_edit_view_model.dart';
import 'package:orm_note/presenter/main/main_view_model.dart';

final getIt = GetIt.instance;

Future<void> diSetup() async {
  getIt.registerSingleton<Box<NoteHiveDao>>(await Hive.openBox<NoteHiveDao>('note_list.db'));
  getIt.registerSingleton<SourceHive>(SourceHive(box: getIt<Box<NoteHiveDao>>()));
  getIt.registerSingleton<NoteRepository>(NoteRepositoryHive(sourceHive: getIt<SourceHive>()));
  getIt.registerSingleton<AddNoteUseCase>(AddNoteUseCase(noteRepository: getIt<NoteRepository>()));
  getIt.registerSingleton<RemoveNoteUseCase>(RemoveNoteUseCase(noteRepository: getIt<NoteRepository>()));
  getIt.registerSingleton<UpdateNoteUseCase>(UpdateNoteUseCase(noteRepository: getIt<NoteRepository>()));
  getIt.registerSingleton<GetAllNoteUseCase>(GetAllNoteUseCase(noteRepository: getIt<NoteRepository>()));

  getIt.registerFactory<MainViewModel>(
    () => MainViewModel(
      getAllNoteUseCase: getIt<GetAllNoteUseCase>(),
      removeNoteUseCase: getIt<RemoveNoteUseCase>(),
    ),
  );

  getIt.registerFactory<AddEditViewModel>(
    () => AddEditViewModel(
      addNoteUseCase: getIt<AddNoteUseCase>(),
      updateNoteUseCase: getIt<UpdateNoteUseCase>(),
    ),
  );
}
