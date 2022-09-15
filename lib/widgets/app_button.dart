import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/misc/colors.dart';
import 'package:flutter_cubit/widgets/app_text.dart';

class AppButton extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final double size;
  final String? text;
  final IconData? icon;
  final Color borderColor;
  final bool isIcon;
  const AppButton({
    Key? key,
    required this.color,
    this.text,
    this.icon,
    required this.backgroundColor,
    required this.size,
    this.isIcon = false,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: backgroundColor,
            border: Border.all(color: borderColor)),
        child: isIcon
            ? Center(
                child: Icon(
                  icon,
                  color: color,
                ),
              )
            : Center(
                child: Text(
                text!,
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              )));
  }
}
