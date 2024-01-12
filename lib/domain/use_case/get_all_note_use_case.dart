import 'package:orm_note/core/result.dart';
import 'package:orm_note/domain/model/note.dart';
import 'package:orm_note/domain/repository/note_repository.dart';

class GetAllNoteUseCase {
  final NoteRepository _noteRepository;

  GetAllNoteUseCase({required NoteRepository noteRepository}) : _noteRepository = noteRepository;

  Future<Result<List<Note>>> execute() {
    return _noteRepository.getNoteList();
  }
}