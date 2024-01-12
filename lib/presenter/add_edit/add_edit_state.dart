import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orm_note/presenter/ui/colors.dart';

part 'add_edit_state.freezed.dart';

part 'add_edit_state.g.dart';

@freezed
class AddEditState with _$AddEditState {
  const factory AddEditState({
    @Default(false) bool isLoading,
    required int color,
  }) = _AddEditState;

  factory AddEditState.fromJson(Map<String, Object?> json) => _$AddEditStateFromJson(json);
}