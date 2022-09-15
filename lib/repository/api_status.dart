class Success {
  final String cod;
  final Object response;

  Success(this.cod, this.response);
}

class Failure {
  final String cod;
  final Object errorResponse;

  Failure(this.cod, this.errorResponse);
}
