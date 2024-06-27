import 'package:ahamove/core/extensions/context_extensions.dart';
import 'package:ahamove/core/extensions/num_extensions.dart';
import 'package:ahamove/core/extensions/text_extensions.dart';
import 'package:ahamove/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahamove/core/constants/enums/git_enums.dart';
import 'package:ahamove/core/base/functions/base_functions.dart';
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

  void listenScrollToTop() {
    if (controller.position.maxScrollExtent == controller.position.pixels) {
      final state = context.read<GithubCubit>().state;
      if (state.status == GithubStatus.success) {
        context.read<GithubCubit>().loadMoreListRepositories(state.pageNext);
      }
    }
  }

  @override
  void dispose() {
    controller.removeListener(listenScrollToTop);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(kHorizontalContentPadding,
            kToolbarHeight, kHorizontalContentPadding, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GithubInfo(),
            BlocBuilder<GithubCubit, GithubState>(
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
                                  padding: const EdgeInsets.all(0),
                                  itemBuilder: (context, index) {
                                    final repo = state.listRepositories[index];
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
              Text(name,
                  style: context.textTheme.text_mdB
                      .copyWith(color: Colors.blue[800])),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(kHorizontalContentPadding),
                    border: Border.all(width: 0.5, color: Colors.grey)),
                child: Text('Public', style: context.textTheme.text_xsM),
              )
            ],
          ),
          8.ph,
          Text(description, style: context.textTheme.text_smR),
          15.ph,
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
              ),
              4.pw,
              Text(language, style: context.textTheme.text_xsM),
              16.pw,
              const Icon(Icons.star_border, size: 16),
              4.pw,
              Text(stars, style: context.textTheme.text_xsM),
              16.pw,
              const Icon(Icons.call_split, size: 16),
              4.pw,
              Text(forks, style: context.textTheme.text_xsM),
            ],
          ),
        ],
      ),
    );
  }
}
