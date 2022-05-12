import 'package:sample_flutter_game_with_flame/domain/block/block.dart';

abstract class BlockFactory {
  Block create({
    required BlockPoint point,
    required BlockIsTapped isTapped,
    required BlockNeedToTap needToTap,
    required PlayerId playerId,
  });
}
