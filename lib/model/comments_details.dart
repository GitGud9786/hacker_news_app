import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String? by;
  final int? id;
  final List<int>? kids;
  final String? text;
  final int? time;
  final bool? deleted;

  const Comment({
    this.by,
    this.id,
    this.kids,
    this.text,
    this.time,
    this.deleted,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        by: json['by'] as String?,
        id: json['id'] as int?,
        kids: (json['kids'] as List<dynamic>?)?.map((e) => e as int).toList(),
        text: json['text'] as String?,
        time: json['time'] as int?,
        deleted: json['deleted'] as bool?,
      );

  @override
  List<Object?> get props => [by, id, kids, text, time, deleted];
}
