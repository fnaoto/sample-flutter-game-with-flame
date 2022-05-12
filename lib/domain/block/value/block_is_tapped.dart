import 'package:meta/meta.dart';

@immutable
class BlockIsTapped {
  final bool value;

  const BlockIsTapped(this.value);

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is BlockIsTapped && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
