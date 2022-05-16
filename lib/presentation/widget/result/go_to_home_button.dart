import 'package:flutter/material.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/home.dart';

class GoToHomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(
          builder: (_) => const HomePage(),
        ),
        (_) => false,
      ),
      child: const Text("back to home"),
    );
  }
}
