import 'package:flutter/material.dart';
import 'package:sample_flutter_game_with_flame/application/block_app_service.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/result.dart';

class GamePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(30),
          children: <Widget>[
            const Icon(Icons.gamepad, size: 200),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const ResultPage(),
                ),
              ),
              child: const Text("go to result"),
            )
          ],
        ),
      ),
    );
  }
}
