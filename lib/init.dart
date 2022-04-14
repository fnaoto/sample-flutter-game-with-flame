import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_game_with_flame/infrastructure/db.dart';
import 'package:sample_flutter_game_with_flame/presentation/page/home.dart';

final initProvider = StateProvider(
  (ref) => Init(
    navigatorKey: GlobalKey<NavigatorState>(),
    db: ref.watch(dbProvider),
  ),
);

class Init {
  final GlobalKey<NavigatorState> navigatorKey;

  Init({
    required this.navigatorKey,
    required DB db,
  }) : super() {
    db.open().then((_) {
      navigatorKey.currentState?.pushAndRemoveUntil<void>(
        MaterialPageRoute<Widget>(
          builder: (_) => HomePage(),
        ),
        (_) => false,
      );
    });
  }
}
