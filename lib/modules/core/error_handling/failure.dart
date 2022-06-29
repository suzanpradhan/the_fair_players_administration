class Failure {
  final String message;
  final dynamic exception;
  final StackTrace? stackTrace;
  const Failure({required this.message, this.exception, this.stackTrace});
}
