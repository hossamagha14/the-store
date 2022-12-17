import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:the_store/view/reusable/myStyle.dart';
import 'package:the_store/view/screens/signup.dart';

import '../../view_model/bloc/log/log_Cubit.dart';
import '../../view_model/bloc/log/log_States.dart';
import '../../view_model/database/network/cache_helpher.dart';
import '../reusable/myElevatedButton.dart';
import '../reusable/myTextFormField.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);
  var emailControl = TextEditingController();
  var passwordControl = TextEditingController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogCubit(),
      child: BlocConsumer<LogCubit, LogStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LogCubit myCubit = LogCubit.get(context);
          return state is LogLoadingState
              ? Scaffold(
                  body: Center(
                      child: Padding(
                  padding: const EdgeInsets.all(130),
                  child: myLoadingAnimation,
                )))
              : Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomRight,
                          stops: const [0.2, 1],
                          colors: [Colors.white, backGroundPurple])),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: SafeArea(
                        child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                  child: Image(
                                      image: AssetImage(
                                          'assets/images/girl-with-big-phone.png'))),
                              Text(
                                'Log in',
                                style: myTextStyle,
                              ),
                              MyTextFormField(
                                  control: emailControl,
                                  keyboardType: TextInputType.emailAddress,
                                  secure: false,
                                  label: 'E-mail',
                                  preIcon: Icons.email),
                              MyTextFormField(
                                control: passwordControl,
                                keyboardType: TextInputType.text,
                                secure: myCubit.isPressed,
                                label: 'Password',
                                preIcon: Icons.lock,
                                iconFunction: () {
                                  myCubit.showPassword();
                                },
                                sufIcon: myCubit.isPressed == false
                                    ? Icons.visibility_off
                                    : Icons.remove_red_eye,
                              ),
                              MyElevatedButton(
                                  function: () {
                                    myCubit.logIn(context,
                                        email: emailControl.text,
                                        password: passwordControl.text);
                                  },
                                  height: 50,
                                  width: 1,
                                  widget: Text('Log in',style: buttonTextStyle,)),
                              const Text(
                                'Don\'t Have an acount?',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold),
                              ),
                              MyElevatedButton(
                                  function: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUpScreen(),
                                        ));
                                  },
                                  height: 50,
                                  width: 1,
                                  widget: Text('Sign Up',style: buttonTextStyle,))
                            ],
                          ),
                        ),
                      ),
                    )),
                  ),
                );
        },
      ),
    );
  }
}
