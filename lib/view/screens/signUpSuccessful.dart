import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_store/view/reusable/myStyle.dart';
import 'package:the_store/view/screens/login.dart';
import '../../view_model/bloc/signup/sign_Cubit.dart';
import '../../view_model/bloc/signup/sign_States.dart';
import '../reusable/myElevatedButton.dart';


class SignUpSuccessfulScreen extends StatelessWidget {
  const SignUpSuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignCubit(),
      child: BlocConsumer<SignCubit, SignStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: state is SignLoadingState? Center(
                      child: Padding(
                  padding: const EdgeInsets.all(130),
                  child: myLoadingAnimation,
                )):Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  signUpsuccessfulAnimation,
                  Column(
                    children: [
                      Text(
                        'You have created a new account',
                        style: TextStyle(
                            fontSize: 20,
                            color: mySecondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'successfully',
                        style: TextStyle(
                            fontSize: 20,
                            color: mySecondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  MyElevatedButton(
                      height: 50,
                      width: 1,
                      widget: Text('Go to login',style: buttonTextStyle,),
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  LogInScreen(),
                            ));
                      })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
