import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_store/view/reusable/myStyle.dart';
import '../../view_model/bloc/signup/sign_Cubit.dart';
import '../../view_model/bloc/signup/sign_States.dart';
import '../reusable/myElevatedButton.dart';
import '../reusable/myTextFormField.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  var nameControl = TextEditingController();
  var emailControl = TextEditingController();
  var passwordControl = TextEditingController();
  var phoneControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignCubit(),
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  stops: const [0.2, 1],
                  colors: [Colors.white, backGroundPurple])),
          child: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: mySecondaryColor,
                  )),
            ),
            backgroundColor: Colors.transparent,
            body: SafeArea(
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: BlocConsumer<SignCubit, SignStates>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            SignCubit myCubit = SignCubit.get(context);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Center(
                                          child: Image(
                                              image: AssetImage(
                                                  'assets/images/girls-with-shopping-cart.png'))),
                                      Text(
                                        'Sign up now and start the most amazing ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: mySecondaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'shopping experience',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: mySecondaryColor,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  'Sign Up',
                                  style: myTextStyle,
                                ),
                                MyTextFormField(
                                    control: nameControl,
                                    keyboardType: TextInputType.name,
                                    secure: false,
                                    label: 'Name',
                                    preIcon: Icons.person),
                                MyTextFormField(
                                    control: emailControl,
                                    keyboardType: TextInputType.emailAddress,
                                    secure: false,
                                    label: 'E-mail',
                                    preIcon: Icons.email),
                                MyTextFormField(
                                  control: passwordControl,
                                  keyboardType: TextInputType.name,
                                  secure: myCubit.isPressed,
                                  label: 'Password',
                                  preIcon: Icons.lock,
                                  iconFunction: () {
                                    myCubit.showPassword();
                                  },
                                  sufIcon: myCubit.isPressed == true
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off,
                                ),
                                MyTextFormField(
                                    control: phoneControl,
                                    keyboardType: TextInputType.phone,
                                    secure: false,
                                    label: 'Phone',
                                    preIcon: Icons.phone_android),
                                MyElevatedButton(
                                    height: 50,
                                    width: 1,
                                    widget: Text('Sign Up',style: buttonTextStyle,),
                                    function: () {
                                      myCubit.signUpFunction(context,
                                          name: nameControl.text,
                                          email: emailControl.text,
                                          password: passwordControl.text,
                                          phone: phoneControl.text);
                                    })
                              ],
                            );
                          },
                        ),
                      ),
                    ))),
          )),
    );
  }
}
