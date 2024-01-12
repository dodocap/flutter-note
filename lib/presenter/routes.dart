import 'package:go_router/go_router.dart';
import 'package:orm_note/domain/model/note.dart';
import 'package:orm_note/presenter/add_edit/add_edit_screen.dart';
import 'package:orm_note/presenter/add_edit/add_edit_view_model.dart';
import 'package:provider/provider.dart';
import 'package:orm_note/di/di_setup.dart';
import 'package:orm_note/presenter/main/main_screen.dart';
import 'package:orm_note/presenter/main/main_view_model.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) {
        return ChangeNotifierProvider(
          create: (_) => getIt<MainViewModel>(),
          child: const MainScreen(),
        );
      },
      routes: [
        GoRoute(
          path: 'add_edit',
          builder: (_, state) {
            Note? note;
            if (state.extra != null) {
              note = state.extra as Note;
            }
            return ChangeNotifierProvider(
              create: (_) => getIt<AddEditViewModel>(),
              child: AddEditScreen(note: note),
            );
          },
        ),
      ],
    ),
  ],
);
