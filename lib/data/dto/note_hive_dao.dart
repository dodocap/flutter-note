import 'package:hive/hive.dart';

part 'note_hive_dao.g.dart';
@HiveType(typeId: 0)
class NoteHiveDao extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  int color;

  @HiveField(3)
  int timeStamp;

  NoteHiveDao({
    required this.title,
    required this.content,
    required this.color,
    required this.timeStamp,
  });
}