import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/player_notifier.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/drawer.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/home.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/players.dart';

class ResultPage extends ConsumerWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    final playerProvider = ref.watch(playerNotifierProvider);
    String _playerName = "Player-${DateTime.now().millisecondsSinceEpoch}";

    Widget _userForm = Form(
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
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.green,
      ),
      drawer: DrawerPage(),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(30),
          children: <Widget>[
            const Icon(Icons.score, size: 200),
            _userForm,
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const PlayersPage(),
                ),
              ),
              child: const Text("go to players"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute<void>(
                  builder: (_) => const HomePage(),
                ),
                (_) => false,
              ),
              child: const Text("back to home"),
            )
          ],
        ),
      ),
    );
  }
}
