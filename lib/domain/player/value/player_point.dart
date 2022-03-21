import 'package:meta/meta.dart';
import 'package:sample_flutter_game_with_flame/common/exception.dart';

@immutable
class PlayerPoint {
  final int value;

  PlayerPoint(this.value) {
    if (value.isNaN) {
      throw NullEmptyException(code: ExceptionCode.player);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is PlayerPoint && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
