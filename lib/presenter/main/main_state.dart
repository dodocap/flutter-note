import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orm_note/domain/model/note.dart';
import 'package:orm_note/util/note_order.dart';
import 'package:orm_note/util/order_type.dart';

part 'main_state.freezed.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    @Default(NoteOrderDate(OrderType.descending())) NoteOrder noteOrder,
    @Default([]) List<Note> noteList,
    @Default(false) bool isLoading,
    @Default(false) bool showSortingView,
  }) = _MainState;
}