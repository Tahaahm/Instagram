// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String desciption;
  final String username;
  final String postId;
  final String uid;
  final String datePublish;
  final String postUrl;
  final String profImage;
  final likes;

  Posts(
      {required this.username,
      required this.uid,
      required this.desciption,
      required this.datePublish,
      required this.postId,
      required this.postUrl,
      required this.profImage,
      required this.likes});

  static Posts fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Posts(
        username: snapshot['username'],
        uid: snapshot['uid'],
        desciption: snapshot['desciption'],
        postId: snapshot['postId'],
        datePublish: snapshot['datePublish'],
        postUrl: snapshot['postUrl'],
        profImage: snapshot['profImage'],
        likes: snapshot['likes']);
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "desciption": desciption,
        "datePublish": datePublish,
        "postId": postId,
        "postUrl": postUrl,
        "profImage": profImage,
        "uid": uid,
        "likes": likes,
      };
}
