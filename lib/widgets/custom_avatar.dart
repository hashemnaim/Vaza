import 'package:faza_app/utils/values.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomAvatar extends StatelessWidget {
  CustomAvatar({
    Key? key,
    required this.text,
    required this.size,
  }) : super(key: key);

  String text = "N";
  double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextAvatar(
        text: text,
        backgroundColor: AppColors.primaryColor,
        textColor: AppColors.primaryTextColor,
        shape: Shape.Circular,
        size: size,
        numberLetters: 2,
        fontSize: size / 4,
        upperCase: true,
      ),
    );
  }
}
