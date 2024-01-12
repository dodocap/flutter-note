import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orm_note/core/result.dart';
import 'package:orm_note/domain/model/note.dart';
import 'package:orm_note/domain/use_case/add_note_use_case.dart';
import 'package:orm_note/domain/use_case/update_note_use_case.dart';
import 'package:orm_note/presenter/add_edit/add_edit_state.dart';
import 'package:orm_note/presenter/add_edit/add_edit_ui_event.dart';
import 'package:orm_note/presenter/ui/colors.dart';

class AddEditViewModel extends ChangeNotifier {
  final AddNoteUseCase _addNoteUseCase;
  final UpdateNoteUseCase _updateNoteUseCase;

  AddEditViewModel({
    required AddNoteUseCase addNoteUseCase,
    required UpdateNoteUseCase updateNoteUseCase,
  })  : _addNoteUseCase = addNoteUseCase,
        _updateNoteUseCase = updateNoteUseCase;

  AddEditState _state = AddEditState(color: roseBud.value);
  AddEditState get state => _state;

  final StreamController<UiEvent> _controller = StreamController();
  Stream<UiEvent> get stream => _controller.stream;

  void setColor(Color color) {
    _state = state.copyWith(color: color.value);
    notifyListeners();
  }

  void setColorValue(int value) {
    _state = state.copyWith(color: value);
    notifyListeners();
  }

  Future<void> saveNote(String title, String content) async {
    if (title.isEmpty || content.isEmpty) {
      _controller.add(const UiEvent.showSnackBar('제목 또는 내용이 비어있습니다'));
      return;
    }

    _state = state.copyWith(isLoading: true);
    notifyListeners();

    Result<int> result = await _addNoteUseCase.execute(Note(
      id: 0,
      title: title,
      content: content,
      color: _state.color,
      timeStamp: 0,
    ));

    result.when(
      success: (data) {
        _state = state.copyWith(isLoading: false);
        _controller.add(const UiEvent.successSaveData());
      },
      error: (e) {
        _state = state.copyWith(isLoading: false);
        _controller.add(UiEvent.showSnackBar(e));
      },
    );
    notifyListeners();
  }
}
