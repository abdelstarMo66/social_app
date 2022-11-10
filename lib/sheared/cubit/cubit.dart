import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/sheared/constant/image.dart';
import 'package:social_app/sheared/constant/uid.dart';
import 'package:social_app/sheared/cubit/states.dart';
import 'package:social_app/sheared/style/icon/icon_broken.dart';

import '../../models/post_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int current_index = 0;

  int numberMyPosts = 0;

  void numMyPost() {
    numberMyPosts++;
  }

  int getNumberMyPosts() {
    return numberMyPosts;
  }

  List<Widget> Screens = [
    FeedsScreen(),
    ChatScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> Titles = [
    " Feeds",
    " Chats",
    " Location",
    " Setting",
  ];

  List<Widget> ItemsNavBar = [
    Icon(IconBroken.Home),
    Icon(IconBroken.Chat),
    Icon(IconBroken.Location),
    Icon(IconBroken.Setting),
  ];

  void changeBottomNavBar(index) {
    if (index == 1) {
      allUsers();
    }
    if (index == 0) {
      GetPosts();
      GetMyPosts();
    }
    if (index == 3) {
      GetUser();
    }
    current_index = index;
    emit(ChangeBottomNavBarState());
  }

  void refrechData() {
    allUsers();
    GetUser();
    GetPosts();
    GetMyPosts();
    GetUserPosts();
  }

  UserModel? model;

  void GetUser() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection("Users").doc(uId).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error));
    });
  }

  List<PostModel>? posts;

  void GetPosts() {
    posts = [];
    numberMyPosts = 0;
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('Posts')
        .orderBy("date_time")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        posts!.add(PostModel.fromJson(element.data()));
      });
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState(error));
    });
  }

  List<PostModel>? myposts;

  void GetMyPosts() {
    myposts = [];
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('date_time')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data()['uid'] == uId) {
          numberMyPosts++;
          print(numberMyPosts);
          myposts!.add(PostModel.fromJson(element.data()));
        }
      });
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState(error));
    });
  }

  List<PostModel>? userposts;

  void GetUserPosts() {
    userposts = [];
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('date_time')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data()['uid'] != uId) {
          userposts!.add(PostModel.fromJson(element.data()));
        }
      });
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState(error));
    });
  }

  List<UserModel> users = [];

  void allUsers() {
    users = [];
    emit(GetAllUserLoadingState());
    FirebaseFirestore.instance.collection('Users').get().then((value) {
      value.docs.forEach((element) {
        //print(element.data()['uid']);
        if (element.data()['uid'] != model!.uid) {
          users.add(UserModel.fromJson(element.data()));
        }
      });
      emit(GetAllUserSuccessState());
    }).catchError((error) {
      emit(GetAllUserErrorState(error));
    });
  }

  final imagepicker = ImagePicker();

  File? ProfileImage;

  Future GetProfileImage() async {
    var pickedImage = await imagepicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      ProfileImage = File(pickedImage.path);
      emit(ProfileImageSuccessState());
    } else {
      print('No Image Selected');
      emit(ProfileImageErrorState());
    }
  }

  File? CoverImage;

  Future GetCoverImage() async {
    var pickedImage = await imagepicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      CoverImage = File(pickedImage.path);
      emit(CoverImageSuccessState());
    } else {
      print('No Image Selected');
      emit(CoverImageErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    FirebaseStorage.instance
        .ref()
        .child("Users/${Uri.file(ProfileImage!.path).pathSegments.last}")
        .putFile(ProfileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profile = value;
        emit(UpdateProfileImageSuccessState());
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          photoProfile: profile,
        );
      }).catchError((error) {
        emit(UpdateProfileImageErrorState());
      }).toString();
    }).catchError((error) {
      emit(UpdateProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    FirebaseStorage.instance
        .ref()
        .child("Users/${Uri.file(CoverImage!.path).pathSegments.last}")
        .putFile(CoverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        cover = value;
        print(value);
        emit(UpdateCoverImageSuccessState());
        updateUserData(name: name, phone: phone, bio: bio, photoCover: cover);
      }).catchError((error) {
        emit(UpdateCoverImageErrorState());
      }).toString();
    }).catchError((error) {
      emit(UpdateCoverImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UpdateUserDataLoadingState());
    if (ProfileImage != null && CoverImage != null) {
      uploadCoverImage(name: name, phone: phone, bio: bio);
      uploadProfileImage(name: name, phone: phone, bio: bio);
    }
    if (CoverImage != null && ProfileImage == null) {
      uploadCoverImage(name: name, phone: phone, bio: bio);
    }
    if (ProfileImage != null && CoverImage == null) {
      uploadProfileImage(name: name, phone: phone, bio: bio);
    }
    if (ProfileImage == null && CoverImage == null) {
      updateUserData(name: name, phone: phone, bio: bio);
    }
  }

  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? photoProfile,
    String? photoCover,
  }) {
    {
      UserModel userdata = UserModel(
        phone: phone,
        name: name,
        bio: bio,
        email: model!.email,
        bg_image: photoCover ?? model!.bg_image,
        image: photoProfile ?? model!.image,
        uid: uId,
        isEmailVerified: false,
      );

      FirebaseFirestore.instance
          .collection('Users')
          .doc(uId!)
          .update(userdata.toMap())
          .then((value) {
        GetUser();
      }).catchError((error) {
        emit(UpdateUserDataErrorState());
      });
    }
  }

  File? PostImage;

  Future GetPostImage() async {
    var pickedImage = await imagepicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      PostImage = File(pickedImage.path);
      emit(PostImageSuccessState());
    } else {
      print('No Image Selected');
      emit(PostImageErrorState());
    }
  }

  void removePostImage() {
    PostImage = null;
    emit(removePostImageState());
  }

  void createPostWithImage({
    String? post_image,
    required String text,
    required String date_time,
  }) {
    emit(AddPostLoadingState());
    FirebaseStorage.instance
        .ref()
        .child("Users/${Uri.file(PostImage!.path).pathSegments.last}")
        .putFile(PostImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPostWithoutImage(
          text: text,
          date_time: date_time,
          post_image: value,
        );
        emit(UpdatePostImageSuccessState());
      }).catchError((error) {
        emit(UpdatePostImageErrorState());
      }).toString();
    }).catchError((error) {
      emit(UpdatePostImageErrorState());
    });
  }

  void createPostWithoutImage({
    String? post_image,
    required String text,
    required String date_time,
  }) {
    {
      emit(AddPostLoadingState());
      PostModel userdata = PostModel(
        name: model!.name,
        uId: uId,
        image: model!.image,
        date_time: date_time,
        text: text,
        post_image: post_image ?? '',
      );

      FirebaseFirestore.instance
          .collection('Posts')
          .add(userdata.toMap())
          .then((value) {
        emit(AddPostSuccessState());
      }).catchError((error) {
        emit(AddPostErrorState());
      });
    }
  }


  
  void deletePost({
  required String idPost,
})
  {
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(idPost)
        .delete()
        .then((value) {
          emit(DeletePostSuccessState());
    })
        .catchError((error){
          emit(DeletePostErrorState());
    });
  }

  File? ChatImage;

  Future GetChatImage() async {
    var pickedImage = await imagepicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      ChatImage = File(pickedImage.path);
      emit(ChatImageSuccessState());
    } else {
      print('No Image Selected');
      emit(ChatImageErrorState());
    }
  }

  void removeChatImage() {
    ChatImage = null;
    emit(removeChatImageState());
  }

  List<ChatModel> messages = [];

  void getMessages({
    required String receiveId,
  }) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('Chats')
        .doc(receiveId)
        .collection('messaages')
        .orderBy('dateMessage')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(ChatModel.fromJson(element.data()));
      });
      emit(GetMessageSuccessState());
    });
  }

  void sendMessage({
    required String text,
    required String receiveId,
    required String dateMessage,
    String? Chat_Image,
  }) {
    ChatModel modelChat = ChatModel(
      text: text,
      dateMessage: dateMessage,
      receiverId: receiveId,
      senderId: model!.uid,
      image: Chat_Image ?? '',
    );
    //my message
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uId)
        .collection("Chats")
        .doc(receiveId)
        .collection('messaages')
        .add(modelChat.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    //receive message
    FirebaseFirestore.instance
        .collection("Users")
        .doc(receiveId)
        .collection("Chats")
        .doc(uId)
        .collection('messaages')
        .add(modelChat.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  void sendMessageWithImage({
    required String text,
    required String receiveId,
    required String dateMessage,
    String? chat_img,
  }) {
    FirebaseStorage.instance
        .ref()
        .child("Users/${Uri.file(ChatImage!.path).pathSegments.last}")
        .putFile(ChatImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        sendMessage(
          receiveId: receiveId,
          Chat_Image: value,
          dateMessage: dateMessage,
          text: text,
        );
        emit(ChatImageSuccessState());
      }).catchError((error) {
        emit(ChatImageErrorState());
      }).toString();
    }).catchError((error) {
      emit(ChatImageErrorState());
    });
  }
}
