import 'package:ahamove/data/models/response/get_github_profile_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:injectable/injectable.dart';
import 'package:ahamove/core/networking/model_base_response.dart';

part 'github_service.g.dart';

class GithubServiceConstants {
  static const getGithubProfile = 'orgs/google';
}

@RestApi()
@injectable
abstract class GithubService {
  @factoryMethod
  factory GithubService(Dio dio) = _GithubService;

  @GET(GithubServiceConstants.getGithubProfile)
  Future<ModelBaseResponse<GetGithubProfileResponse>> getGithubProfile();
}
