import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final Function()? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final String text;
  const MainButton(
      {Key? key,
      this.onTap,
      this.backgroundColor,
      this.textColor,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(16.0)),
        height: 56.0,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
