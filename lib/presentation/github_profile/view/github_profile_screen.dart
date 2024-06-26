import 'package:ahamove/presentation/github_profile/cubit/github_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GithubProfileScreen extends StatefulWidget {
  const GithubProfileScreen({super.key});

  @override
  State<GithubProfileScreen> createState() => _GithubProfileScreenState();
}

class _GithubProfileScreenState extends State<GithubProfileScreen> {
  @override
  void initState() {
    context.read<GithubProfileCubit>().getGithubProfile();
    super.initState();
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
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  RepositoryCard(
                    name: 'material-design-icons',
                    description:
                        'Material Design icons by Google (Material Symbols)',
                    language: 'Java',
                    stars: '50k',
                    forks: '9.7k',
                  ),
                  RepositoryCard(
                    name: 'guava',
                    description: 'Google core libraries for Java',
                    language: 'Java',
                    stars: '49.6k',
                    forks: '10.9k',
                  ),
                  RepositoryCard(
                    name: 'zx',
                    description: 'A tool for writing better scripts',
                    language: 'JavaScript',
                    stars: '42.1k',
                    forks: '1.1k',
                  ),
                  RepositoryCard(
                    name: 'styleguide',
                    description:
                        'Style guides for Google-originated open-source projects',
                    language: 'HTML',
                    stars: '36.8k',
                    forks: '13.3k',
                  ),
                  RepositoryCard(
                    name: 'leveldb',
                    description:
                        'LevelDB is a fast key-value storage library written at Google that provides an ordered mapping from string keys to string values.',
                    language: 'C++',
                    stars: '35.3k',
                    forks: '7.7k',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GithubInfo extends StatelessWidget {
  const GithubInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(8),
            //         border: Border.all(color: Colors.grey, width: 0.5)),
            //     child: Image.network(
            //         width: 100,
            //         height: 100,
            //         'https://avatars.githubusercontent.com/u/1342004?v=4')),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Google',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Google ❤️ Open Source',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.people, size: 16),
                    const SizedBox(width: 4),
                    RichText(
                      text: const TextSpan(
                          text: '41.4k ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'followers',
                                style: TextStyle(fontWeight: FontWeight.normal))
                          ]),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 116),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16),
                      SizedBox(width: 4),
                      Text('United States of America'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(children: [
                    Icon(Icons.link, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'https://opensource.google/',
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
}

class RepositoryCard extends StatelessWidget {
  final String name;
  final String description;
  final String language;
  final String stars;
  final String forks;

  RepositoryCard({
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
