import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/sheared/combonant/app_bar.dart';
import 'package:social_app/sheared/combonant/navigate.dart';
import 'package:social_app/sheared/constant/uid.dart';
import 'package:social_app/sheared/cubit/cubit.dart';
import 'package:social_app/sheared/cubit/states.dart';
import 'package:social_app/sheared/style/color/colors.dart';
import 'package:social_app/sheared/style/icon/icon_broken.dart';

import '../../models/post_model.dart';
import '../../sheared/combonant/elevated_buttin.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  int lengthOfMyPost = 1;
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
              'Profile',
              style: Theme.of(context)
                  .appBarTheme
                  .titleTextStyle!
                  .copyWith(fontSize: 20.0),
            ),
            center: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is GetUserLoadingState)
                    const LinearProgressIndicator(),
                  if (state is GetUserLoadingState)
                    const SizedBox(
                      height: 10.0,
                    ),
                  SizedBox(
                    height: 220.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
                              image: DecorationImage(
                                image: NetworkImage("${cubit.model!.bg_image}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            width: double.infinity,
                            height: 160.0,
                          ),
                        ),
                        CircleAvatar(
                          radius: 65.0,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage:
                                NetworkImage("${cubit.model!.image}"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${cubit.model!.name}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '${cubit.model!.bio}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              '89',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Followings',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '64K',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '316',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: ()
                      {
                        print(cubit.numberMyPosts);
                      }, icon: Icon(Icons.add)),
                      Container(
                        width: 140.0,
                        child: OutlinedButton(
                          onPressed: () {
                            NavigateTo(context, EditProfile());
                          },
                          child: Row(
                            children: [
                              Icon(IconBroken.Edit),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('Edit Profile'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 8.0),
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[200],
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BuildMyPostItims(context, cubit.myposts![index]);
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5.0,
                    ),
                    itemCount: cubit.numberMyPosts,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget BuildMyPostItims(context, PostModel model) {
    List<String> choices = ['edit', 'delete', 'favourite'];
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
                  backgroundImage: NetworkImage('${AppCubit.get(context).model!.image}'),
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
                      print('edit');
                    }
                    if (select == choices[1]) {
                      print('}');
                    }
                    if (select == choices[2]) {
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
            if (model.text != "")
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
          ],
        ),
      ),
    );
  }
}
