import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/block_notifier.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/player_notifier.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blockStateProvider = ref.watch(blockNotifierStateProvider);
    final playerStateProvider = ref.watch(playerNotifierStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: Column(
        children: [
          ListTile(
            leading: const Text("playerList"),
            title: Text("id: ${playerStateProvider.players.last.id}"),
            subtitle: Text("name: ${playerStateProvider.players.last.name}"),
          ),
          ListTile(
            leading: const Text("blockList"),
            title: Text("id: ${blockStateProvider.blocks.last.id}"),
            subtitle:
                Text("playerId: ${blockStateProvider.blocks.last.playerId}"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final int32 = pow(2, 32).toInt();
          final random = Random().nextInt(int32);
          final playerId = await playerStateProvider.createPlayer(
            name: "user-$random",
            point: 0,
          );
          await blockStateProvider.createBlock(
            color: random,
            point: 1,
            playerId: playerId,
          );
        },
      ),
    );
  }
}
