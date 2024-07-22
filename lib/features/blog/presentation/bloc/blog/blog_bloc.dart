import 'dart:io';

import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  BlogBloc({required UploadBlog uploadBlog})
      : _uploadBlog = uploadBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_blogUpload);
  }

  void _blogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(UploadBlogParams(
      posterId: event.posterId,
      content: event.content,
      title: event.title,
      topics: event.topics,
      image: event.image,
    ));
    res.fold((l) => emit(BlogFailure(message: l.message)),
        (r) => emit(BlogSuccess()));
  }
}
