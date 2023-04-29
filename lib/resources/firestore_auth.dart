// ignore_for_file: unused_local_variable, empty_catches, prefer_const_constructors, await_only_futures, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:instagram/model/post.dart';
import 'package:instagram/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> uploadPost(String desciption, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "Some error occured";
    try {
      String photoUrl =
          await StorageMethod().uploadImageToStorage("posts", file, true);
      String postId = Uuid().v1();
      Posts posts = Posts(
        username: username,
        uid: uid,
        desciption: desciption,
        datePublish: DateTime.now().toString(),
        postId: postId,
        postUrl: photoUrl,
        profImage: profImage,
        likes: [],
      );
      await _firestore.collection("posts").doc(postId).set(posts.toJson());

      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
