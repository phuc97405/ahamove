import 'error_type.dart';

class Result<T> with SealedResult<T> {
  // bool get isSuccessful => this is Success<T>;
}

// class ResultLoadMore<T> with SealedResultLoadMore<T> {
//   bool get isSuccessful => this is SuccessLoadMore<T>;
// }

class Success<T> extends Result<T> {
  T? data;
  Success(this.data);
}

// class SuccessLoadMore<T> extends ResultLoadMore<T> {
//   T? data;
//   Meta? meta;
//   SuccessLoadMore(this.data, this.meta);
// }

class Error<T> extends Result<T> {
  ErrorType type;
  String message;

  Error(this.type, this.message);
  bool get isTokenExpired => type == ErrorType.TOKEN_EXPIRED;
  bool get isFirstLoginSNS => type == ErrorType.FIRST_LOGIN_SNS;
}

/**
  * Meta return null => page not has load more!!!
  */
mixin class SealedResult<T> {
  R? when<R>({
    R Function(T?)? success,
    R Function(ErrorType, String)? error,
  }) {
    if (this is Success<T?>) {
      return success?.call((this as Success<T>).data);
    }
    if (this is Error<T>) {
      return error?.call((this as Error<T>).type, (this as Error<T>).message);
    }
    throw Exception(
        'If you got here, probably you forgot to regenerate the classes? Try running flutter packages pub run build_runner build');
  }
}

// mixin class SealedResultLoadMore<T> {
//   R? when<R>({
//     R Function(T?, Meta?)? success,
//     R Function(ErrorType, String)? error,
//   }) {
//     if (this is SuccessLoadMore<T?>) {
//       return success?.call(
//           (this as SuccessLoadMore).data, (this as SuccessLoadMore).meta);
//     }
//     if (this is ErrorLoadMore<T>) {
//       return error?.call(
//           (this as ErrorLoadMore<T>).type, (this as ErrorLoadMore<T>).message);
//     }
//     throw Exception(
//         'If you got here, probably you forgot to regenerate the classes? Try running flutter packages pub run build_runner build');
//   }
// }
