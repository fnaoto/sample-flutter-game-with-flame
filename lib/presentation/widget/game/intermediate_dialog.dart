import 'package:flutter/material.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/result.dart';

class InterMediateDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Intermediate"),
      children: [
        SimpleDialogOption(
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute<void>(builder: (_) => const ResultPage()),
              (_) => false),
          child: const Text("go to result page"),
        ),
        SimpleDialogOption(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("continue"),
        ),
      ],
    );
  }
}
