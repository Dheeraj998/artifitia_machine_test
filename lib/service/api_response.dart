class APIResponse<T> {
  T data;
  bool error;
  int status;
  String message;
  bool loading;
  int pageNo;
  bool pagination;

  APIResponse({
    required this.data,
    this.status = 1000,
    this.message = '',
    this.loading = false,
    this.error = false,
    this.pageNo = 1,
    this.pagination = true,
  });
}

class ClientErrorResponse {
  String? appData;
  String? devData;
  ClientErrorResponse({this.appData, this.devData});

  ClientErrorResponse.fromJson(Map<String, dynamic> json) {
    appData = json["app_data"];
    devData = json["dev_data"];
  }
}

class APIErrorResponse<T> {
  int statusCode;
  String message;

  APIErrorResponse({this.statusCode = 500, this.message = 'Server not found!'});
}
