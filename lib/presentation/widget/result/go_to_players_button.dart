import 'package:flutter/material.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/players.dart';

class GoToPlayersButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => const PlayersPage(),
        ),
      ),
      child: const Text("go to players"),
    );
  }
}
