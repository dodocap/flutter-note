import 'package:hive_flutter/hive_flutter.dart';
import 'package:orm_note/core/result.dart';
import 'package:orm_note/data/dto/note_hive_dto.dart';

class DaoHive {
  final Box<NoteHiveDto> _box;

  DaoHive({required Box<NoteHiveDto> box}) : _box = box;

  Future<Result<List<NoteHiveDto>>> getList() async {
    return Result.success(_box.values.toList());
  }

  Future<Result<int>> add(NoteHiveDto dto) async {
    int key = await _box.add(dto);
    return Result.success(key);
  }

  Future<Result<void>> put(int key, NoteHiveDto dto) async {
    await _box.put(key, dto);
    return const Result.success(null);
  }

  Future<Result<void>> delete(int key) async {
    await _box.delete(key);
    return const Result.success(null);
  }
}