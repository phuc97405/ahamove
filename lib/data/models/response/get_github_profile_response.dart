import 'package:json_annotation/json_annotation.dart';

part 'get_github_profile_response.g.dart';

@JsonSerializable()
class GetGithubProfileResponse {
  String? login;
  int? id;
  String? nodeId;
  String? url;
  String? reposUrl;
  String? eventsUrl;
  String? hooksUrl;
  String? issuesUrl;
  String? membersUrl;
  String? publicMembersUrl;
  String? avatarUrl;
  String? description;
  String? name;
  dynamic company;
  String? blog;
  String? location;
  String? email;
  String? twitterUsername;
  bool? isVerified;
  bool? hasOrganizationProjects;
  bool? hasRepositoryProjects;
  int? publicRepos;
  int? publicGists;
  int? followers;
  int? following;
  String? htmlUrl;
  String? createdAt;
  String? updatedAt;
  dynamic archivedAt;
  String? type;

  GetGithubProfileResponse({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.url,
    required this.reposUrl,
    required this.eventsUrl,
    required this.hooksUrl,
    required this.issuesUrl,
    required this.membersUrl,
    required this.publicMembersUrl,
    required this.avatarUrl,
    required this.description,
    required this.name,
    required this.company,
    required this.blog,
    required this.location,
    required this.email,
    required this.twitterUsername,
    required this.isVerified,
    required this.hasOrganizationProjects,
    required this.hasRepositoryProjects,
    required this.publicRepos,
    required this.publicGists,
    required this.followers,
    required this.following,
    required this.htmlUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.archivedAt,
    required this.type,
  });
  factory GetGithubProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$GetGithubProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetGithubProfileResponseToJson(this);
}
