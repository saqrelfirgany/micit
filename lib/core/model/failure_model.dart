class FailureModel {
  dynamic message;
  dynamic statusCode;
  dynamic errors;

  FailureModel({this.message, this.statusCode = 0, this.errors = const []});

  FailureModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['status'];
    errors = json['errors'];
  }
}
