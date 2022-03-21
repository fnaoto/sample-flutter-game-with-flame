enum ExceptionCode {
  unknown,
  block,
  player,
}

class BaseException implements Exception {
  final ExceptionCode code;

  BaseException({
    this.code = ExceptionCode.unknown,
  });

  @override
  String toString() {
    return '$runtimeType: ${code.name}';
  }
}

class NullEmptyException extends BaseException {
  NullEmptyException({
    required ExceptionCode? code,
  })  : assert(code != null),
        super(code: code!);
}
