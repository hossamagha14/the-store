import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget widget;
  final function;
  const MyElevatedButton(
      {Key? key,
      required this.height,
      required this.width,
      required this.widget,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * width,
        height: height,
        child: ElevatedButton(
            onPressed: function,
            child: widget));
  }
}
