import 'package:flutter/cupertino.dart';

class User {
  final String workPlace;
  final String gender;
  final int age;
  final String imgUrl;
  final String bio;
  final int likes;
  bool isLiked;
  bool isSwipedOff;

  User({
    @required this.gender,
    @required this.workPlace,
    @required this.age,
    @required this.imgUrl,
    @required this.bio,
    @required this.likes,
    this.isLiked = false,
    this.isSwipedOff = false,
  });
}
