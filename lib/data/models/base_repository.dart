import 'dart:developer';

import 'package:ahamove/core/common/error_type.dart';
import 'package:ahamove/core/common/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

typedef EntityToModelMapper<Entity, Data> = Data? Function(Entity? entity);
typedef SaveResult<Data> = Future Function(Data? data);

abstract class BaseRepository {
  Future<Result<Data>> baseApiRepository<Data>(
    Future<Data> call, {
    SaveResult<Data?>? saveResult,
  }) async {
    try {
      var response = await call;
      print('response ${inspect(response)}');
      // if (response.isSuccess()) {
      if (response != null) {
        await saveResult?.call(response);
        return Success(response);
      }
      // } else if (response.isFirstLoginSNS()) {
      // logger.d('isFirstLoginSNS');
      // return Error(
      // ErrorType.FIRST_LOGIN_SNS, response.message ?? "Unknown Error");
      // } else if (response.isTokenExpired()) {
      // return Error(
      // ErrorType.TOKEN_EXPIRED, response.message ?? "Unknown Error");
      else {
        return Error(ErrorType.GENERIC, "Unknown Error");
      }
    } on Exception catch (exception) {
      if (kDebugMode) {
        print("Api error message -> ${exception.toString()}");
      }
      if (exception is DioException) {
        switch (exception.type) {
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.badCertificate:
          case DioExceptionType.badResponse:
          case DioExceptionType.cancel:
            return Error(ErrorType.POOR_NETWORK, exception.message!);
          case DioExceptionType.connectionError:
            return Error(ErrorType.NO_NETWORK, exception.message!);
          case DioExceptionType.unknown:
            return Error(ErrorType.GENERIC, exception.message!);
        }
      }
      return Error(ErrorType.GENERIC, "Unknown API error$exception");
    }
  }
}
