import 'dart:io';

import 'package:ahamove/app_distribution/environment/env_dev.dart';
import 'package:ahamove/app_distribution/environment/env_prod.dart';
import 'package:ahamove/configurations/configurations.dart';
import 'package:ahamove/data/dependency_injection/di.dart';
import 'package:ahamove/presentation/github_profile/cubit/github_profile_cubit.dart';
import 'package:ahamove/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ahamove/presentation/github_profile/github_profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Configurations()
      .setConfigurationValues(kReleaseMode ? environmentProd : environmentDev);
  await configureDependencies(
      environment: kReleaseMode ? Environment.prod : Environment.dev);
  HttpOverrides.global = MyHttpOverrides();
  runApp(BlocProvider<GithubCubit>(
      create: (context) => GithubCubit(),
      child:
          MaterialApp(theme: appThemeData, home: const GithubProfileScreen())));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
