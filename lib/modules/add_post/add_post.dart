import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/sheared/cubit/cubit.dart';
import 'package:social_app/sheared/cubit/states.dart';
import 'package:social_app/sheared/style/color/colors.dart';
import 'package:social_app/sheared/style/icon/icon_broken.dart';

import '../../sheared/combonant/app_bar.dart';

class AddPostScreen extends StatelessWidget {
  var postControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: defAppBar(
              context: context,
              title: Text(
                'Create Post',
                style: Theme.of(context)
                    .appBarTheme
                    .titleTextStyle!
                    .copyWith(fontSize: 20.0),
              ),
              center: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: TextButton(
                    onPressed: () {
                      if (cubit.PostImage == null) {
                        cubit.createPostWithoutImage(
                            text: postControl.text,
                            date_time: DateTime.now().toString());
                      } else {
                        cubit.createPostWithImage(
                            text: postControl.text,
                            date_time: DateTime.now().toString());
                      }
                      Navigator.pop(context);
                      cubit.refrechData();
                    },
                    child: Text(
                      'Post',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ),
                ),
              ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  if (state is AddPostLoadingState) const LinearProgressIndicator(),
                  if (state is AddPostLoadingState)
                    const SizedBox(
                      height: 10.0,
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage("${cubit.model!.image}"),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Text(
                          '${cubit.model!.name}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            height: 1.0,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cubit.GetPostImage();
                        },
                        icon: Icon(IconBroken.Image_2),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'What is on your mind...?',
                      border: InputBorder.none,
                    ),
                    controller: postControl,
                    maxLines: null,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (cubit.PostImage != null)
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: FileImage(cubit.PostImage!) as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: double.infinity,
                          height: 290.0,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.teal[300],
                          radius: 16.0,
                          child: IconButton(
                            onPressed: () {
                              cubit.removePostImage();
                            },
                            icon: Icon(
                              Icons.close,
                              color: Black,
                              size: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
