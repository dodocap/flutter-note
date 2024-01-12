import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';

part 'note.g.dart';

@freezed
class Note with _$Note {

  const factory Note({
    @Default(-1) int id,
    required String title,
    required String content,
    required int color,
    @Default(0) int timeStamp,
  }) = _Note;

  factory Note.fromJson(Map<String, Object?> json) => _$NoteFromJson(json);
}
