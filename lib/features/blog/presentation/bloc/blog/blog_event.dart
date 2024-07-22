part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUpload extends BlogEvent {
  final String posterId;
  final String content;
  final String title;
  final List<String> topics;
  final File image;

  BlogUpload(
      {required this.posterId,
      required this.content,
      required this.title,
      required this.topics,
      required this.image});
}
