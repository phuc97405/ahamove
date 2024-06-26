import 'dart:developer';

import 'package:ahamove/core/common/result.dart';
import 'package:ahamove/data/models/response/get_github_profile_response.dart';
import 'package:ahamove/domain/repositories/github_repository_impl.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileGithubUseCase {
  // final GithubRepository _githubRepository = injector<GithubRepository>();
  final GithubRepository _githubRepository;
  GetProfileGithubUseCase(this._githubRepository);

  Future<Result<GetGithubProfileResponse>> call() async =>
      await _githubRepository.getGithubProfile();
}
