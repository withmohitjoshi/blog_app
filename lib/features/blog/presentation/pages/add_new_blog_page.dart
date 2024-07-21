import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static const String routeName = "add_blog";
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];
  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DottedBorder(
                color: AppPallete.borderColor,
                dashPattern: const [10, 4],
                radius: Radius.circular(10),
                borderType: BorderType.RRect,
                strokeCap: StrokeCap.round,
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.folder_open,
                        size: 40,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Select You Image',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    'Technology',
                    'Business',
                    'Programming',
                    'Entertainment',
                  ]
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              if (selectedTopics.contains(e)) {
                                selectedTopics.remove(e);
                              } else {
                                selectedTopics.add(e);
                              }
                              setState(() {});
                              print(selectedTopics);
                            },
                            child: Chip(
                              label: Text(e),
                              side: BorderSide(
                                color: AppPallete.borderColor,
                              ),
                              color: selectedTopics.contains(e)
                                  ? WidgetStatePropertyAll(AppPallete.gradient1)
                                  : null,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              BlogEditor(controller: titleController, hintText: 'Blog Title'),
              SizedBox(
                height: 10,
              ),
              BlogEditor(
                  controller: contentController, hintText: 'Blog Content'),
            ],
          ),
        ),
      ),
    );
  }
}
