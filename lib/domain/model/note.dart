import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';

part 'note.g.dart';

@Freezed(copyWith: false)
class Note with _$Note {
  Note._();

  factory Note({
    int? id,
    required String title,
    required String content,
    required int color,
    int? timeStamp,
  }) = _Note;

  Note copyWith({String? title, String? content, int? color}) {
    return Note(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      color: color ?? this.color,
      timeStamp: timeStamp,
    );
  }

  factory Note.fromJson(Map<String, Object?> json) => _$NoteFromJson(json);
}
