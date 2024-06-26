import 'dart:developer';

import 'package:ahamove/core/injection/injector_container.dart';
import 'package:ahamove/data/models/response/get_github_profile_response.dart';
import 'package:ahamove/data/models/response/get_repositories_of_google_response.dart';
import 'package:ahamove/domain/usecases/get_profile_github_usecase.dart';
import 'package:ahamove/domain/usecases/get_repositories_of_google_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'github_profile_state.dart';

class GithubCubit extends Cubit<GithubState> {
  final _getGithubProfileUseCase = injector<GetProfileGithubUseCase>();
  final _getRepositoriesOfGoogleUseCase =
      injector<GetRepositoriesOfGoogleUseCase>();

  GithubCubit() : super(GithubProfileInitial());

  void getGithubProfile() async {
    emit(GithubProfileLoading());
    (await _getGithubProfileUseCase.call()).when(
        success: (profile) => emit(GithubProfileLoaded(profile!)),
        error: (type, msg) => emit(GithubProfileError(msg)));
  }

  void getGithubRepositories([int page = 1, int per_page = 20]) async {
    emit(GithubRepositoriesInitial());
    (await _getRepositoriesOfGoogleUseCase.call(page, per_page)).when(
        success: (repo) => {
              print('data repo: ${inspect(repo)}'),
              emit(GithubRepositoriesLoaded(repo ?? []))
            },
        error: (type, msg) => emit(GithubRepositoriesError(msg)));
  }
}
