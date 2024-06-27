part of 'github_profile_cubit.dart';

class GithubState extends Equatable {
  final GithubStatus status;
  final GetGithubProfileResponse? profile;
  final List<GetRepositoriesOfGoogleResponse> listRepositories;
  final List<String> listError;
  final int pageNext;
  const GithubState(
      {required this.status,
      this.profile,
      this.listRepositories = const [],
      this.listError = const [],
      this.pageNext = 1});

  const GithubState.initial() : this(status: GithubStatus.initial, pageNext: 1);

  const GithubState.loading() : this(status: GithubStatus.loading, pageNext: 1);

  GithubState copyWith(
      {GithubStatus? status,
      GetGithubProfileResponse? profile,
      List<GetRepositoriesOfGoogleResponse>? listRepositories,
      List<String>? listError,
      int? pageNext}) {
    return GithubState(
        status: status ?? this.status,
        profile: profile ?? this.profile,
        listRepositories: listRepositories ?? this.listRepositories,
        listError: listError ?? this.listError,
        pageNext: pageNext ?? this.pageNext);
  }

  @override
  List<Object?> get props => [status, profile, listRepositories, listError];
}
