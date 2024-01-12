import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_edit_state.freezed.dart';

part 'add_edit_state.g.dart';

@freezed
class AddEditState with _$AddEditState {
  const factory AddEditState({
    @Default(false) bool isLoading,
  }) = _AddEditState;

  factory AddEditState.fromJson(Map<String, Object?> json) => _$AddEditStateFromJson(json);
}