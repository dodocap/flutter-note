import 'package:flutter/material.dart';
import 'package:orm_note/core/result.dart';
import 'package:orm_note/domain/model/note.dart';
import 'package:orm_note/domain/use_case/get_all_note_use_case.dart';
import 'package:orm_note/domain/use_case/remove_note_use_case.dart';
import 'package:orm_note/presenter/main/main_state.dart';

class MainViewModel extends ChangeNotifier {
  final GetAllNoteUseCase _getAllNoteUseCase;
  final RemoveNoteUseCase _removeNoteUseCase;

  MainViewModel({
    required GetAllNoteUseCase getAllNoteUseCase,
    required RemoveNoteUseCase removeNoteUseCase,
  })  : _getAllNoteUseCase = getAllNoteUseCase,
        _removeNoteUseCase = removeNoteUseCase;

  MainState _state = const MainState();
  MainState get state => _state;

  Future<void> fetchNoteList() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    Result<List<Note>> result = await _getAllNoteUseCase.execute();
    result.when(
      success: (data) {
        return _state = state.copyWith(isLoading: false, noteList: data);
      },
      error: (e) {
        _state = state.copyWith(isLoading: false, noteList: []);
      },
    );
    notifyListeners();
  }

  Future<void> removeNote(Note note) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    Result<List<Note>> result = await _removeNoteUseCase.execute(note);
    result.when(
      success: (data) {
        _state = state.copyWith(isLoading: false, noteList: data);
      },
      error: (e) {
        _state = state.copyWith(isLoading: false);
      },
    );
    notifyListeners();
  }
}