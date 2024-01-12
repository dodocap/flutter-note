import 'package:orm_note/core/result.dart';
import 'package:orm_note/domain/model/note.dart';
import 'package:orm_note/domain/repository/note_repository.dart';

class AddNoteUseCase {
  final NoteRepository _noteRepository;

  AddNoteUseCase({required NoteRepository noteRepository}) : _noteRepository = noteRepository;

  Future<Result<int>> execute(Note note) {
    return _noteRepository.addNote(note);
  }
}