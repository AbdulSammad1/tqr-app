class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix $_message";
  }
}

class InternetException extends AppException {
  InternetException([String? message]) : super(message, "No Internet: ");
}

class RequestTimeOutException extends AppException {
  RequestTimeOutException([String? message])
      : super(message, "Request Time out: ");
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, "Invalid Request: ");
}

class ServerException extends AppException {
  ServerException([String? message])
      : super(message, "Internal Server Error: ");
}

class InvalidUrlException extends AppException {
  InvalidUrlException([String? message]) : super(message, "Invalid URL: ");
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "");
}
