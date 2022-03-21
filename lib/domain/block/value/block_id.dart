import 'package:meta/meta.dart';
import 'package:sample_flutter_game_with_flame/common/exception.dart';

@immutable
class BlockId {
  final String value;

  BlockId(this.value) {
    if (value.isEmpty) {
      throw NullEmptyException(code: ExceptionCode.block);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is BlockId && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
