import 'package:sample_flutter_game_with_flame/domain/block/block.dart';

abstract class BlockFactory {
  Block create({required int point});
}
