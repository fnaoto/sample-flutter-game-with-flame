import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier/block_notifier.dart';
import '../notifier/player_notifier.dart';
import '../widget/game/flame_page.dart';
import '../widget/game/reload_button.dart';
import 'drawer.dart';

class GamePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerNotifier);
    final block = ref.watch(blockNotifier);
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        foregroundColor: Colors.green,
        actions: [
          ReloadButton(),
        ],
      ),
      drawer: DrawerPage(),
      body: GameWidget(game: FlamePage(player, block, context)),
    );
  }
}
