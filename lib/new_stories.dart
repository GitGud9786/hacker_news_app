import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'model/news_details.dart';
import 'news_extractor.dart';

class NewStories extends StatefulWidget {
  const NewStories({super.key});

  @override
  State<NewStories> createState() => _NewStoriesState();
}

class _NewStoriesState extends State<NewStories> {

  late Future<List<NewsDetails>> newsDetails;

  @override
  void initState() {
    super.initState();
    newsDetails = fetchNewsDetails();
  }

  Future<List<NewsDetails>> fetchNewsDetails() async {
    final ids = await HackerNewsApi.fetchStoryIds('new');
    final details = await Future.wait(ids.take(20).map(HackerNewsApi.fetchNewsDetails));
    return details;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsDetails>>(
      future: newsDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No news available'));
        } else {
          final newsList = snapshot.data!;
          return ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              final news = newsList[index];
              return ListTile(
                title: Text(news.title ?? 'Untitled'),
                subtitle: Text('By ${news.by} | ${news.score} points'),
                onTap: () {
                  if (news.url != null) {
                    GoRouter.of(context).push('/comments', extra: news);
                  }
                },
              );
            },
          );
        }
      },
    );
  }
}
