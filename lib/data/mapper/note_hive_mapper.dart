import 'package:orm_note/data/dto/note_hive_dto.dart';
import 'package:orm_note/domain/model/note.dart';

extension DtoToModel on NoteHiveDto {
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
  NoteHiveDto toDto() {
    return NoteHiveDto(
      title: title,
      content: content,
      color: color,
      timeStamp: timeStamp,
    );
  }
}
