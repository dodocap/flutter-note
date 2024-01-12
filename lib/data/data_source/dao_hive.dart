import 'package:hive_flutter/hive_flutter.dart';
import 'package:orm_note/core/result.dart';
import 'package:orm_note/data/dto/note_hive_dao.dart';

class DaoHive {
  final Box<NoteHiveDao> _box;

  DaoHive({required Box<NoteHiveDao> box}) : _box = box;

  Future<Result<List<NoteHiveDao>>> getList() async {
    return Result.success(_box.values.toList());
  }

  Future<Result<int>> add(NoteHiveDao dao) async {
    int key = await _box.add(dao);
    return Result.success(key);
  }

  Future<Result<void>> put(int key, NoteHiveDao dao) async {
    await _box.put(key, dao);
    return const Result.success(null);
  }

  Future<Result<void>> delete(int key) async {
    await _box.delete(key);
    return const Result.success(null);
  }
}