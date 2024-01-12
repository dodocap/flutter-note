import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_edit_ui_event.freezed.dart';

@freezed
sealed class UiEvent with _$UiEvent {
  const factory UiEvent.showSnackBar(String message) = ShowSnackBar;
  const factory UiEvent.successSaveData() = SuccessSaveData;
}