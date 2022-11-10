import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/sheared/combonant/app_bar.dart';
import 'package:social_app/sheared/combonant/text_form_field.dart';
import 'package:social_app/sheared/cubit/cubit.dart';
import 'package:social_app/sheared/cubit/states.dart';
import 'package:social_app/sheared/style/icon/icon_broken.dart';

import '../../sheared/style/color/colors.dart';

class EditProfile extends StatelessWidget {
  var name = TextEditingController();
  var phone = TextEditingController();
  var bio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        name.text = cubit.model!.name.toString();
        bio.text = cubit.model!.bio.toString();
        phone.text = cubit.model!.phone.toString();
        return Scaffold(
          appBar: defAppBar(
              context: context,
              title: Text(
                'Edit Profile',
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
                      cubit.updateUser(name: name.text, phone: phone.text, bio: bio.text);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                )
              ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is UpdateUserDataLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                    height: 220.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                  ),
                                  image: DecorationImage(
                                    image: cubit.CoverImage == null
                                        ? NetworkImage(
                                            "${cubit.model!.bg_image}")
                                        : FileImage(cubit.CoverImage!)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                width: double.infinity,
                                height: 160.0,
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.GetCoverImage();

                                },
                                icon: CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor: Colors.grey[300],
                                    child: Icon(
                                      IconBroken.Edit,
                                      size: 16.0,
                                      color: mainColor,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 65.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: cubit.ProfileImage == null
                                    ? NetworkImage("${cubit.model!.image}")
                                    : FileImage(cubit.ProfileImage!)
                                        as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.GetProfileImage();
                              },
                              icon: CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: Colors.grey[300],
                                  child: Icon(
                                    IconBroken.Edit,
                                    size: 16.0,
                                    color: mainColor,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    '   Name :',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 15.0),
                  ),
                  TextForm(
                      hint: 'name',
                      controller: name,
                      inputType: TextInputType.name,
                      prefix: Icon(
                        IconBroken.User,
                        color: mainColor,
                      ),
                      validator: (val) {
                        if (val!.isEmpty) return 'name is empty';
                        return null;
                      },
                      submitted: (value) {}),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '   Bio :',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 15.0),
                  ),
                  TextForm(
                      hint: 'bio',
                      controller: bio,
                      prefix: Icon(
                        IconBroken.Info_Circle,
                        color: mainColor,
                      ),
                      inputType: TextInputType.text,
                      validator: (val) {
                        if (val!.isEmpty) return 'bio is empty';
                        return null;
                      },
                      submitted: (value) {}),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '   Phone :',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 15.0),
                  ),
                  TextForm(
                      hint: 'phone',
                      controller: phone,
                      prefix: Icon(
                        IconBroken.Call,
                        color: mainColor,
                      ),
                      inputType: TextInputType.phone,
                      validator: (val) {
                        if (val!.isEmpty) return 'phone is empty';
                        return null;
                      },
                      submitted: (value) {}),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
