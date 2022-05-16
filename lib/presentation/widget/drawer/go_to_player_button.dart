import 'package:flutter/material.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/players.dart';

class GoToPlayerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const PlayersPage()),
        );
      },
      child: const ListTile(
        title: Center(child: Text("go to players")),
        tileColor: Colors.lightGreen,
        trailing: Icon(Icons.person),
      ),
    );
  }
}
