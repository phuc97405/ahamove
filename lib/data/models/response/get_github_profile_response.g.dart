// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_github_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGithubProfileResponse _$GetGithubProfileResponseFromJson(
        Map<String, dynamic> json) =>
    GetGithubProfileResponse(
      login: json['login'] as String?,
      id: (json['id'] as num?)?.toInt(),
      nodeId: json['nodeId'] as String?,
      url: json['url'] as String?,
      reposUrl: json['reposUrl'] as String?,
      eventsUrl: json['eventsUrl'] as String?,
      hooksUrl: json['hooksUrl'] as String?,
      issuesUrl: json['issuesUrl'] as String?,
      membersUrl: json['membersUrl'] as String?,
      publicMembersUrl: json['publicMembersUrl'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      description: json['description'] as String?,
      name: json['name'] as String?,
      company: json['company'],
      blog: json['blog'] as String?,
      location: json['location'] as String?,
      email: json['email'] as String?,
      twitterUsername: json['twitterUsername'] as String?,
      isVerified: json['isVerified'] as bool?,
      hasOrganizationProjects: json['hasOrganizationProjects'] as bool?,
      hasRepositoryProjects: json['hasRepositoryProjects'] as bool?,
      publicRepos: (json['publicRepos'] as num?)?.toInt(),
      publicGists: (json['publicGists'] as num?)?.toInt(),
      followers: (json['followers'] as num?)?.toInt(),
      following: (json['following'] as num?)?.toInt(),
      htmlUrl: json['htmlUrl'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      archivedAt: json['archivedAt'],
      type: json['type'] as String?,
    );

Map<String, dynamic> _$GetGithubProfileResponseToJson(
        GetGithubProfileResponse instance) =>
    <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'nodeId': instance.nodeId,
      'url': instance.url,
      'reposUrl': instance.reposUrl,
      'eventsUrl': instance.eventsUrl,
      'hooksUrl': instance.hooksUrl,
      'issuesUrl': instance.issuesUrl,
      'membersUrl': instance.membersUrl,
      'publicMembersUrl': instance.publicMembersUrl,
      'avatarUrl': instance.avatarUrl,
      'description': instance.description,
      'name': instance.name,
      'company': instance.company,
      'blog': instance.blog,
      'location': instance.location,
      'email': instance.email,
      'twitterUsername': instance.twitterUsername,
      'isVerified': instance.isVerified,
      'hasOrganizationProjects': instance.hasOrganizationProjects,
      'hasRepositoryProjects': instance.hasRepositoryProjects,
      'publicRepos': instance.publicRepos,
      'publicGists': instance.publicGists,
      'followers': instance.followers,
      'following': instance.following,
      'htmlUrl': instance.htmlUrl,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'archivedAt': instance.archivedAt,
      'type': instance.type,
    };
