import 'package:meta/meta.dart';
import 'package:sample_flutter_game_with_flame/common/exception.dart';

@immutable
class PlayerId {
  final String value;

  PlayerId(this.value) {
    if (value.isEmpty) {
      throw NullEmptyException(code: ExceptionCode.player);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is PlayerId && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
