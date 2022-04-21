import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/player_notifier.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/game.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/players.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchPlayer = ref.watch(playerNotifierProvider).fetchPlayer;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(30),
          children: <Widget>[
            const Icon(Icons.home, size: 200),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => GamePage(),
                ),
              ),
              child: const Text("go to game"),
            ),
            ElevatedButton(
              onPressed: () async {
                await fetchPlayer;
                await Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const PlayersPage(),
                  ),
                );
              },
              child: const Text("go to players"),
            )
          ],
        ),
      ),
    );
  }
}
