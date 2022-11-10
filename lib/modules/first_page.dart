import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/modules/register/register.dart';
import 'package:social_app/sheared/style/color/colors.dart';
import '../sheared/combonant/navigate.dart';
import 'login/login.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: mainColor,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: mainColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 380,
              child: image(
                url: 'assets/image/first.png',
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "Let's Get\nStarted",
              style: TextStyle(
                color: White,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Text(
              'Connect with each other while chatting or calling. Enjoy safe and private texting',
              style: TextStyle(color: White, fontSize: 15),
            ),
            const SizedBox(
              height: 35.0,
            ),
            Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  NavigateAndFinish(context, RegisterScreen());
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(White),
                ),
                child: Text(
                  'Join Now',
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white54,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    NavigateAndFinish(context, LoginScreen());
                  },
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      color: White,
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
    );
  }

  Widget image({required String? url}) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image(
          image: AssetImage(
            '$url',
          ),
        ),
      );
}
