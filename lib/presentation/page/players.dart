import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier/player_notifier.dart';
import '../widget/players/go_to_home_button.dart';
import 'drawer.dart';

class PlayersPage extends ConsumerWidget {
  const PlayersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final top10players = ref.watch(top10PlayersProvider);

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.green,
        actions: [
          GoToHomeButton(),
        ],
      ),
      drawer: DrawerPage(),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        children: [
          const Center(child: Text("Top 10 players")),
          ...top10players
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
