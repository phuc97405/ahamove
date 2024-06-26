import 'package:ahamove/components/error_dialog.dart';
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

  Widget loadDataProfileSuccess(GithubState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    state.profile?.avatarUrl ?? avatarUrlDefault)),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.profile?.name ?? '',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  state.profile?.description ?? '',
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
                              .formatNumberToK(state.profile?.followers ?? 0),
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
                      Text(state.profile?.location ?? ''),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(children: [
                    const Icon(Icons.link, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      state.profile?.blog ?? '',
                    )
                  ]),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'Popular repositories',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GithubCubit, GithubState>(
        listenWhen: (previous, current) =>
            previous.status != GithubStatus.loadMore,
        listener: (BuildContext context, GithubState state) {
          switch (state.status) {
            case GithubStatus.loading:
            case GithubStatus.initial:
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
            case GithubStatus.success:
              Navigator.of(context).pop();
              break;
            case GithubStatus.error:
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => ErrorAlertDialog(
                        context: context,
                        label: state.listError.join('\n'),
                      )).then((value) {
                if (value != null && value) {
                  Navigator.pop(context);
                }
              });
              break;
            default:
          }
        },
        buildWhen: (previous, current) =>
            previous.status != GithubStatus.loadMore &&
            current.status == GithubStatus.success,
        builder: (BuildContext context, GithubState state) {
          return state.status == GithubStatus.success
              ? loadDataProfileSuccess(state)
              : Container();
        });
  }
}
