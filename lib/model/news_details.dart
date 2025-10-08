import 'package:equatable/equatable.dart';

class NewsDetails extends Equatable {
  final String? by;
  final int? descendants;
  final int? id;
  final List<int>? kids;
  final int? score;
  final int? time;
  final String? title;
  final String? type;
  final String? url;

  const NewsDetails({
    this.by,
    this.descendants,
    this.id,
    this.kids,
    this.score,
    this.time,
    this.title,
    this.type,
    this.url,
  });

  factory NewsDetails.fromJson(Map<String, dynamic> json) => NewsDetails(
    by: json['by'] as String?,
    descendants: json['descendants'] as int?,
    id: json['id'] as int?,
    kids: (json['kids'] as List<dynamic>?)?.map((e) => e as int).toList(),
    score: json['score'] as int?,
    time: json['time'] as int?,
    title: json['title'] as String?,
    type: json['type'] as String?,
    url: json['url'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'by': by,
    'descendants': descendants,
    'id': id,
    'kids': kids,
    'score': score,
    'time': time,
    'title': title,
    'type': type,
    'url': url,
  };

  NewsDetails copyWith({
    String? by,
    int? descendants,
    int? id,
    List<int>? kids,
    int? score,
    int? time,
    String? title,
    String? type,
    String? url,
  }) {
    return NewsDetails(
      by: by ?? this.by,
      descendants: descendants ?? this.descendants,
      id: id ?? this.id,
      kids: kids ?? this.kids,
      score: score ?? this.score,
      time: time ?? this.time,
      title: title ?? this.title,
      type: type ?? this.type,
      url: url ?? this.url,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [by, descendants, id, kids, score, time, title, type, url];
  }
}
