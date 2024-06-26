import 'package:ahamove/components/error_dialog.dart';
import 'package:ahamove/core/base/functions/base_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahamove/presentation/github_profile/cubit/github_profile_cubit.dart';
import 'package:ahamove/presentation/github_profile/view/github_info_component.dart';

class GithubProfileScreen extends StatefulWidget {
  const GithubProfileScreen({super.key});

  @override
  State<GithubProfileScreen> createState() => _GithubProfileScreenState();
}

class _GithubProfileScreenState extends State<GithubProfileScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<GithubCubit>().fetchDataInitial();
      // context.read<GithubCubit>().getGithubProfile();
      // context.read<GithubCubit>().getGithubRepositories();
    });
    controller.addListener(listenScrollToTop);

    super.initState();
  }

  void showDialogView(
      {required BuildContext context, required Widget content}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(content: content);
      },
    );
  }

  @override
  void dispose() {
    controller.removeListener(listenScrollToTop);
    super.dispose();
  }

  void listenScrollToTop() {
    if (controller.position.maxScrollExtent == controller.position.pixels) {
      final state = context.read<GithubCubit>().state;
      if (state.status == GithubStatus.success) {
        context.read<GithubCubit>().loadMoreListRepositories(state.pageNext);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, kToolbarHeight, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GithubInfo(),
            BlocConsumer<GithubCubit, GithubState>(
              listenWhen: (previous, current) => true,
              listener: (BuildContext context, GithubState state) {
                switch (state.status) {
                  case GithubStatus.initial:
                    // showDialogView(
                    //     context: context,
                    //     content: Row(
                    //       children: [
                    //         const CircularProgressIndicator(
                    //           color: Colors.green,
                    //         ),
                    //         Container(
                    //             margin: const EdgeInsets.only(left: 7),
                    //             child: const Text("Loading...")),
                    //       ],
                    //     ));
                    break;
                  case GithubStatus.success:
                    // Navigator.of(context).pop();
                    break;
                  case GithubStatus.error:
                    // showDialog(
                    //     barrierDismissible: false,
                    //     context: context,
                    //     builder: (BuildContext context) => ErrorAlertDialog(
                    //           context: context,
                    //           label: state.listError.join('\n'),
                    //         )).then((value) {
                    //   if (value != null && value) {
                    //     // Navigator.pop(context);
                    //   }
                    // });
                    break;
                  default:
                }
              },
              buildWhen: (previous, current) =>
                  current.status == GithubStatus.success,
              builder: (context, state) {
                return Expanded(
                  child: state.status == GithubStatus.success ||
                          state.status == GithubStatus.loadMore
                      ? SingleChildScrollView(
                          controller: controller,
                          physics: const ScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.listRepositories.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  // controller: controller,
                                  padding: const EdgeInsets.all(0),
                                  itemBuilder: (context, index) {
                                    final repo = state.listRepositories[index];
                                    // print('stargazersCount ${repo.stargazers_count}');
                                    return RepositoryCard(
                                      key: ValueKey(repo.id),
                                      name: repo.name ?? '',
                                      description: repo.description ?? '',
                                      language: repo.language ?? '',
                                      stars: BaseFunctions.instance
                                          .formatNumberToK(
                                              repo.stargazers_count ?? 0),
                                      forks: BaseFunctions.instance
                                          .formatNumberToK(
                                              repo.forks_count ?? 0),
                                    );
                                  }),
                              const CupertinoActivityIndicator()
                            ],
                          ))
                      : Container(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RepositoryCard extends StatelessWidget {
  final String name;
  final String description;
  final String language;
  final String stars;
  final String forks;

  const RepositoryCard({
    super.key,
    required this.name,
    required this.description,
    required this.language,
    required this.stars,
    required this.forks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.grey),
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 0.5, color: Colors.grey)),
                child: const Text(
                  'Public',
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(Icons.do_disturb_on_rounded, size: 16),
              const SizedBox(width: 4),
              Text(
                language,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.star_border, size: 16),
              const SizedBox(width: 4),
              Text(
                stars,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.call_split, size: 16),
              const SizedBox(width: 4),
              Text(
                forks,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
