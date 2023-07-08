// import 'dart:io';
// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';

// import 'package:ScoutyHyde/data/api/auth_api.dart';
// import 'package:ScoutyHyde/service/jwt_decoder.dart';
// import 'package:get/get_connect/http/src/response/response.dart';
// import 'package:http/http.dart';
// import 'package:retry/retry.dart';
// import 'package:http/http.dart' as http;

// import '../constants/constant.dart';
// import '../helper/custom_print.dart';
// import '../data/controllers/main_controller.dart';

// class HttpService {
//   final _headers = {
//     'Authorization': 'Bearer ${MainController.instance.user?.access}',
//     'Content-Type': 'application/json',
//   };
//   final _client = http.Client();
//   final timeout = 20;

//   final _headerWithout = {'Content-Type': 'application/json'};

//   Future<http.Response> getApi({
//     required String url,
//     required Function(Exception e) manageException,
//     bool withoutLogin = false,
//   }) async {
//     int numberOfRetries = 0;
//     String apiUrl = '$baseUrl/$url';
//     Response? response;
//     final ctr = MainController.instance;
//     bool? isTokenExpired;

//     if (withoutLogin == false) {
//       isTokenExpired = JwtDecoder.isExpired(ctr.user?.access ?? "");
//     }
//     if (isTokenExpired == false) {
//       response = await retry(
//         () => _client
//             .get(Uri.parse(apiUrl), headers: _headers)
//             .timeout(Duration(seconds: timeout)),
//         maxAttempts: 3,
//         delayFactor: const Duration(milliseconds: 200),
//         retryIf: (e) {
//           log('$e', name: 'retryIf');
//           numberOfRetries++;
//           return e is SocketException || e is TimeoutException;
//         },
//         onRetry: (Exception e) {
//           if (numberOfRetries >= 3) manageException(e);
//         },
//       );
//       if (response?.statusCode == 401) {
//         final ctr = MainController.instance;
//         ctr.isLogged = false;
//         ctr.update(['loginPage']);
//       }
//       customPrint('= = = = = = = = = = = = = = = = = = = = = = = = =');
//       customPrint(apiUrl);
//       customPrint('= = = = = = = = = = = = = = = = = = = = = = = = =');
//       customPrint(response?.statusCode);
//       customPrint(response?.body);
//     } else {
//       await ctr.refreshTokenFn(refresh: ctr.user?.refresh);

//       if (ctr.refreshTokenResponse?.statusCode == 200) {
//         getApi(url: url, manageException: manageException);
//       }
//     }
//     return response!;
//   }

//   Future<http.Response> postApi({
//     required String url,
//     required body,
//     bool withoutLogin = false,
//     required Function(Exception e) manageException,
//   }) async {
//     int numberOfRetries = 0;
//     String apiUrl = '$baseUrl/$url';
//     Response? response;
//     final ctr = MainController.instance;
//     bool? isTokenExpired;
//     if (withoutLogin == false) {
//       isTokenExpired = JwtDecoder.isExpired(ctr.user?.access ?? "");
//     }

//     if (withoutLogin == true || isTokenExpired == false) {
//       response = await retry(
//         () {
//           return _client
//               .post(
//                 Uri.parse(apiUrl),
//                 headers: withoutLogin ? _headerWithout : _headers,
//                 body: json.encode(body),
//               )
//               .timeout(Duration(seconds: timeout));
//         },
//         maxAttempts: 4,
//         delayFactor: const Duration(milliseconds: 200),
//         retryIf: (e) {
//           log('$e', name: 'retryIf');
//           numberOfRetries++;
//           return e is SocketException || e is TimeoutException;
//         },
//         onRetry: (Exception e) {
//           if (numberOfRetries >= 3) manageException(e);
//         },
//       );
//       customPrint('= = = = = = = = = = = = = = = = = = = = = = = = =');
//       customPrint(apiUrl);
//       customPrint('= = = = = = = = = = = = = = = = = = = = = = = = =');
//       customPrint(response?.statusCode);
//       customPrint(response?.body);
//     } else {
//       await ctr.refreshTokenFn(refresh: ctr.user?.refresh);
//       if (ctr.refreshTokenResponse?.statusCode == 200) {
//         postApi(url: url, body: body, manageException: manageException);
//       }
//     }
//     return response!;
//   }

//   Future<http.Response> postFormDataApi({
//     required MultipartRequest request,
//     bool withoutLogin = false,
//     required Function(Exception e) manageException,
//   }) async {
//     int numberOfRetries = 0;
//     Response? response;
//     bool? isTokenExpired;
//     final ctr = MainController.instance;
//     if (withoutLogin == false) {
//       isTokenExpired = JwtDecoder.isExpired(ctr.user?.access ?? "");
//     }
//     if (withoutLogin == true || isTokenExpired == false) {
//       response = await retry(
//         () async {
//           log('Entered', name: 'postFormDataApi');
//           request.headers.addAll(!withoutLogin
//               ? {
//                   'Authorization':
//                       'Bearer ${MainController.instance.user?.access}'
//                 }
//               : {
//                   'Content-Type': 'application/json',
//                 });
//           return await http.Response.fromStream(await request.send());
//         },
//         maxAttempts: 4,
//         delayFactor: const Duration(milliseconds: 200),
//         retryIf: (e) {
//           log('$e', name: 'retryIf');
//           numberOfRetries++;
//           return e is SocketException || e is TimeoutException;
//         },
//         onRetry: (Exception e) {
//           if (numberOfRetries >= 3) manageException(e);
//         },
//       );
//       customPrint('= = = = = = = = = = = = = = = = = = = = = = = = =');
//       customPrint('Formdata');
//       customPrint('= = = = = = = = = = = = = = = = = = = = = = = = =');
//       customPrint(response?.statusCode);
//       customPrint(response?.body);
//     } else {
//       await ctr.refreshTokenFn(refresh: ctr.user?.refresh);
//       if (ctr.refreshTokenResponse?.statusCode == 200) {
//         postFormDataApi(request: request, manageException: manageException);
//       }
//     }
//     return response!;
//   }

//   Future<http.Response> putApi({
//     required String url,
//     required body,
//     bool withoutLogin = false,
//     required Function(Exception e) manageException,
//   }) async {
//     int numberOfRetries = 0;
//     String apiUrl = '$baseUrl/$url';
//     Response? response;
//     bool? isTokenExpired;
//     final ctr = MainController.instance;
//     if (withoutLogin == false) {
//       isTokenExpired = JwtDecoder.isExpired(ctr.user?.access ?? "");
//     }
//     if (isTokenExpired == false) {
//       response = await retry(
//         () {
//           return _client
//               .put(Uri.parse(apiUrl),
//                   headers: _headers, body: json.encode(body))
//               .timeout(Duration(seconds: timeout));
//         },
//         maxAttempts: 4,
//         delayFactor: const Duration(milliseconds: 200),
//         retryIf: (e) {
//           log('$e', name: 'retryIf');
//           numberOfRetries++;
//           return e is SocketException || e is TimeoutException;
//         },
//         onRetry: (Exception e) {
//           if (numberOfRetries >= 3) manageException(e);
//         },
//       );
//       customPrint('= = = = = = = = = = = = = = = = = = = = = = = = =');
//       customPrint(apiUrl);
//       customPrint('= = = = = = = = = = = = = = = = = = = = = = = = =');
//       customPrint(response?.statusCode);
//       customPrint(response?.body);
//     } else {
//       await ctr.refreshTokenFn(refresh: ctr.user?.refresh);
//       if (ctr.refreshTokenResponse?.statusCode == 200) {
//         putApi(url: url, body: body, manageException: manageException);
//       }
//     }
//     return response!;
//   }

//   Future<http.Response> deleteApi({
//     required String url,
//     body,
//     required Function(Exception e) manageException,
//     bool withoutLogin = false,
//   }) async {
//     int numberOfRetries = 0;
//     String apiUrl = '$baseUrl/$url';
//     Response? response;
//     bool? isTokenExpired;
//     final ctr = MainController.instance;
//     if (withoutLogin == false) {
//       isTokenExpired = JwtDecoder.isExpired(ctr.user?.access ?? "");
//     }
//     if (isTokenExpired == false) {
//       response = await retry(
//         () {
//           return _client
//               .delete(Uri.parse(apiUrl),
//                   headers: _headers,
//                   body: body != null ? json.encode(body) : null)
//               .timeout(Duration(seconds: timeout));
//         },
//         maxAttempts: 4,
//         delayFactor: const Duration(milliseconds: 200),
//         retryIf: (e) {
//           log('$e', name: 'retryIf');
//           numberOfRetries++;
//           return e is SocketException || e is TimeoutException;
//         },
//         onRetry: (Exception e) {
//           if (numberOfRetries >= 3) manageException(e);
//         },
//       );
//       customPrint('= = = = = = = = = = = = = = = = = = = = = = = = =');
//       customPrint(apiUrl);
//       customPrint('= = = = = = = = = = = = = = = = = = = = = = = = =');
//       customPrint(response?.statusCode);
//       customPrint(response?.body);
//     } else {
//       await ctr.refreshTokenFn(refresh: ctr.user?.refresh);
//       if (ctr.refreshTokenResponse?.statusCode == 200) {
//         deleteApi(url: url, manageException: manageException);
//       }
//     }
//     return response!;
//   }
// }