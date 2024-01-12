import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:orm_note/data/dto/note_hive_dao.dart';
import 'package:orm_note/di/di_setup.dart';
import 'package:orm_note/presenter/routes.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteHiveDaoAdapter());
  await diSetup();
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
