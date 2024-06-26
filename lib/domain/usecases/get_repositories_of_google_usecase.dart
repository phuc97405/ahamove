import 'package:ahamove/core/common/result.dart';
import 'package:ahamove/core/injection/injector_container.dart';
import 'package:ahamove/data/models/response/get_repositories_of_google_response.dart';
import 'package:ahamove/domain/repositories/github_repository_impl.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRepositoriesOfGoogleUseCase {
  final GithubRepository _githubRepository = injector<GithubRepository>();

  Future<Result<List<GetRepositoriesOfGoogleResponse>>> call(
          int page, int per_page) async =>
      await _githubRepository.getRepositoriesOfGoogle(page, per_page);
}
