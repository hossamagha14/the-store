import 'package:flutter/material.dart';
import 'package:the_store/view/reusable/myElevatedButton.dart';
import 'package:the_store/view/screens/bottomNavBarScreen.dart';

import '../reusable/myStyle.dart';

class OrderSuccessfulScreen extends StatelessWidget {
  const OrderSuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          signUpsuccessfulAnimation,
          Column(
            children: [
              Text(
                'You have completed your order',
                style: TextStyle(
                    fontSize: 25,
                    color: mySecondaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'successfully',
                style: TextStyle(
                    fontSize: 25,
                    color: mySecondaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          MyElevatedButton(
              height: 50,
              width: 0.6,
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    'Go back to home',
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
              function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavBarScreen(),
                    ));
              })
        ],
      )),
    );
  }
}
