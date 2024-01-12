import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orm_note/domain/model/note.dart';
import 'package:orm_note/presenter/add_edit/add_edit_state.dart';
import 'package:orm_note/presenter/add_edit/add_edit_view_model.dart';
import 'package:orm_note/presenter/add_edit/add_edit_ui_event.dart';
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
    if (widget._note != null) {
      _titleController.text = widget._note!.title;
      _contentController.text = widget._note!.content;
    }

    Future.microtask(() {
      _subscription = context.read<AddEditViewModel>().stream.listen((event) {
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: context.pop,
        ),
        actions: [
          IconButton(onPressed: () async {
            await context.read<AddEditViewModel>()
                .saveNote(_titleController.text,_contentController.text, Random().nextInt(20000000));

          }, icon: const Icon(Icons.save_outlined))
        ],
      ),
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
    );
  }
}
