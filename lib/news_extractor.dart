import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/news_details.dart';
import 'model/comments_details.dart';

class HackerNewsApi {
  static const String baseUrl = 'https://hacker-news.firebaseio.com/v0';

  static Future<List<int>> fetchStoryIds(String type) async {
  final url = Uri.parse('$baseUrl/${type}stories.json');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);

    // Safely convert to List<int>, ignoring any invalid entries
    return data
        .where((element) => element != null)
        .map((e) => e is int ? e : int.tryParse(e.toString()) ?? 0)
        .where((e) => e != 0) // remove fallback 0 if parsing failed
        .toList();
  } else {
    throw Exception('Failed to fetch story IDs');
  }
}



  static Future<NewsDetails> fetchNewsDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/item/$id.json'));
    if (response.statusCode == 200) {
      return NewsDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load news details');
    }
  }

  static Future<Comment?> fetchComment(int id) async{
    final url = Uri.parse('https://hacker-news.firebaseio.com/v0/item/$id.json');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body) as Map<String, dynamic>;
    if (data['deleted'] == true) return null;
    return Comment.fromJson(data);
  } else {
    return null;
  }
}

  static Future<List<Comment>> fetchAllComments(List<int>? ids) async {
  if (ids == null || ids.isEmpty) return [];

  List<Comment> comments = [];
  for (var id in ids) {
    final comment = await fetchComment(id);
    if (comment != null) {
      comments.add(comment);
      comments.addAll(await fetchAllComments(comment.kids));
    }
  }
  return comments;
}

}