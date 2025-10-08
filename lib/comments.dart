import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'model/news_details.dart';
import 'model/comments_details.dart';
import 'news_extractor.dart';

class CommentPage extends StatefulWidget {
  final NewsDetails news;

  const CommentPage({super.key, required this.news});

  @override
  State<CommentPage> createState() => CommentPageState();
}

class CommentPageState extends State<CommentPage> {
  late Future<List<Comment>> commentsFuture;

  @override
  void initState() {
    super.initState();
    commentsFuture = HackerNewsApi.fetchAllComments(widget.news.kids);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.news.title ?? "Comments"),
      ),
      body: FutureBuilder<List<Comment>>(
        future: commentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No comments found."));
          }

          final commentsData = snapshot.data!;
          return ListView.builder(
            itemCount: commentsData.length,
            itemBuilder: (context, index) {
              final comment = commentsData[index];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Username
                    Text(
                      comment.by ?? "Unknown",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),

                    Html(
                      data: comment.text ?? "",
                      style: {
                        "body": Style(
                          margin: Margins.zero,
                          padding: HtmlPaddings.zero,
                          fontSize: FontSize.medium,
                        ),
                      },
                      onLinkTap: (url, _, __) {
                        if (url != null) {
                          debugPrint("Tapped link: $url");
                        }
                      },
                    ),

                    const Divider(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
