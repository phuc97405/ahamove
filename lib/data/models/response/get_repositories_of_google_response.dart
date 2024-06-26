import 'package:json_annotation/json_annotation.dart';
part 'get_repositories_of_google_response.g.dart';

@JsonSerializable()
class GetRepositoriesOfGoogleResponse {
  int id;
  String? nodeId;
  String? name;
  String? fullName;
  bool? private;
  Owner? owner;
  String? htmlUrl;
  String? description;
  bool? fork;
  String? url;
  String? forksUrl;
  String? keysUrl;
  String? collaboratorsUrl;
  String? teamsUrl;
  String? hooksUrl;
  String? issueEventsUrl;
  String? eventsUrl;
  String? assigneesUrl;
  String? branchesUrl;
  String? tagsUrl;
  String? blobsUrl;
  String? gitTagsUrl;
  String? gitRefsUrl;
  String? treesUrl;
  String? statusesUrl;
  String? languagesUrl;
  String? stargazersUrl;
  String? contributorsUrl;
  String? subscribersUrl;
  String? subscriptionUrl;
  String? commitsUrl;
  String? gitCommitsUrl;
  String? commentsUrl;
  String? issueCommentUrl;
  String? contentsUrl;
  String? compareUrl;
  String? mergesUrl;
  String? archiveUrl;
  String? downloadsUrl;
  String? issuesUrl;
  String? pullsUrl;
  String? milestonesUrl;
  String? notificationsUrl;
  String? labelsUrl;
  String? releasesUrl;
  String? deploymentsUrl;
  String? createdAt;
  String? updatedAt;
  String? pushedAt;
  String? gitUrl;
  String? sshUrl;
  String? cloneUrl;
  String? svnUrl;
  String? homepage;
  int? size;
  int? stargazers_count;
  int? watchers_count;
  String? language;
  bool? has_issues;
  bool? has_projects;
  bool? has_downloads;
  bool? has_wiki;
  bool? has_Pages;
  bool? has_discussions;
  int? forks_count;
  dynamic mirror_url;
  bool? archived;
  bool? disabled;
  int? open_issues_count;
  License? license;
  bool? allow_forking;
  bool? is_template;
  bool? web_commit_signoff_required;
  List<String>? topics;
  String? visibility;
  int? forks;
  int? open_issues;
  int? watchers;
  String? default_branch;
  Permissions? permissions;

  GetRepositoriesOfGoogleResponse({
    required this.id,
    required this.nodeId,
    required this.name,
    required this.fullName,
    required this.private,
    required this.owner,
    required this.htmlUrl,
    required this.description,
    required this.fork,
    required this.url,
    required this.forksUrl,
    required this.keysUrl,
    required this.collaboratorsUrl,
    required this.teamsUrl,
    required this.hooksUrl,
    required this.issueEventsUrl,
    required this.eventsUrl,
    required this.assigneesUrl,
    required this.branchesUrl,
    required this.tagsUrl,
    required this.blobsUrl,
    required this.gitTagsUrl,
    required this.gitRefsUrl,
    required this.treesUrl,
    required this.statusesUrl,
    required this.languagesUrl,
    required this.stargazersUrl,
    required this.contributorsUrl,
    required this.subscribersUrl,
    required this.subscriptionUrl,
    required this.commitsUrl,
    required this.gitCommitsUrl,
    required this.commentsUrl,
    required this.issueCommentUrl,
    required this.contentsUrl,
    required this.compareUrl,
    required this.mergesUrl,
    required this.archiveUrl,
    required this.downloadsUrl,
    required this.issuesUrl,
    required this.pullsUrl,
    required this.milestonesUrl,
    required this.notificationsUrl,
    required this.labelsUrl,
    required this.releasesUrl,
    required this.deploymentsUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.pushedAt,
    required this.gitUrl,
    required this.sshUrl,
    required this.cloneUrl,
    required this.svnUrl,
    required this.homepage,
    required this.size,
    required this.stargazers_count,
    required this.watchers_count,
    required this.language,
    required this.has_issues,
    required this.has_Pages,
    required this.has_downloads,
    required this.has_wiki,
    required this.has_projects,
    required this.has_discussions,
    required this.forks_count,
    required this.mirror_url,
    required this.archived,
    required this.disabled,
    required this.open_issues,
    required this.license,
    required this.allow_forking,
    required this.is_template,
    required this.web_commit_signoff_required,
    required this.topics,
    required this.visibility,
    required this.forks,
    required this.open_issues_count,
    required this.watchers,
    required this.default_branch,
    required this.permissions,
  });

  factory GetRepositoriesOfGoogleResponse.fromJson(Map<String, dynamic> json) =>
      _$GetRepositoriesOfGoogleResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetRepositoriesOfGoogleResponseToJson(this);
}

@JsonSerializable()
class License {
  String? key;
  String? name;
  String? spdxId;
  String? url;
  String? nodeId;

  License({
    required this.key,
    required this.name,
    required this.spdxId,
    required this.url,
    required this.nodeId,
  });

  factory License.fromJson(Map<String, dynamic> json) =>
      _$LicenseFromJson(json);
  Map<String, dynamic> toJson() => _$LicenseToJson(this);
}

@JsonSerializable()
class Owner {
  String? login;
  int? id;
  String? nodeId;
  String? avatarUrl;
  String? gravatarId;
  String? url;
  String? htmlUrl;
  String? followersUrl;
  String? followingUrl;
  String? gistsUrl;
  String? starredUrl;
  String? subscriptionsUrl;
  String? organizationsUrl;
  String? reposUrl;
  String? eventsUrl;
  String? receivedEventsUrl;
  String? type;
  bool? siteAdmin;

  Owner({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.gravatarId,
    required this.url,
    required this.htmlUrl,
    required this.followersUrl,
    required this.followingUrl,
    required this.gistsUrl,
    required this.starredUrl,
    required this.subscriptionsUrl,
    required this.organizationsUrl,
    required this.reposUrl,
    required this.eventsUrl,
    required this.receivedEventsUrl,
    required this.type,
    required this.siteAdmin,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}

@JsonSerializable()
class Permissions {
  bool? admin;
  bool? maintain;
  bool? push;
  bool? triage;
  bool? pull;

  Permissions({
    required this.admin,
    required this.maintain,
    required this.push,
    required this.triage,
    required this.pull,
  });
  factory Permissions.fromJson(Map<String, dynamic> json) =>
      _$PermissionsFromJson(json);
  Map<String, dynamic> toJson() => _$PermissionsToJson(this);
}
