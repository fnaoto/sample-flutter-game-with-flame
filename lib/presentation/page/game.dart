import 'package:flutter/material.dart';
import 'package:sample_flutter_game_with_flame/application/block_app_service.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/block_notifier.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/player_notifier.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/drawer.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/flame.dart';

class GamePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerNotifier);
    final block = ref.watch(blockNotifier);
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
      body: GameWidget(game: FlamePage(player, block)),
    );
  }
}
