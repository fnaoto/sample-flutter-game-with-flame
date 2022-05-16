import 'package:flutter/material.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/game.dart';

class ReloadButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(builder: (_) => GamePage()), (_) => false),
      child: const Text("Reload"),
    );
  }
}
