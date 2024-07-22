import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;

  BlogLocalDataSourceImpl({required this.box});

  @override
  List<BlogModel> loadBlogs() {
    try {
      List<BlogModel> blogs = [];
      // for (int i = 0; i < box.length; i++) {
      //   blogs.add(BlogModel.fromJson(box.get(i.toString())));
      // }
      return blogs;
    } catch (e) {
      return [];
    }
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    // box.clear();
    // for (int i = 0; i < blogs.length; i++) {
    //   box.put(i.toString(), blogs[i]);
    // }
  }
}
