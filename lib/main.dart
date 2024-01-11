import 'package:flutter/material.dart';
import 'package:orm_note/di/di_setup.dart';
import 'package:orm_note/presenter/routes.dart';

void main() {
  diSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routes,
      title: '노트 애플리케이션',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
