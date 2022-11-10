import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/cubit/registe_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void RegisterUser({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      CreateUser(
        uId: value.user!.uid,
        email: value.user!.email,
        name: name,
        phone: phone,
      );
    }).catchError((error) {
      emit(RegisterErrorState(error));
    });
  }

  void CreateUser({
    required String? email,
    required String? name,
    required String? phone,
    required String? uId,
  }) {
    UserModel model = UserModel(
      phone: phone,
      name: name,
      email: email,
      uid: uId,
      bio: 'Hello Guys',
      image: 'https://t4.ftcdn.net/jpg/02/15/84/43/240_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg',
      bg_image: 'https://img.freepik.com/free-vector/minimal-geometric-stripe-shape-background_1409-1014.jpg?w=1060&t=st=1658952778~exp=1658953378~hmac=189d2bd356b7de87fe3ddc8695ee14e54b8df00403bf608e867f79eca6b75df7',
    );

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId!)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState(model.uid));
    }).catchError((error) {
      emit(CreateUserErrorState(error));
    });
  }

  bool checkboxVal = false;

  void changeCheckbox(value) {
    checkboxVal = !checkboxVal;
    emit(RegisterChangecheckbox());
  }

  bool showPassword = true;
  Icon suffix = Icon(Icons.visibility_outlined);

  void changevisibility() {
    showPassword = !showPassword;
    suffix = showPassword
        ? Icon(Icons.visibility_outlined)
        : Icon(Icons.visibility_off_outlined);
    emit(RegisterChangeIconVisibility());
  }
}
