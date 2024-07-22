import 'dart:io';

import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
      : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_blogUpload);
    on<GetAllBlogsEvent>(_getAllBlogsEvent);
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
        (r) => emit(BlogUploadSuccess()));
  }

  void _getAllBlogsEvent(
      GetAllBlogsEvent event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogs(NoParams());
    res.fold((l) => emit(BlogFailure(message: l.message)),
        (r) => emit(BlogDisplaySuccess(blogs: r)));
  }
}
