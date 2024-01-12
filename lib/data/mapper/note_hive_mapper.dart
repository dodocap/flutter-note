import 'package:orm_note/data/dto/note_hive_dao.dart';
import 'package:orm_note/domain/model/note.dart';

extension DtoToModel on NoteHiveDao {
  Note toNote() {
    return Note(
      id: key,
      title: title,
      content: content,
      color: color,
      timeStamp: timeStamp,
    );
  }
}

extension ModelToDto on Note {
  NoteHiveDao toDto() {
    return NoteHiveDao(
      title: title,
      content: content,
      color: color,
      timeStamp: timeStamp,
    );
  }
}
