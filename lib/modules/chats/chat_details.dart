import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/sheared/constant/uid.dart';
import 'package:social_app/sheared/cubit/cubit.dart';
import 'package:social_app/sheared/cubit/states.dart';
import 'package:social_app/sheared/style/icon/icon_broken.dart';

import '../../sheared/style/color/colors.dart';

class Chating extends StatelessWidget {
  var messageControler = TextEditingController();
  UserModel model;

  Chating({required this.model});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        AppCubit.get(context).getMessages(receiveId: "${model.uid}");
        return BlocConsumer<AppCubit, AppStates>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 22.0,
                      backgroundImage: NetworkImage('${model.image}'),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      '${model.name}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
                titleSpacing: 0.0,
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ConditionalBuilder(
                        condition: AppCubit.get(context).messages.isNotEmpty,
                        builder: (context)=>ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message = AppCubit.get(context).messages[index];
                            if (uId == message.senderId) {
                              return BuildMyMessage(message, context);
                            }
                            return BuildMessage(message, context);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15.0,
                          ),
                          itemCount: AppCubit.get(context).messages.length,
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 5.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Type your message here...',
                                    border: InputBorder.none,
                                  ),
                                  controller: messageControler,
                                  maxLines: null,
                                ),
                              ),
                              if (AppCubit.get(context).ChatImage != null)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        image: DecorationImage(
                                          image: FileImage(
                                              AppCubit.get(context)
                                                  .ChatImage!)
                                          as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      width: 80.0,
                                      height: 80.0,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        AppCubit.get(context)
                                            .removeChatImage();
                                      },
                                      child: Container(
                                        //width: 100.0,
                                        height: 30.0,
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          border: Border.all(
                                              color: Colors.white,
                                              width: 2.0),
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Cancle',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              IconButton(
                                onPressed: () {
                                  AppCubit.get(context).GetChatImage();
                                },
                                icon: Icon(IconBroken.Image),
                              ),
                              SizedBox(
                                height: 35.0,
                                width: 35.0,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    if (AppCubit.get(context).ChatImage ==
                                        null) {
                                      AppCubit.get(context).sendMessage(
                                        text: messageControler.text,
                                        receiveId: model.uid.toString(),
                                        dateMessage:
                                        DateTime.now().toString(),
                                      );
                                    } else {
                                      AppCubit.get(context)
                                          .sendMessageWithImage(
                                        text: messageControler.text,
                                        receiveId: model.uid.toString(),
                                        dateMessage:
                                        DateTime.now().toString(),
                                      );
                                    }
                                    messageControler.clear();
                                    AppCubit.get(context).removeChatImage();
                                  },
                                  elevation: 7.0,
                                  child: const Icon(
                                    IconBroken.Send,
                                    color: Colors.white,
                                    size: 22.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {},
        );
      },
    );
  }

  Widget BuildMyMessage(ChatModel model, context) => Align(
        alignment: AlignmentDirectional.topStart,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
            color: mainColor.withOpacity(0.3),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (model.image != null&&model.image!='')
                Image(
                  image: NetworkImage('${model.image}'),
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
              Text("${model.text}"),
            ],
          ),
        ),
      );

  Widget BuildMessage(ChatModel model, context) => Align(
        alignment: AlignmentDirectional.topEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
            color: Colors.grey[300],
          ),
          child: Column(
            children: [
              if (model.image != null&&model.image!='')
                Image(
                  image: NetworkImage('${model.image}'),
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
              Text("${model.text}"),
            ],
          ),
        ),
      );
}
