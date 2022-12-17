import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_store/view/reusable/myStyle.dart';
import 'package:the_store/view/screens/profile.dart';
import 'package:the_store/view_model/bloc/profile/profileCubit.dart';
import 'package:the_store/view_model/bloc/profile/profilestates.dart';
import '../../view_model/bloc/signup/sign_Cubit.dart';
import '../../view_model/bloc/signup/sign_States.dart';
import '../reusable/myElevatedButton.dart';
import '../reusable/myTextFormField.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  var nameControl = TextEditingController();
  var emailControl = TextEditingController();
  var phoneControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfile(),
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
                        child: BlocConsumer<ProfileCubit, ProfileStates>(
                          listener: (context, state) {
                            if(state is UpdateSuccessfullState){
                              Navigator.pop(context);
                            }
                          },
                          builder: (context, state) {
                            ProfileCubit myCubit = ProfileCubit.get(context);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Center(
                                      child: Image(
                                          image: AssetImage(
                                              'assets/images/girls-with-shopping-cart.png'))),
                                ),
                                Text(
                                  'Edit profile',
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
                                    control: phoneControl,
                                    keyboardType: TextInputType.phone,
                                    secure: false,
                                    label: 'Phone',
                                    preIcon: Icons.phone_android),
                                MyElevatedButton(
                                    height: 50,
                                    width: 1,
                                    widget: Text(
                                      'Update profile',
                                      style: buttonTextStyle,
                                    ),
                                    function: () {
                                      myCubit.updateProfile(
                                          name: nameControl.text,
                                          email: emailControl.text,
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
