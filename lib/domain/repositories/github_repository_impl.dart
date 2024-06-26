import 'package:injectable/injectable.dart';
import 'package:ahamove/core/common/result.dart';
import 'package:ahamove/data/remote/github_service.dart';
import 'package:ahamove/data/models/base_repository.dart';
import 'package:ahamove/data/models/response/get_github_profile_response.dart';

abstract class GithubRepository {
  Future<Result<GetGithubProfileResponse>> getGithubProfile();
}

@Injectable(as: GithubRepository)
class GithubRepositoryImpl extends BaseRepository implements GithubRepository {
  // final GithubService _githubService = injector<GithubService>();

  final GithubService _githubService;

  GithubRepositoryImpl(this._githubService);
  @override
  Future<Result<GetGithubProfileResponse>> getGithubProfile() async =>
      await baseApiRepository(_githubService.getGithubProfile());
}
