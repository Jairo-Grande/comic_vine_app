import 'package:comic_vine_app/ui/features/comics/bloc/comics_bloc.dart';
import 'package:comic_vine_app/ui/features/comics/view/pages/home_page.dart';
import 'package:comic_vine_app/ui/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dependency_injection/injection.dart' as di;
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  return runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<IssueBloc>()),
      ],
      child: const MyApp(),
    ),
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
