import 'package:meta/meta.dart';

@immutable
class BlockNeedToTap {
  final bool value;

  const BlockNeedToTap(this.value);

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is BlockNeedToTap && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
