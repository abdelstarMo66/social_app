import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/sheared/combonant/toasting.dart';
import 'package:social_app/sheared/style/color/colors.dart';

import '../sheared/cubit/cubit.dart';
import '../sheared/cubit/states.dart';
import '../sheared/style/icon/icon_broken.dart';

class Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.Titles[cubit.current_index]),
            actions: [
              if(cubit.current_index==0)
                IconButton(onPressed: (){}, icon:Icon(IconBroken.Notification,)),
              if(cubit.current_index==0)
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8.0),
                  child: IconButton(onPressed: (){}, icon:Icon(IconBroken.Search,)),
                ),
            ],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            items: cubit.ItemsNavBar,
            index: cubit.current_index,
            backgroundColor: Colors.teal.withOpacity(0.7),
            color: Colors.teal.withOpacity(0.8),
            buttonBackgroundColor: Colors.teal,
            animationCurve: Curves.fastOutSlowIn,
            height: 50.0,
            onTap: (index)
            {
              cubit.changeBottomNavBar(index);
            },
          ),
          body: cubit.Screens[cubit.current_index],
        );
      },
    );
  }
}
