import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widget/drawer/go_to_home_button.dart';
import '../widget/drawer/go_to_players_button.dart';

class DrawerPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        children: [
          GoToHomeButton(),
          GoToPlayersButton(),
        ],
      ),
    );
  }
}
