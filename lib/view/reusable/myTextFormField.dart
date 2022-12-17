import 'package:flutter/material.dart';
import 'package:the_store/view/reusable/myStyle.dart';

class MyTextFormField extends StatelessWidget {
  final control;
  final TextInputType keyboardType;
  final bool secure;
  final String label;
  final IconData preIcon;
  final IconData? sufIcon;
  final dynamic iconFunction;
  final validator;
  const MyTextFormField(
      {Key? key,
      required this.control,
      required this.keyboardType,
      required this.secure,
      required this.label,
      required this.preIcon,
      this. validator,
      this.iconFunction,
      this.sufIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: mySecondaryColor, width: 2),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white),
      child: TextFormField(
        validator: validator,
        controller: control,
        cursorColor: mySecondaryColor,
        keyboardType: keyboardType,
        obscureText: secure,
        decoration: InputDecoration(
          border: InputBorder.none,
          label: Text(
            label,
            style: TextStyle(color: mySecondaryColor),
          ),
          prefixIcon: Icon(preIcon, color: mySecondaryColor),
          suffixIcon: InkWell(
              onTap: iconFunction,
              child: Icon(sufIcon, color: mySecondaryColor)),
        ),
      ),
    );
  }
}
