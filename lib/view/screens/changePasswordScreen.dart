import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_store/view/reusable/myElevatedButton.dart';
import 'package:the_store/view/reusable/myStyle.dart';
import 'package:the_store/view/screens/profile.dart';
import 'package:the_store/view_model/bloc/profile/profileCubit.dart';
import 'package:the_store/view_model/bloc/profile/profilestates.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  var newPasswordControl = TextEditingController();
  var currentPasswordControl = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is ChangePasswordSuccessfullState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          ProfileCubit myCubit = ProfileCubit.get(context);
          return state is ChangePasswordloadingState
              ? Scaffold(
                  body: myLoadingAnimation,
                )
              : Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomRight,
                          stops: const [0.2, 1],
                          colors: [Colors.white, backGroundPurple])),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      title: const Text('Change your password'),
                      centerTitle: true,
                    ),
                    body: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: mySecondaryColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextFormField(
                                  cursorColor: mySecondaryColor,
                                  validator: (value) {
                                    if (value == null || value == '') {
                                      return 'please enter current password';
                                    }
                                    return null;
                                  },
                                  controller: currentPasswordControl,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter your current password'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: mySecondaryColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextFormField(
                                  cursorColor: mySecondaryColor,
                                  validator: (value) {
                                    if (value == null || value == '') {
                                      return 'please enter new password';
                                    } 
                                    return null;
                                  },
                                  controller: newPasswordControl,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter your new password'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: MyElevatedButton(
                                height: 50,
                                width: 0.6,
                                widget: const Text(
                                  'Confirm new password',
                                  style: TextStyle(fontSize: 18),
                                ),
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    myCubit.changePassword(
                                        newpassword: newPasswordControl.text,
                                        currentpassword:
                                            currentPasswordControl.text);
                                  }
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
