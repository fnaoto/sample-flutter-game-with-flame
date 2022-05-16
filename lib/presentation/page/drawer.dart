import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_game_with_flame/presentation/widget/drawer/go_to_home_button.dart';
import 'package:sample_flutter_game_with_flame/presentation/widget/drawer/go_to_player_button.dart';

class DrawerPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        children: [
          GoToHomeButton(),
          GoToPlayerButton(),
        ],
      ),
    );
  }
}
