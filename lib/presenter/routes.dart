import 'package:go_router/go_router.dart';
import 'package:orm_note/presenter/main/main_screen.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainScreen(),
    ),
  ],
);
