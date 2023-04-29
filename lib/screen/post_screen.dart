// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable, unused_field, unused_element, empty_catches, avoid_print

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/provider/user_provider.dart';
import 'package:instagram/resources/firestore_auth.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/pick_image.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _desciptionController = TextEditingController();
  Uint8List? _file;
  bool _isLoading = false;

  void postImage(String name, String uid, String profImage) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FireStoreMethod()
          .uploadPost(_desciptionController.text, _file!, name, uid, profImage);

      if (res == "success") {
        Get.snackbar("Post", res, backgroundColor: Colors.blue);
        _clearImage();
      } else {
        Get.snackbar("Error", res, backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
    setState(() {
      _isLoading = false;
    });
  }

  _selectImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Create a post"),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text("Take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text("Choose a image"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text("Cancel"),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _desciptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    return _file != null
        ? Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                  onTap: () => _clearImage(), child: Icon(Icons.arrow_back)),
              title: Text("Post Screen"),
              backgroundColor: mobileBackgroundColor,
              actions: [
                TextButton(
                  onPressed: () =>
                      postImage(user.uid, user.username, user.photoUrl),
                  child: Text("Post"),
                ),
              ],
            ),
            body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: [
                    _isLoading ? LinearProgressIndicator() : Container(),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(user.photoUrl),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: TextField(
                            controller: _desciptionController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintText: "Enter the caption..."),
                            maxLines: 8,
                          ),
                        ),
                        SizedBox(
                          height: 45,
                          width: 45,
                          child: AspectRatio(
                            aspectRatio: 481 / 451,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: MemoryImage(
                                      _file!,
                                    ),
                                    fit: BoxFit.cover),
                              ),
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          )
        : Scaffold(
            body: Center(
              child: IconButton(
                  onPressed: () => _selectImage(context),
                  icon: Icon(Icons.upload)),
            ),
          );
  }
}
/*SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () async {
                  await AuthMethod().signUserOut();
                },
                child: Text("SignOut")) */