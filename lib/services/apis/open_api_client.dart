import '../../utils/tools/file_important.dart';

// Custom exceptions
class DeadlineExceededException implements Exception {
  final RequestOptions requestOptions;
  DeadlineExceededException(this.requestOptions);
}

class ReceiveTimeOutException implements Exception {
  final RequestOptions requestOptions;
  ReceiveTimeOutException(this.requestOptions);
}

class UnauthorizedException implements Exception {
  final RequestOptions requestOptions;
  UnauthorizedException(this.requestOptions);
}

class NotFoundException implements Exception {
  final RequestOptions requestOptions;
  NotFoundException(this.requestOptions);
}

class ConflictException implements Exception {
  final RequestOptions requestOptions;
  ConflictException(this.requestOptions);
}

class InternalServerErrorException implements Exception {
  final RequestOptions requestOptions;
  InternalServerErrorException(this.requestOptions);
}

class NoInternetConnectionException implements Exception {
  final RequestOptions requestOptions;
  NoInternetConnectionException(this.requestOptions);
}

class ApiClient {
  ApiClient() {
    _init();
  }

  late Dio dio;

  _init() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 25),
      receiveTimeout: Duration(seconds: 20),
    ));

    dio.interceptors.add(InterceptorsWrapper(onError: (error, handler) {
      switch (error.type) {
        case DioErrorType.connectionTimeout:
        case DioErrorType.sendTimeout:
          throw DeadlineExceededException(error.requestOptions);
        case DioErrorType.receiveTimeout:
          throw ReceiveTimeOutException(error.requestOptions);
        case DioErrorType.badResponse:
          switch (error.response?.statusCode) {
            case 401:
              throw UnauthorizedException(error.requestOptions);
            case 404:
              throw NotFoundException(error.requestOptions);
            case 409:
              throw ConflictException(error.requestOptions);
            case 500:
            case 501:
            case 503:
              throw InternalServerErrorException(error.requestOptions);
          }
          break;
        case DioErrorType.cancel:
          break;
        case DioErrorType.unknown:
          throw NoInternetConnectionException(error.requestOptions);
        default:
          debugPrint('Error Status Code: ${error.response?.statusCode}');
          return handler.next(error);
      }
      debugPrint('Error Status Code: ${error.response?.statusCode}');
      return handler.next(error);
    }, onRequest: (requestOptions, handler) {
      String currentLocale = "uz";
      requestOptions.headers["Accept"] = "application/json";
      requestOptions.headers["Accept-Language"] =
          currentLocale.isEmpty ? "ru" : currentLocale;
      return handler.next(requestOptions);
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      return handler.next(response);
    }));
  }
}


// class ApiClient {
//   ApiClient() {
//     _init();
//   }
//
//   late Dio dio;
//
//   _init() {
//     dio = Dio(BaseOptions(
//         baseUrl: baseUrl, connectTimeout: 25000, receiveTimeout: 20000));
//
//     dio.interceptors.add(InterceptorsWrapper(onError: ((error, handler) {
//       switch (error.type) {
//         case DioErrorType.connectionTimeout:
//         case DioErrorType.sendTimeout:
//           throw DeadlineExceededException(error.requestOptions);
//         case DioErrorType.receiveTimeout:
//           throw ReceiveTimeOutException(error.requestOptions);
//         case DioErrorType.badResponse:
//           switch (error.response?.statusCode) {
//             case 401:
//               throw UnauthorizedException(error.requestOptions);
//             case 404:
//               throw NotFoundException(error.requestOptions);
//             case 409:
//               throw ConflictException(error.requestOptions);
//             case 500:
//             case 501:
//             case 503:
//               throw InternalServerErrorException(error.requestOptions);
//           }
//           break;
//         case DioErrorType.cancel:
//           break;
//         case DioErrorType.other:
//           throw NoInternetConnectionException(error.requestOptions);
//       }
//       debugPrint('Error Status Code:${error.response?.statusCode}');
//       return handler.next(error);
//     }), onRequest: (requestOptions, handler) {
//       String currentLocale = "uz";
//       requestOptions.headers["Accept"] = "application/json";
//       requestOptions.headers["Accept-Language"] =
//           currentLocale.isEmpty ? "ru" : currentLocale;
//       return handler.next(requestOptions);
//     }, onResponse: (Response response, ResponseInterceptorHandler handler) {
//       return handler.next(response);
//     }));
//   }
// }
