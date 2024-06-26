import 'dart:developer';

import 'package:ahamove/core/common/result.dart';
import 'package:ahamove/core/injection/injector_container.dart';
import 'package:ahamove/data/models/response/get_github_profile_response.dart';
import 'package:ahamove/data/models/response/get_repositories_of_google_response.dart';
import 'package:ahamove/domain/usecases/get_profile_github_usecase.dart';
import 'package:ahamove/domain/usecases/get_repositories_of_google_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'github_profile_state.dart';

class GithubCubit extends Cubit<GithubState> {
  final _getGithubProfileUseCase = injector<GetProfileGithubUseCase>();
  final _getRepositoriesOfGoogleUseCase =
      injector<GetRepositoriesOfGoogleUseCase>();

  GithubCubit() : super(const GithubState.initial());

  void fetchDataInitial([int page = 1, int per_page = 20]) async {
    try {
      emit(const GithubState.loading());
      final results = await Future.wait([
        _getGithubProfileUseCase.call(),
        _getRepositoriesOfGoogleUseCase.call(page, per_page)
      ]);

      if (results[0] is Success && results[1] is Success) {
        emit(state.copyWith(
            status: GithubStatus.success,
            profile: (results[0] as Success<GetGithubProfileResponse>).data,
            listRepositories:
                (results[1] as Success<List<GetRepositoriesOfGoogleResponse>>)
                    .data));
      } else if (results[0] is Error || results[1] is Error) {
        print('error: ${results[0]}');
        emit(state.copyWith(status: GithubStatus.error, listError: [
          (results[0] as Error).message,
          (results[1] as Error).message
        ]));
      }
    } catch (e) {
      print('error catch: $e');
      emit(state
          .copyWith(status: GithubStatus.error, listError: [e.toString()]));
    }
  }

  void loadMoreListRepositories([int page = 1, int per_page = 20]) async {
    try {
      emit(state.copyWith(status: GithubStatus.loadMore));
      (await _getRepositoriesOfGoogleUseCase.call(page + 1, per_page)).when(
          success: (repo) => emit(state.copyWith(
              status: GithubStatus.success,
              listRepositories: [...state.listRepositories, ...?repo])),
          error: (type, msg) => emit(
              state.copyWith(status: GithubStatus.error, listError: [msg])));
    } catch (e) {
      emit(state
          .copyWith(status: GithubStatus.error, listError: [e.toString()]));
    }
  }

  // void getGithubProfile() async {
  //   (await _getGithubProfileUseCase.call()).when(
  //       success: (profile) => emit(GithubProfileLoaded(profile!)),
  //       error: (type, msg) => emit(GithubProfileError(msg)));
  // }

  // void getGithubRepositories([int page = 1, int per_page = 20]) async {
  //   (await _getRepositoriesOfGoogleUseCase.call(page, per_page)).when(
  //       success: (repo) => {
  //             print('data repo: ${inspect(repo)}'),
  //             emit(GithubRepositoriesLoaded(repo ?? []))
  //           },
  //       error: (type, msg) => emit(GithubRepositoriesError(msg)));
  // }
}
