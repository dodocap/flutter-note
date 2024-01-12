import 'package:hive_flutter/hive_flutter.dart';
import 'package:orm_note/core/result.dart';
import 'package:orm_note/data/dto/note_hive_dao.dart';

class SourceHive {
  final Box<NoteHiveDao> _box;

  SourceHive({required Box<NoteHiveDao> box}) : _box = box;

  Future<Result<int>> add(NoteHiveDao data) async {
    int id = await _box.add(data);
    if (id < 0) {
      return const Result.error('추가 실패');
    }
    return Result.success(id);
  }

  Future<Result<void>> delete(int key) async {
    await _box.delete(key);
    if (_box.containsKey(key)) {
      return const Result.error('삭제 실패');
    }
    return const Result.success(null);
  }

  Future<Result<NoteHiveDao>> getDataById(int id) async {
    NoteHiveDao? data = _box.get(id);
    if (data == null) {
      return const Result.error('데이터 찾기 실패');
    }
    return Result.success(data);
  }

  Future<Result<List<NoteHiveDao>>> getList() async {
    return Result.success(_box.values.toList());
  }

  Future<Result<void>> put(int id, NoteHiveDao data) async {
    await _box.put(id, data);
    return const Result.success(null);
  }
}