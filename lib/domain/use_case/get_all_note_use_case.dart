import 'package:orm_note/core/result.dart';
import 'package:orm_note/domain/model/note.dart';
import 'package:orm_note/domain/repository/note_repository.dart';
import 'package:orm_note/util/note_order.dart';

class GetAllNoteUseCase {
  final NoteRepository _noteRepository;

  GetAllNoteUseCase({required NoteRepository noteRepository}) : _noteRepository = noteRepository;

  Future<Result<List<Note>>> execute(NoteOrder noteOrder) async {
    Result<List<Note>> result = await _noteRepository.getNoteList();
    return result.when(
      success: (data) {
        noteOrder.when(
          title: (orderType) {
            orderType.when(
              ascending: () {
                data.sort((a, b) => a.title.compareTo(b.title));
              },
              descending: () {
                data.sort((a, b) => -a.title.compareTo(b.title));
              },
            );
          },
          date: (orderType) {
            orderType.when(
              ascending: () {
                data.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));
              },
              descending: () {
                data.sort((a, b) => -a.timeStamp.compareTo(b.timeStamp));
              },
            );
          },
          color: (orderType) {
            orderType.when(
              ascending: () {
                data.sort((a, b) => a.color.compareTo(b.color));
              },
              descending: () {
                data.sort((a, b) => -a.color.compareTo(b.color));
              },
            );
          },
        );
        return Result.success(data);
      },
      error: (e) => Result.error(e),
    );
  }
}
