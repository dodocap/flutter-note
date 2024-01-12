import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orm_note/domain/model/note.dart';
import 'package:orm_note/presenter/main/main_state.dart';
import 'package:orm_note/presenter/main/main_view_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<MainViewModel>().fetchNoteList();
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final MainViewModel viewModel = context.watch();
    final MainState state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () async {
            final bool? result = await context.push(Uri(path: '/add_edit').toString());
            if(result != null && result) {
              viewModel.fetchNoteList();
            }
          }, icon: const Icon(CupertinoIcons.arrow_down_doc))
        ],
      ),
      body: state.isLoading ? const Center(child: CircularProgressIndicator())
      : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: state.noteList.length,
              itemBuilder: (context, index) {
                final Note note = state.noteList[index];
                return Text(note.toString());
              },
            ),
          ),
        ],
      ),
    );
  }
}
