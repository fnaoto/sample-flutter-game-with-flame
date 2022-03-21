import 'package:meta/meta.dart';
import 'package:sample_flutter_game_with_flame/domain/player/player.dart';

@immutable
class PlayerDto {
  final String id;
  final int point;
  final String name;

  PlayerDto(Player player)
      : id = player.id.value,
        point = player.point.value,
        name = player.name.value;
}
