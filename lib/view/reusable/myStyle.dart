import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

TextStyle myTextStyle = const TextStyle(
  color: Colors.black,
  fontSize: 40,
  fontWeight: FontWeight.bold,
);


Color myMainColor = const Color(0xFF8624A6);


Color backGroundPurple = const Color(0xFF9C27B0);


Color mySecondaryColor = const Color(0xFFE45E22);


Color thirdColor = const Color(0xFFCDCDCD);


Widget myLoadingAnimation = Center(
    child: SizedBox(
        width: 130,
        child: Lottie.network(
            'https://assets4.lottiefiles.com/private_files/lf30_x2lzmtdl.json')));



LottieBuilder signUpsuccessfulAnimation = Lottie.network(
    'https://assets8.lottiefiles.com/packages/lf20_21759ndg.json');



TextStyle buttonTextStyle =
    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
