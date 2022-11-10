import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/shop_layout.dart';
import 'package:social_app/modules/first_page.dart';
import 'package:social_app/sheared/constant/uid.dart';
import 'package:social_app/sheared/cubit/cubit.dart';
import 'package:social_app/sheared/netword/local/cashe_helper.dart';
import 'package:social_app/sheared/observer.dart';
import 'package:social_app/sheared/themes/light.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await CacheHelper.init();
  BlocOverrides.runZoned(
    () {},
    blocObserver: MyBlocObserver(),
  );

  Widget? startWidget;

  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    startWidget = Layout();
  } else {
    startWidget = FirstPage();
  }

  runApp(MyApp(
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  Widget? startWidget;
  MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
   //  print(uId);
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..GetUser()..GetPosts()..GetMyPosts()..GetUserPosts()..allUsers(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
        theme: LightTheme,
      ),
    );
  }
}
