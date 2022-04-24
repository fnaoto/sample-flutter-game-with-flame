import 'package:flutter/material.dart';
import 'package:sample_flutter_game_with_flame/application/block_app_service.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/drawer.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/flame.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/home.dart';

class GamePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.green,
      ),
      drawer: DrawerPage(),
      body: Center(
        child: GameWidget(
          game: MyGame(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(
            builder: (_) => const HomePage(),
          ),
          (_) => false,
        ),
        child: const Text("End"),
      ),
    );
  }
}
