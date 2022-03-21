import 'package:meta/meta.dart';
import 'package:sample_flutter_game_with_flame/common/exception.dart';

@immutable
class BlockColor {
  final String value;

  BlockColor(this.value) {
    if (value.isEmpty) {
      throw NullEmptyException(code: ExceptionCode.block);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is BlockColor && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
