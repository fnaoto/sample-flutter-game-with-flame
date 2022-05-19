import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/player_notifier.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/players.dart';

class UserForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    final player = ref.watch(playerNotifier);
    String _playerName = "Player-${DateTime.now().millisecondsSinceEpoch}";

    return Form(
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
              player.createPlayer(
                name: _playerName,
                point: Random().nextInt(100),
              );
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const PlayersPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
