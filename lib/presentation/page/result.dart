import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/drawer.dart';
import 'package:sample_flutter_game_with_flame/presentation/widget/result/go_to_home_button.dart';
import 'package:sample_flutter_game_with_flame/presentation/widget/result/go_to_players_button.dart';
import 'package:sample_flutter_game_with_flame/presentation/widget/result/user_form.dart';

class ResultPage extends ConsumerWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            UserForm(),
            GoToPlayersButton(),
            GoToHomeButton()
          ],
        ),
      ),
    );
  }
}
