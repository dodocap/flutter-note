import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orm_note/presenter/main/main_state.dart';
import 'package:orm_note/presenter/main/main_view_model.dart';
import 'package:orm_note/presenter/main/order_section.dart';
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
          IconButton(onPressed: () {
            viewModel.toggleOrderSection();
          }, icon: const Icon(Icons.sort_outlined))
        ],
      ),
      body: state.isLoading ? const Center(child: CircularProgressIndicator())
      : state.noteList.isEmpty ? const Center(child: Text('텅', style: TextStyle(fontSize: 100),),)
      : ListView(
        children: [
           AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: state.showSortingView
              ? OrderSection(
                  noteOrder: state.noteOrder,
                  onOrderChanged: (noteOrder) async {
                    await viewModel.changeOrder(noteOrder);
                  },
                )
              : Container(),
          ),
          ...state.noteList.map((note) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              color: Color(note.color),
              child: ListTile(
                onTap: () async {
                  final bool? result = await context.push('/add_edit', extra: note);
                  if(result != null && result) {
                    await viewModel.fetchNoteList();
                  }
                },
                title: Text(note.title),
                subtitle: Text(note.content),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () async {
                    await viewModel.removeNote(note);
                  },
                ),
              ),
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bool? result = await context.push('/add_edit');
          if(result != null && result) {
            await viewModel.fetchNoteList();
          }
        },
        child: const Icon(Icons.post_add_outlined),
      ),
    );
  }
}
