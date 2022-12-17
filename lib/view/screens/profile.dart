import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_store/view/reusable/myElevatedButton.dart';
import 'package:the_store/view/reusable/myStyle.dart';
import 'package:the_store/view/screens/address.dart';
import 'package:the_store/view/screens/addressBook.dart';
import 'package:the_store/view/screens/changePasswordScreen.dart';
import 'package:the_store/view/screens/editProfileScreen.dart';
import 'package:the_store/view/screens/favorites.dart';
import 'package:the_store/view/screens/login.dart';
import 'package:the_store/view_model/bloc/profile/profileCubit.dart';
import 'package:the_store/view_model/bloc/profile/profilestates.dart';
import 'package:the_store/view_model/database/network/cache_helpher.dart';
import 'package:the_store/view_model/database/network/end_points.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfile(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is LogOutSuccessfullState) {
            CacheHelper.clearToken(key: 'token');
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LogInScreen(),
                ));
          }
        },
        builder: (context, state) {
          ProfileCubit myCubit = ProfileCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Profile'),
              centerTitle: true,
            ),
            body: myCubit.profileModel == null
                ? myLoadingAnimation
                : SafeArea(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                  radius: 45,
                                  backgroundColor: myMainColor,
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 50,
                                  )),
                              Text(
                                myCubit.profileModel!.data!.name!,
                                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.email),
                                ),
                                Text(
                                  myCubit.profileModel!.data!.email!,
                                  style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.phone_android),
                                ),
                                Text(
                                  myCubit.profileModel!.data!.phone!,
                                  style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    myCubit.profileModel!.data!.credit
                                        .toString(),
                                    style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                  ),
                                  const Text('Credit')
                                ],
                              ),
                              Container(
                                width: 2,
                                height: 40,
                                color: myMainColor,
                              ),
                              Column(
                                children: [
                                  Text(
                                    myCubit.profileModel!.data!.points
                                        .toString(),
                                    style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                  ),
                                  const Text('Points')
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              thickness: 2,
                              color: myMainColor,
                            ),
                          ),
                          ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddressBook(),
                                        ));
                                  },
                                  title: const Text('Address book',style: TextStyle(fontWeight: FontWeight.bold),),
                                  leading: Icon(
                                    Icons.home_filled,
                                    color: myMainColor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditProfileScreen(),
                                        ));
                                  },
                                  leading: Icon(
                                    Icons.edit,
                                    color: myMainColor,
                                  ),
                                  title: const Text('Edit profile details',style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChangePasswordScreen()));
                                  },
                                  leading: Icon(
                                    Icons.password_rounded,
                                    color: myMainColor,
                                  ),
                                  title: const Text('Change password',style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: () {
                                    myCubit.logOut(token: token);
                                  },
                                  title: Text(
                                    'Sign out',
                                    style: TextStyle(
                                        color: mySecondaryColor,
                                        fontSize: 22,fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
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
