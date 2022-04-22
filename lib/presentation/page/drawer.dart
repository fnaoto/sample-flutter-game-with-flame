import 'package:flutter/material.dart';
import 'package:sample_flutter_game_with_flame/application/block_app_service.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/player_notifier.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/home.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/players.dart';

class DrawerPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final players = ref.watch(playersProvider);
    final playerProvider = ref.watch(playerNotifierProvider);

    return Drawer(
      child: ListView(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute<void>(builder: (_) => const HomePage()),
                  (_) => false);
            },
            child: const ListTile(
              title: Center(child: Text("go to home")),
              tileColor: Colors.lightGreen,
              trailing: Icon(Icons.home),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute<void>(builder: (_) => const PlayersPage()),
                  (_) => false);
            },
            child: const ListTile(
              title: Center(child: Text("go to players")),
              tileColor: Colors.lightGreen,
              trailing: Icon(Icons.person),
            ),
          ),
          TextButton(
            onPressed: () async {
              Future.forEach<PlayerDto>(
                players,
                (player) async => await playerProvider
                    .deletePlayer(id: player.id)
                    .then((_) => ref.refresh(playersProvider)),
              );
            },
            child: const ListTile(
              title: Center(child: Text("delete players")),
              tileColor: Colors.lightGreen,
              trailing: Icon(Icons.delete),
            ),
          )
        ],
      ),
    );
  }
}
