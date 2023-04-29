// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, unused_field, avoid_print, prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/auth_method.dart';
import 'package:instagram/screen/layout_responsive.dart';
import 'package:instagram/screen/mobile_screen.dart';
import 'package:instagram/screen/web_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/pick_image.dart';
import 'package:instagram/widgets/text_field_custom.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _bioController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;
  void signUp() async {
    if (_image != null) {
      setState(() {
        _isLoading = true;
      });
      String res = await AuthMethod().signUser(
          email: _emailController.text,
          username: _usernameController.text,
          password: _passwordController.text,
          bio: _bioController.text,
          file: _image!);
      setState(() {
        _isLoading = false;
      });
      if (res == "success") {
        Get.snackbar("Good Enter", res, backgroundColor: Colors.blue);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (builder) => LayoutResponsive(
                mobileScreen: MobileSceen(), webScreen: WebScreen())));
      } else {
        Get.snackbar("Please Check it", res, backgroundColor: Colors.red);
      }
    } else {
      Get.snackbar("Not Well", "Select Image", backgroundColor: Colors.red);
    }
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
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
                height: 20,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          backgroundImage: MemoryImage(_image!),
                          radius: 64,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg"),
                          radius: 64,
                        ),
                  Positioned(
                    bottom: -10,
                    right: 2,
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo),
                      onPressed: selectImage,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldCustom(
                controller: _usernameController,
                hintText: "Enter the username",
                textInputType: TextInputType.text,
              ),
              SizedBox(
                height: 16,
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
                height: 16,
              ),
              TextFieldCustom(
                controller: _bioController,
                hintText: "Enter the Bio",
                textInputType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: signUp,
                child: Container(
                  width: double.maxFinite,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 4,
                              color: Colors.white,
                            ),
                          )
                        : Text("SignUp"),
                  ),
                ),
              ),
              SizedBox(
                height: 17,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Do you have an account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
