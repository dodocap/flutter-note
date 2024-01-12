import 'package:orm_note/core/result.dart';
import 'package:orm_note/data/data_source/dao_hive.dart';
import 'package:orm_note/data/dto/note_hive_dao.dart';
import 'package:orm_note/data/mapper/note_hive_mapper.dart';
import 'package:orm_note/domain/model/note.dart';
import 'package:orm_note/domain/repository/note_repository.dart';

class NoteRepositoryHive implements NoteRepository {
  final DaoHive _dao;

  NoteRepositoryHive({required DaoHive dao}) : _dao = dao;

  @override
  Future<Result<int>> addNote(Note note) {
    return _dao.add(note.toDto());
  }

  @override
  Future<Result<List<Note>>> getNoteList() async {
    Result<List<NoteHiveDao>> result = await _dao.getList();
    return result.when(
      success: (data) => Result.success(data.map((e) => e.toNote()).toList()),
      error: (e) => Result.error(e),
    );
  }

  @override
  Future<Result<void>> removeNote(Note note) async {
    if (note.id == null) {
      return const Result.error('노트의 아이디가 없습니다');
    }
    return _dao.delete(note.id!);
  }

  @override
  Future<Result<void>> updateNote(Note note) async {
    if (note.id == null) {
      return const Result.error('노트의 아이디가 없습니다');
    }
    return _dao.put(note.id!, note.toDto());
  }
}
