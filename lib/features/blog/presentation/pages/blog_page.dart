import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  static const String routeName = "blog_page";
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog App"),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddNewBlogPage.routeName),
            icon: Icon(CupertinoIcons.add_circled),
          )
        ],
      ),
    );
  }
}
