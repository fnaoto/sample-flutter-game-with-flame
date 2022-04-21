import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sample_flutter_game_with_flame/application/block_app_service.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/player_notifier.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/result.dart';

class GamePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    final playerProvider = ref.watch(playerNotifierProvider);
    String _playerName = "Player-${DateTime.now().millisecondsSinceEpoch}";

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
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    initialValue: _playerName,
                    onChanged: (text) {
                      _playerName = text;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        throw Exception("Name is empty");
                      }
                      return text;
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      if (_playerName.isEmpty) throw Exception("Name is empty");
                      playerProvider.createPlayer(
                        name: _playerName,
                        point: Random().nextInt(100),
                      );
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const ResultPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
