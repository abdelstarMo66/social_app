import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/add_post/add_post.dart';
import 'package:social_app/sheared/combonant/navigate.dart';
import 'package:social_app/sheared/cubit/cubit.dart';
import 'package:social_app/sheared/cubit/states.dart';
import 'package:social_app/sheared/style/color/colors.dart';
import 'package:social_app/sheared/style/icon/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          floatingActionButton: Container(
            width: 50.0,
            height: 50.0,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  NavigateTo(context, AddPostScreen());
                },
                backgroundColor: mainColor,
                child: Icon(
                  IconBroken.Edit_Square,
                  color: Black,
                ),
                autofocus: true,
              ),
            ),
          ),
          body: ConditionalBuilder(
            condition: cubit.posts!.length > 0,
            builder: (context) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    /*Card(
                elevation: 5.0,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image(
                  image: NetworkImage(
                      'https://img.freepik.com/free-photo/excited-happy-young-pretty-woman_171337-2005.jpg?w=996&t=st=1658922829~exp=1658923429~hmac=e6d1880080c789e69b4eb99cdb2dc5fc488623166d5b3062afa44e490bbe585d,'),
                  fit: BoxFit.cover,
                  height: 250.0,
                  width: double.infinity,
                ),
              ),*/
                    SizedBox(
                      height: 10.0,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BuildPostItims(context, cubit.userposts![index]);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 5.0,
                      ),
                      itemCount: cubit.userposts!.length,
                    ),
                    SizedBox(
                      height: 70.0,
                    ),
                  ],
                ),
              );
            },
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget BuildPostItims(context, PostModel model) {
    List<String> choices = ['favourite'];
    return Card(
      elevation: 5.0,
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              height: 1.0,
                            ),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: mainColor,
                            size: 20.0,
                          ),
                        ],
                      ),
                      Text(
                        '${model.date_time}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_horiz),
                  onSelected: (select) {
                    if (select == choices[0]) {
                      print('favourite');
                    }
                  },
                  iconSize: 25.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  color: Colors.white60,
                  itemBuilder: (context) {
                    return choices.map((choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[200],
            ),
            SelectableText(
              '${model.text}',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            if (model.post_image != "")
              Container(
                padding: EdgeInsets.only(top: 8.0),
                width: double.infinity,
                height: 220.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(
                    image: NetworkImage('${model.post_image}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 18.0,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          "500",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
                Spacer(),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Chat,
                          size: 18.0,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          "700 Comments",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[200],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15.0,
                          backgroundImage: NetworkImage(
                              '${AppCubit.get(context).model!.image}'),
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          'Write a comment...',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 5.0),
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 18.0,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          "Like",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 5.0),
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Send,
                          size: 18.0,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          "Share",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
