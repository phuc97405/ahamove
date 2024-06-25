part of 'github_profile_cubit.dart';

@immutable
sealed class GithubProfileState {}

final class GithubProfileInitial extends GithubProfileState {}

final class GithubProfileLoading extends GithubProfileState {}

final class GithubProfileLoaded extends GithubProfileState {}
