import 'package:meta/meta.dart';
import 'package:sample_flutter_game_with_flame/common/exception.dart';

@immutable
class BlockPoint {
  final int value;

  BlockPoint(this.value) {
    if (value.isNaN) {
      throw NullEmptyException(code: ExceptionCode.block);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is BlockPoint && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
