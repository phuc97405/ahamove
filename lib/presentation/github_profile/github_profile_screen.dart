import 'package:ahamove/core/base/functions/base_functions.dart';
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
      // context.read<GithubCubit>().getGithubProfile();
      context.read<GithubCubit>().getGithubRepositories();
    });
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, kToolbarHeight, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GithubInfo(),
            const SizedBox(height: 30),
            const Text(
              'Popular repositories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),
            BlocConsumer<GithubCubit, GithubState>(
              listener: (BuildContext context, GithubState state) {
                switch (state) {
                  case GithubRepositoriesInitial _:
                    showDialogView(
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
                  case GithubRepositoriesLoaded _:
                    Navigator.of(context).pop();
                    break;
                  case GithubRepositoriesError _:
                    showDialogView(
                      context: context,
                      content: Container(
                          margin: const EdgeInsets.only(left: 7),
                          child: Text(state.message)),
                    );
                    break;
                  default:
                }
              },
              buildWhen: (previous, current) =>
                  current is GithubRepositoriesLoaded,
              builder: (context, state) {
                return Expanded(
                  child: state is GithubRepositoriesLoaded
                      ? ListView.builder(
                          itemCount: state.listRepositories.length,
                          controller: controller,
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            final repo = state.listRepositories[index];
                            print('stargazersCount ${repo.stargazers_count}');
                            return RepositoryCard(
                              key: ValueKey(repo.id),
                              name: repo.name ?? '',
                              description: repo.description ?? '',
                              language: repo.language ?? '',
                              stars: BaseFunctions.instance
                                  .formatNumberToK(repo.stargazers_count ?? 0),
                              forks: BaseFunctions.instance
                                  .formatNumberToK(repo.forks_count ?? 0),
                            );
                          })
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
      padding: const EdgeInsets.all(16),
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
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 0.5, color: Colors.grey)),
                child: const Text('Public'),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(description),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(Icons.do_disturb_on_rounded, size: 16),
              const SizedBox(width: 4),
              Text(language),
              const SizedBox(width: 16),
              const Icon(Icons.star_border, size: 16),
              const SizedBox(width: 4),
              Text(stars),
              const SizedBox(width: 16),
              const Icon(Icons.call_split, size: 16),
              const SizedBox(width: 4),
              Text(forks),
            ],
          ),
        ],
      ),
    );
  }
}
