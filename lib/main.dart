import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_game_with_flame/init.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/home.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final init = ref.watch(initProvider);

    return MaterialApp(
      title: "Title",
      theme: ThemeData(primarySwatch: Colors.green),
      navigatorKey: init.navigatorKey,
      onGenerateRoute: (_) {
        return MaterialPageRoute<Widget>(
          builder: (_) => HomePage(),
        );
      },
    );
  }
}
