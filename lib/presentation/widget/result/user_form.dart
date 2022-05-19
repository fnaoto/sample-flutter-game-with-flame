import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/player_notifier.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/home.dart';

class UserForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    final player = ref.watch(playerNotifier);
    String? _playerName = player.name;
    String? _playerId = player.id;

    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
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
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text('Submit and back to home'),
            onPressed: () {
              if (_playerName != null && _playerId != null) {
                player.updatePlayer(
                  id: _playerId,
                  name: _playerName!,
                );
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute<void>(builder: (_) => const HomePage()),
                  (_) => false,
                );
              } else {
                throw Exception("Name or Id is empty");
              }
            },
          ),
        ],
      ),
    );
  }
}
