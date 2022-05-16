import 'package:flutter/material.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/game.dart';

class GoToGameButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => GamePage(),
        ),
      ),
      child: const Text("go to game"),
    );
  }
}
