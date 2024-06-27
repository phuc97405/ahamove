import 'package:ahamove/core/common/result.dart';
import 'package:ahamove/core/injection/injector_container.dart';
import 'package:ahamove/data/models/response/get_github_profile_response.dart';
import 'package:ahamove/domain/repositories/github_repository_impl.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileGithubUseCase {
  final GithubRepository githubRepository = injector<GithubRepository>();

  Future<Result<GetGithubProfileResponse>> call() async =>
      await githubRepository.getGithubProfile();
}
