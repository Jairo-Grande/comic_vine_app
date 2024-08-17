import 'package:comic_vine_app/ui/features/home/view/pages/home_page.dart';
import 'package:comic_vine_app/ui/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'comic_vine',
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
      home: const HomePage(),
    );
  }
}
