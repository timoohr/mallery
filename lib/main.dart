import 'package:flutter/material.dart';
import 'package:mallery/models/manager.dart';
import 'package:mallery/views/home_view.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(MyApp(path: args[0]));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.path,
  });

  final String path;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mallery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow, brightness: Brightness.light),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (_) => Manager(path: path),
        child: const HomeView(),
      ),
    );
  }
}

