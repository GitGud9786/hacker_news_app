import 'package:flutter/material.dart';
import 'package:flutter_application_3/model/news_details.dart';
import 'package:go_router/go_router.dart';

import 'navigation_wrapper.dart';
import 'top_stories.dart';
import 'best_stories.dart';
import 'new_stories.dart';
import 'comments.dart';

final GoRouter router = GoRouter(
  initialLocation: '/top',
  routes: [
    // ShellRoute for main pages
    ShellRoute(
      builder: (context, state, child) => NavigationWrapper(child: child),
      routes: [
        GoRoute(path: '/top', builder: (context, state) => const TopStories()),
        GoRoute(path: '/best', builder: (context, state) => const BestStories()),
        GoRoute(path: '/new', builder: (context, state) => const NewStories()),
      ],
    ),

    // Top-level route for comments
    GoRoute(
      path: '/comments',
      builder: (context, state) {
        final news = state.extra as NewsDetails;
        return CommentPage(news: news);
      },
    ),
  ],
);





