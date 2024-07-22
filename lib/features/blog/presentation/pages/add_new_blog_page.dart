import 'dart:io';

import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
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
  File? file;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        file = pickedImage;
      });
    }
  }

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
              file != null
                  ? GestureDetector(
                      onTap: () => selectImage(),
                      child: SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              file!,
                              fit: BoxFit.cover,
                            )),
                      ),
                    )
                  : GestureDetector(
                      onTap: () => selectImage(),
                      child: DottedBorder(
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
                            },
                            child: Chip(
                              label: Text(e),
                              side: selectedTopics.contains(e)
                                  ? null
                                  : BorderSide(
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
