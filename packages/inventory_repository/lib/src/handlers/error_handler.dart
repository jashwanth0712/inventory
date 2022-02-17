class APIRequestError implements Exception {
  const APIRequestError([this.message = "An Unknown Exception Occured'"]);

  factory APIRequestError.fromMessage(String message) {
    return APIRequestError(message);
  }
  final String message;
}
