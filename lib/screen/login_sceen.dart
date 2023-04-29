// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, unused_field, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:instagram/resources/auth_method.dart';
import 'package:instagram/screen/layout_responsive.dart';
import 'package:instagram/screen/mobile_screen.dart';
import 'package:instagram/screen/signup_screen.dart';
import 'package:instagram/screen/web_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/text_field_custom.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  void signInUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethod().SignIn(
        email: _emailController.text, password: _passwordController.text);

    if (res != "success") {
      Get.snackbar("Not Enter", res, backgroundColor: Colors.red);
    } else {
      Get.snackbar("Good Enter", res, backgroundColor: Colors.blue);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (builder) => LayoutResponsive(
              mobileScreen: MobileSceen(), webScreen: WebScreen())));
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/ic_instagram.svg",
                color: primaryColor,
              ),
              SizedBox(
                height: 200,
              ),
              TextFieldCustom(
                controller: _emailController,
                hintText: "Enter the email",
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 16,
              ),
              TextFieldCustom(
                controller: _passwordController,
                hintText: "Enter the password",
                textInputType: TextInputType.visiblePassword,
                isPass: true,
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: signInUser,
                child: Container(
                  width: double.maxFinite,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Center(
                          child: Text("Login"),
                        ),
                ),
              ),
              SizedBox(
                height: 17,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => SignUpScreen()));
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
