import 'package:flutter/material.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Title",
      theme: ThemeData(primarySwatch: Colors.green),
      // navigatorKey: Provider.of<AppInit>(context).navigatorKey,
      onGenerateRoute: (_) {
        return MaterialPageRoute<dynamic>(
          builder: (_) => const HomePage(),
        );
      },
    );
  }
}
