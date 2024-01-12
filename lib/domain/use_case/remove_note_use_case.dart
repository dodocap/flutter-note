import 'package:orm_note/core/result.dart';
import 'package:orm_note/domain/model/note.dart';
import 'package:orm_note/domain/repository/note_repository.dart';

class RemoveNoteUseCase {
  final NoteRepository _noteRepository;

  RemoveNoteUseCase({required NoteRepository noteRepository}) : _noteRepository = noteRepository;

  Future<Result<void>> execute(Note note) async {
    return _noteRepository.removeNote(note);
  }
}