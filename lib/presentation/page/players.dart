import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/player_notifier.dart';

class PlayersPage extends ConsumerWidget {
  const PlayersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final players = ref.watch(playersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Players'),
      ),
      body: ListView(shrinkWrap: true, children: [
        const Text("Top 10 players"),
        ...players
            .map(
              (player) => ListTile(
                leading: const Text("playerList"),
                title: Text("id: ${player.id}"),
                subtitle: Text("name: ${player.name}"),
              ),
            )
            .toList(),
      ]),
    );
  }
}
