import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/player_notifier.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/drawer.dart';

class PlayersPage extends ConsumerWidget {
  const PlayersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final players = ref.watch(playersProvider);

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.green,
      ),
      drawer: DrawerPage(),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        children: [
          const Center(child: Text("Top 10 players")),
          ...players
              .map(
                (player) => ListTile(
                  title: Text("point: ${player.point}"),
                  subtitle: Text("name: ${player.name}"),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
