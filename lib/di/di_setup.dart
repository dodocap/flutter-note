import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:orm_note/data/dto/note_hive_dto.dart';

final getIt = GetIt.instance;

Future<void> diSetup() async {
  getIt.registerSingleton<Box<NoteHiveDto>>(await Hive.openBox<NoteHiveDto>('note_list.db'));
}