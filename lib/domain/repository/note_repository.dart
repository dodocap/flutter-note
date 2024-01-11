import 'package:orm_note/core/result.dart';
import 'package:orm_note/domain/model/note.dart';

abstract interface class NoteRepository {
  Future<Result<List<Note>>> getNoteList();
  Future<Result<int>> addNote(Note note);
  Future<Result<void>> removeNote(Note note);
  Future<Result<void>> updateNote(Note note);
}