import 'package:ahamove/core/base/functions/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahamove/core/constants/app/string_constants.dart';
import 'package:ahamove/presentation/github_profile/cubit/github_profile_cubit.dart';

class GithubInfo extends StatefulWidget {
  const GithubInfo({super.key});
  @override
  State<GithubInfo> createState() => _GithubInfoState();
}

class _GithubInfoState extends State<GithubInfo> {
  static String avatarUrlDefault =
      'https://avatars.githubusercontent.com/u/1342004?v=4';

  Widget loadDataProfileSuccess(GithubProfileLoaded state) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey, width: 0.5)),
                child: Image.network(
                    width: 100,
                    height: 100,
                    state.profile.avatarUrl ?? avatarUrlDefault)),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.profile.name ?? '',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  state.profile.description ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.people, size: 16),
                    const SizedBox(width: 4),
                    RichText(
                      text: TextSpan(
                          text: BaseFunctions.instance
                              .formatNumberToK(state.profile.followers ?? 0),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          children: const <TextSpan>[
                            TextSpan(
                                text: ' ${StringConstants.followers}',
                                style: TextStyle(fontWeight: FontWeight.normal))
                          ]),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 116),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16),
                      const SizedBox(width: 4),
                      Text(state.profile.location ?? ''),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(children: [
                    const Icon(Icons.link, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      state.profile.blog ?? '',
                    )
                  ]),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GithubCubit, GithubState>(
        listenWhen: (previous, current) => true,
        listener: (BuildContext context, GithubState state) {
          switch (state) {
            case GithubProfileLoading _:
            case GithubProfileInitial _:
              BaseFunctions.instance.showDialogView(
                  context: context,
                  content: Row(
                    children: [
                      const CircularProgressIndicator(
                        color: Colors.green,
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 7),
                          child: const Text("Loading...")),
                    ],
                  ));
              break;
            case GithubProfileLoaded _:
              Navigator.of(context).pop();
              break;
            case GithubProfileError _:
              BaseFunctions.instance.showDialogView(
                context: context,
                content: Container(
                    margin: const EdgeInsets.only(left: 7),
                    child: Text(state.message)),
              );
              break;
            default:
            // Navigator.of(context).pop();
          }
        },
        buildWhen: (previous, current) => current is GithubProfileLoaded,
        builder: (BuildContext context, GithubState state) {
          return state is GithubProfileLoaded
              ? loadDataProfileSuccess(state)
              : Container();
        });
  }
}
