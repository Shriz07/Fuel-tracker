class FailedToAddDataException implements Exception {
  FailedToAddDataException(this.cause);
  String cause;
}
