import 'package:flutter/material.dart';
import 'package:sample_flutter_game_with_flame/application/block_app_service.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/block_notifier.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/player_notifier.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/drawer.dart';
import 'package:sample_flutter_game_with_flame/presentation/widget/game/flame_page.dart';
import 'package:sample_flutter_game_with_flame/presentation/widget/game/reload_button.dart';

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
