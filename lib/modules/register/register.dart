import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/layout/shop_layout.dart';
import 'package:social_app/modules/login/login.dart';
import 'package:social_app/modules/register/cubit/registe_cubit.dart';
import 'package:social_app/modules/register/cubit/registe_states.dart';
import 'package:social_app/sheared/combonant/elevated_buttin.dart';
import 'package:social_app/sheared/combonant/text_form_field.dart';

import '../../sheared/combonant/my_divider.dart';
import '../../sheared/combonant/navigate.dart';
import '../../sheared/constant/uid.dart';
import '../../sheared/constant/uid.dart';
import '../../sheared/netword/local/cashe_helper.dart';
import '../../sheared/style/color/colors.dart';

class RegisterScreen extends StatelessWidget {
  var email = TextEditingController();
  var password = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            if (state is CreateUserSuccessState) {
              CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
              ).then((value) {
                uId = state.uId;
                Fluttertoast.showToast(
                  msg: 'Welcome',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  fontSize: 16.0,
                );
                NavigateAndFinish(context, Layout());
              }).catchError((error) {
                print(error.toString());
              });
            }
          },
          builder: (context, state) {
            var cubit = RegisterCubit.get(context);
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20.0),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 30,
                          color: Black,
                        ),
                      ),
                      Text(
                        "Connect with Your Friends Today!",
                        style: TextStyle(
                          fontSize: 15,
                          color: Gray,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 15,
                          color: Black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextForm(
                        hint: 'Enter Your Name',
                        controller: name,
                        inputType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) return 'Please enter your Name';
                          return null;
                        },
                        submitted: (value) {},
                      ),
                      const SizedBox(
                        height: 10,
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
                        height: 10,
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
                        height: 10,
                      ),
                      Text(
                        "Phone",
                        style: TextStyle(
                          fontSize: 15,
                          color: Black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextForm(
                        hint: 'Enter Your Phone',
                        controller: phone,
                        inputType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) return 'Please enter your Phone';
                          return null;
                        },
                        submitted: (value) {},
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: cubit.checkboxVal,
                            onChanged: (val) {
                              cubit.changeCheckbox(val);
                            },
                            checkColor:
                                cubit.checkboxVal ? Colors.green : Colors.white,
                            activeColor: Colors.white,
                          ),
                          Text(
                            "I agree to the terms and conditions",
                            style: TextStyle(
                              fontSize: 15,
                              color: Black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                        builder: (context) => Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 8.0,
                              ),
                            ],
                          ),
                          width: double.infinity,
                          height: 45,
                          child: button(
                            widget: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: White,
                                fontSize: 22,
                              ),
                            ),
                            onpressed: () {
                              if (cubit.checkboxVal == false) {
                                Fluttertoast.showToast(
                                  msg: 'please agree for terms',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  fontSize: 16.0,
                                );
                              } else {
                                cubit.RegisterUser(
                                  email: email.text,
                                  password: password.text,
                                  name: name.text,
                                  phone: phone.text,
                                );
                              }
                            },
                            radius: 10.0,
                            backGround: mainColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
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
                        height: 30,
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
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              fontSize: 14,
                              color: Gray,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              NavigateAndFinish(context, LoginScreen());
                            },
                            child: Text(
                              'Log in',
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
