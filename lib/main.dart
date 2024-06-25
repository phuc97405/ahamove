import 'package:ahamove/app_distribution/environment/env_dev.dart';
import 'package:ahamove/app_distribution/environment/env_prod.dart';
import 'package:ahamove/configurations/configurations.dart';
import 'package:ahamove/data/dependency_injection/di.dart';
import 'package:ahamove/presentation/github_profile/cubit/github_profile_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ahamove/presentation/github_profile/view/github_profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Configurations()
      .setConfigurationValues(kReleaseMode ? environmentProd : environmentDev);
  await configureDependencies(
      environment: kReleaseMode ? Environment.prod : Environment.dev);
  runApp(MaterialApp(
      home: BlocProvider(
    create: (context) => GithubProfileCubit(),
    child: const GithubProfileScreen(),
  )));
}
