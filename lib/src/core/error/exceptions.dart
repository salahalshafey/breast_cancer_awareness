class Error implements Exception {
  Error(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}

class ServerException implements Exception {}

class OfflineException implements Exception {}

class EmptyDataException implements Exception {}

class WeakPasswordException implements Exception {}

class EmailAlreadyInUseException implements Exception {}

class UserNotFoundException implements Exception {}

class WrongPasswordException implements Exception {}

class EmailNotValidException implements Exception {}
