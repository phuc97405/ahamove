import 'package:json_annotation/json_annotation.dart';
part 'model_base_response.g.dart';

const int successStatus = 200;
const int firstLoginSNS = 202;
const int parseError = -1;
const int timeOut = -2;
const int unknownError = 400;
const int tokenExpired = 401;

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class ModelBaseResponse<T> {
  final int? status;
  final String? message;
  final T? data;

  ModelBaseResponse(this.status, this.message, this.data);

  bool isSuccess() => successStatus == status;

  bool isFirstLoginSNS() => firstLoginSNS == status;

  bool isTimeOut() => timeOut == status;

  bool isTokenExpired() => tokenExpired == status;

  bool isUnknownError() => unknownError == status;

  factory ModelBaseResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ModelBaseResponseFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T) toJsonT) =>
      _$ModelBaseResponseToJson<T>(this, toJsonT);
}
