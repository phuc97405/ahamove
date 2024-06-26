import 'dart:developer';

import 'package:ahamove/core/injection/injector_container.dart';
import 'package:ahamove/domain/usecases/get_profile_github_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'github_profile_state.dart';

class GithubProfileCubit extends Cubit<GithubProfileState> {
  final _getGithubProfileUseCase = injector<GetProfileGithubUseCase>();
  GithubProfileCubit() : super(GithubProfileInitial());

  void getGithubProfile() async {
    try {
      // emit(GithubProfileLoading());
      (await _getGithubProfileUseCase.call()).when(
          success: (profile) => {print('data profile: ${inspect(profile)}')},
          error: (type, msg) => print('error msg: $msg'));
      // emit(GithubProfileLoaded(profile));
    } catch (e) {
      print('error $e');
    }
  }
}
