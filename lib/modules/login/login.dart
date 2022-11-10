import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/layout/shop_layout.dart';
import 'package:social_app/modules/login/cubit/login_cubit.dart';
import 'package:social_app/modules/login/cubit/login_states.dart';
import 'package:social_app/modules/register/register.dart';
import 'package:social_app/sheared/combonant/elevated_buttin.dart';
import 'package:social_app/sheared/combonant/navigate.dart';
import 'package:social_app/sheared/combonant/text_form_field.dart';
import 'package:social_app/sheared/constant/uid.dart';
import 'package:social_app/sheared/cubit/cubit.dart';
import 'package:social_app/sheared/netword/local/cashe_helper.dart';

import '../../sheared/combonant/my_divider.dart';
import '../../sheared/style/color/colors.dart';

class LoginScreen extends StatelessWidget {
  var email = TextEditingController();
  var password = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).GetUser();
    AppCubit.get(context).GetPosts();

    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
              ).then((value) {
                uId = state.uId;
                Fluttertoast.showToast(
                  msg: 'Hello!',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  fontSize: 16.0,
                );
                AppCubit.get(context).refrechData();
                AppCubit.get(context).current_index=0;
                NavigateAndFinish(context, Layout());
              }).catchError((error) {
                print(error.toString());
              });
            }
            if (state is LoginErrorState) {
              Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                fontSize: 16.0,
              );
            }
          },
          builder: (context, state) {
            var cubit = LoginCubit.get(context);
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 20.0),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello! Welcome back!',
                        style: TextStyle(
                          fontSize: 30,
                          color: Black,
                        ),
                      ),
                      Text(
                        "Hello again, You've been missed!",
                        style: TextStyle(
                          fontSize: 15,
                          color: Gray,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Email Address",
                        style: TextStyle(
                          fontSize: 15,
                          color: Black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextForm(
                        hint: 'Enter Your Email',
                        controller: email,
                        inputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) return 'Please enter your email';
                          return null;
                        },
                        submitted: (value) {},
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 15,
                          color: Black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextForm(
                        hint: 'Enter Your Password',
                        controller: password,
                        inputType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Please enter your password';
                          return null;
                        },
                        submitted: (value) {},
                        hidePass: cubit.showPassword,
                        suffix: IconButton(
                          onPressed: () {
                            cubit.changevisibility();
                          },
                          icon: cubit.suffix,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forget Password?',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                        builder: (context) => Container(
                          width: double.infinity,
                          height: 45,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 8.0,
                              ),
                            ],
                          ),
                          child: button(
                            widget: Text(
                              'Login',
                              style: TextStyle(
                                color: White,
                                fontSize: 22,
                              ),
                            ),
                            onpressed: () {
                              cubit.loginUser(
                                email: email.text,
                                password: password.text,
                              );
                              print(uId);
                            },
                            radius: 10.0,
                            backGround: mainColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MtDiv(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              'Or Login With',
                              style: TextStyle(
                                color: Black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(
                            child: MtDiv(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 55,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          button(
                            onpressed: () {},
                            widget: Row(
                              children: [
                                Icon(
                                  Icons.facebook,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 7.0,
                                ),
                                Text(
                                  'Facebook',
                                  style: TextStyle(
                                    color: Black,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                            backGround: White,
                            radius: 12.0,
                          ),
                          button(
                            onpressed: () {},
                            widget: Row(
                              children: [
                                Icon(
                                  EvaIcons.twitter,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 7.0,
                                ),
                                Text(
                                  'Twitter',
                                  style: TextStyle(
                                    color: Black,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                            backGround: White,
                            radius: 12.0,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 14,
                              color: Gray,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              NavigateAndFinish(context, RegisterScreen());
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
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
        ),
      ),
    );
  }
}
