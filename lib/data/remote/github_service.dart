import 'package:ahamove/data/models/response/get_github_profile_response.dart';
import 'package:ahamove/data/models/response/get_repositories_of_google_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:injectable/injectable.dart';

part 'github_service.g.dart';

class GithubServiceConstants {
  static const getGithubProfile = 'orgs/google';
  static const getRepositoriesOfGoogle = 'orgs/google/repos';
}

@injectable
@RestApi()
abstract class GithubService {
  @factoryMethod
  factory GithubService(Dio dio) = _GithubService;

  @GET(GithubServiceConstants.getGithubProfile)
  Future<GetGithubProfileResponse> getGithubProfile();
  @GET(GithubServiceConstants.getRepositoriesOfGoogle)
  Future<List<GetRepositoriesOfGoogleResponse>> getRepositoriesOfGoogle(
    @Query("page") int? page,
    @Query("per_page") int? per_page,
  );
}
