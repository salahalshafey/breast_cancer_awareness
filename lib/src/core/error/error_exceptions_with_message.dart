class ErrorMessage implements Exception {
  ErrorMessage(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}

class ErrorForDialog implements Exception {
  ErrorForDialog(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}

class ErrorForSnackBar implements Exception {
  ErrorForSnackBar(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}

class ErrorForTextField implements Exception {
  ErrorForTextField(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}
