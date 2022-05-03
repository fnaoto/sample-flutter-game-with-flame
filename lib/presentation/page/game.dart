import 'package:flutter/material.dart';
import 'package:sample_flutter_game_with_flame/application/block_app_service.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/drawer.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/flame.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/home.dart';

class GamePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        foregroundColor: Colors.green,
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute<void>(builder: (_) => GamePage()),
                  (_) => false),
              child: const Text("Reload")),
        ],
      ),
      drawer: DrawerPage(),
      body: GameWidget(game: FlamePage()),
    );
  }
}
