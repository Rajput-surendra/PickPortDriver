import 'dart:ui';
import 'package:flutter/material.dart';

import 'Color.dart';

class Btn extends StatelessWidget {
  final String? title;
  final VoidCallback? onPress;
  double? height;
  double? width;
  double? fSize;
  IconData? icon;
  Color? color;
  Btn(
      {Key? key,
        this.title,
        this.onPress,
        this.height,
        this.width,
        this.fSize,
        this.icon,
        this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: colors.whiteTemp,
                offset: Offset(
                  0.0,
                  3.0,
                ),
                blurRadius: 2.0,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            color: colors.whiteTemp,
            border: Border.all(color: colors.primary, width: 2)),
        width: width ?? MediaQuery.of(context).size.width * 0.6,
        height: 50,
        child: Center(
            child: Text(
              "$title",
              style: TextStyle(
                  color: colors.primary, fontSize: 18, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}

class FilledBtn extends StatelessWidget {
  final String? title;
  final VoidCallback? onPress;
  double? height;
  double? width;
  double? fSize;
  IconData? icon;
  Color? color;
  FilledBtn(
      {Key? key,
        this.title,
        this.onPress,
        this.height,
        this.width,
        this.fSize,
        this.icon,
        this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: colors.whiteTemp,
              offset: Offset(
                0.0,
                3.0,
              ),
              blurRadius: 2.0,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [colors.primary,colors.primary]),
          //  color: colors.primary,
        ),
        width: MediaQuery.of(context).size.width * 0.6,
        height: 50,
        child: Center(
            child: Text(
              "$title",
              style: const TextStyle(
                  color: colors.whiteTemp,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            )),
      ),
    );
  }
}