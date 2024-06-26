import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ahamove/configurations/configurations.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class DataSourceModule {
  // @preResolve
  // @singleton
  // Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  // @dev
  // Dio dioProd(SharedPreferences sharedPreferences) =>
  //     AppCoreFactory.createDio(Configurations.baseUrl,
  //         isDebug: Configurations.isDebug);

  // @preResolve
  @singleton
  // Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  @dev
  Dio dioProd() => AppCoreFactory.createDio(Configurations.baseUrl,
      isDebug: Configurations.isDebug);
}

class AppCoreFactory {
  static Dio createDio(
    String baseUrl, {
    bool isDebug = false,
  }) {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        validateStatus: (status) => status! < 500,
        sendTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'accept': '*/*',
          // "content-type:": "application/json",
        },
      ), /*  */
    )..interceptors.add(
        ApiTokenInterceptor(),
      );

    if (isDebug) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: false,
          requestBody: false,
          responseBody: false,
          responseHeader: false,
          compact: true,
          maxWidth: 90,
        ),
      );
    }

    return dio;
  }
}

class ApiTokenInterceptor extends InterceptorsWrapper {
  // AuthCacheManager get authCacheManager => injector<AuthCacheManager>();
  ApiTokenInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // if (options.path.contains('user/getToken')) {
    //   return handler.next(options);
    // }

    // final token = await authCacheManager.getToken();
    // options.headers = {
    //   'Authorization': 'Bearer $token',
    // };
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print('onError Interceptor: ${err.message}');
    if (err.response?.statusCode == 401) {
      // await refreshToken(err, handler);
    }
    if (err.response?.statusCode == 403) {
      if (err.response?.data.contains("rate limit exceeded")) {
        print("Rate limit exceeded. Retrying after a delay...");
        await Future.delayed(const Duration(seconds: 60));
        try {
          var response = await Dio().fetch(err.requestOptions);
          return handler.resolve(response);
        } catch (retryError) {
          return handler.reject(retryError as DioException);
        }
      } else {
        return handler.reject(err);
      }
    }

    return handler.next(err);
  }

  // FutureOr refreshToken(
  //     DioException err, ErrorInterceptorHandler handler) async {
  //   try {
  //     // final refreshToken = await authCacheManager.getToken(true);
  //     Dio retryDio = Dio(
  //       BaseOptions(
  //         baseUrl: Configurations.baseUrl,
  //         headers: <String, String>{
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer $refreshToken'
  //         },
  //       ),
  //     );
  //     debugPrint('--[REFRESH TOKEN]--: $refreshToken');
  //     var response = await retryDio.get('user/getToken');
  //     var data = response.data;
  //     if (response.statusCode == 401 || response.statusCode == 403) {
  //       if (kDebugMode) {
  //         print("LOGGING OUT: EXPIRED REFRESH TOKEN");
  //       }
  //       return handler.reject(err);
  //     }
  //     // await authCacheManager.updateTokenAndUserId(
  //     //     TokenEntities(
  //     //         accessToken: data.user?.accessToken,
  //     //         refreshToken: data.user?.refreshToken),
  //     //     null);
  //     return handler.next(err);
  //   } catch (exception) {
  //     // authCacheManager.signOut();
  //   }
  //   return null;
  // }
}
