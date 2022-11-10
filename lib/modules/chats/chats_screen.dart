import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chat_details.dart';
import 'package:social_app/sheared/combonant/navigate.dart';
import 'package:social_app/sheared/cubit/cubit.dart';
import 'package:social_app/sheared/cubit/states.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).users.isNotEmpty,
          builder: (context){
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatBuild(context,AppCubit.get(context).users[index]);
              },
              separatorBuilder: (context, index) =>Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[200],
              ),
              itemCount: AppCubit.get(context).users.length,
            );
          },
          fallback: (context)=>const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget ChatBuild(context, UserModel model) =>
      InkWell(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                '${model.name}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
        onTap: ()
        {
          print(model.email);
          print(model.name);
          print(model.uid);
          NavigateTo(context, Chating(model: model));
        },
      );
}
