// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../domain/repositories/github_repository_impl.dart' as _i5;
import '../../domain/usecases/get_profile_github_usecase.dart' as _i6;
import '../remote/github_service.dart' as _i4;
import 'modules/datasource.module.dart' as _i7;

const String _dev = 'dev';

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final dataSourceModule = _$DataSourceModule();
  gh.singleton<_i3.Dio>(
    () => dataSourceModule.dioProd(),
    registerFor: {_dev},
  );
  gh.factory<_i4.GithubService>(() => _i4.GithubService(gh<_i3.Dio>()));
  gh.factory<_i5.GithubRepository>(
      () => _i5.GithubRepositoryImpl(gh<_i4.GithubService>()));
  gh.factory<_i6.GetProfileGithubUseCase>(
      () => _i6.GetProfileGithubUseCase(gh<_i5.GithubRepository>()));
  return getIt;
}

class _$DataSourceModule extends _i7.DataSourceModule {}
