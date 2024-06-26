part of 'github_profile_cubit.dart';

sealed class GithubState {}

class GithubProfileInitial extends GithubState {}

class GithubProfileLoading extends GithubState {}

class GithubProfileLoaded extends GithubState {
  final GetGithubProfileResponse profile;
  GithubProfileLoaded(this.profile);
}

class GithubProfileError extends GithubState {
  final String message;
  GithubProfileError(this.message);
}

class GithubRepositoriesInitial extends GithubState {}

class GithubRepositoriesLoaded extends GithubState {
  List<GetRepositoriesOfGoogleResponse> listRepositories = [];
  GithubRepositoriesLoaded(this.listRepositories);
}

class GithubRepositoriesError extends GithubState {
  final String message;
  GithubRepositoriesError(this.message);
}

class GithubRepositoriesLoadMore extends GithubState {}
