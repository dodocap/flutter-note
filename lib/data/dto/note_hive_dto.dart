import 'package:hive/hive.dart';

part 'note_hive_dto.g.dart';
@HiveType(typeId: 0)
class NoteHiveDto extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  int color;

  @HiveField(3)
  int timeStamp;

  NoteHiveDto({
    required this.title,
    required this.content,
    required this.color,
    required this.timeStamp,
  });
}