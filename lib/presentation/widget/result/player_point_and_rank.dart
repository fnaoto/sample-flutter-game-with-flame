import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../notifier/player_notifier.dart';

class PlayerPointAndRank extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _playerNotifier = ref.watch(playerNotifier);
    final _playerIndex =
        _playerNotifier.players.indexWhere((p) => p.id == _playerNotifier.id);
    final _playerPoint = _playerNotifier.players[_playerIndex].point;

    return ListTile(
      title: Text("Rank: $_playerIndex, Point: $_playerPoint"),
    );
  }
}
