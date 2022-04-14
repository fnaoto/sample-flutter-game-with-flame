import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/block_notifier.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blocks = ref.watch(blockNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: Column(
        children: [ListTile(title: Text(blocks.blockList[0].id))],
      ),
    );
  }
}
