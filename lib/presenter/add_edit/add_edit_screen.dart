import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orm_note/domain/model/note.dart';
import 'package:orm_note/presenter/add_edit/add_edit_state.dart';
import 'package:orm_note/presenter/add_edit/add_edit_view_model.dart';
import 'package:orm_note/presenter/add_edit/add_edit_ui_event.dart';
import 'package:orm_note/presenter/ui/colors.dart';
import 'package:provider/provider.dart';

class AddEditScreen extends StatefulWidget {
  final Note? _note;

  const AddEditScreen({
    super.key,
    required Note? note,
  }) : _note = note;

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  late final TextEditingController _titleController = TextEditingController();
  late final TextEditingController _contentController = TextEditingController();
  StreamSubscription? _subscription;

  @override
  void initState() {
    Future.microtask(() {
      AddEditViewModel viewModel = context.read<AddEditViewModel>();
      _subscription = viewModel.stream.listen((event) {
        switch (event) {
          case ShowSnackBar():
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(SnackBar(
                  content: Text(event.message), duration: const Duration(milliseconds: 450)));
          case SuccessSaveData():
            context.pop(true);
        }
      });

      if (widget._note != null) {
        _titleController.text = widget._note!.title;
        _contentController.text = widget._note!.content;
        viewModel.setColorValue(widget._note!.color);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AddEditViewModel viewModel = context.watch();
    final AddEditState state = viewModel.state;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(state.color),
        leading: IconButton(onPressed: context.pop, icon: const Icon(Icons.arrow_back)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.saveNote(_titleController.text, _contentController.text);
        },
        child: const Icon(Icons.save),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        color: Color(state.color),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: noteColors
                  .map((color) => InkWell(
                  onTap: () {
                    viewModel.setColor(color);
                  },
                  child: _buildBackgroundColor(
                    color: color,
                    selected: state.color == color.value,
                  ),
                ),
              ).toList(),
            ),
            TextField(
              controller: _titleController,
              maxLines: 1,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: darkGray,
              ),
              decoration: const InputDecoration(
                hintText: '제목을 입력하세요',
                border: InputBorder.none,
              ),
            ),
            TextField(
              controller: _contentController,
              maxLines: null,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: darkGray,
              ),
              decoration: const InputDecoration(
                hintText: '내용을 입력하세요',
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
    /*Scaffold(
      backgroundColor: Color(widget._note?.color ?? 0xFFFFAB91),
      body:
      state.isLoading ? const Center(child: CircularProgressIndicator())
      : Center(
        child: Column(
          children: [
            TextField(
              controller: _titleController,
            ),
            TextField(
              controller: _contentController,
            ),
          ],
        ),
      ),
    );*/
  }

  Widget _buildBackgroundColor({
    required Color color,
    required bool selected,
  }) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5.0,
            spreadRadius: 1.0,
          )
        ],
        border: selected
            ? Border.all(
          color: Colors.black,
          width: 3.0,
        )
            : null,
      ),
    );
  }
  final List<Color> noteColors = [
    roseBud,
    primrose,
    wisteria,
    skyBlue,
    illusion,
  ];
}
