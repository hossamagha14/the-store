import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:the_store/view/reusable/myStyle.dart';
import 'package:the_store/view_model/bloc/Home/homeCubit.dart';
import 'package:the_store/view_model/bloc/Home/homeStates.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit myCubit = HomeCubit.get(context);
          return Scaffold(
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: GNav(
                tabs: const [
                  GButton(
                    textStyle: TextStyle(fontSize: 15, color: Colors.white),
                    icon: Icons.home,
                    text: ' Home',
                  ),
                  GButton(
                    textStyle: TextStyle(fontSize: 15, color: Colors.white),
                    icon: Icons.favorite,
                    text: ' Favorite',
                  ),
                  GButton(
                    textStyle: TextStyle(fontSize: 15, color: Colors.white),
                    icon: Icons.shopping_cart_checkout,
                    text: ' Cart',
                  ),
                  GButton(
                    textStyle: TextStyle(fontSize: 15, color: Colors.white),
                    icon: Icons.person,
                    text: ' Profile',
                  )
                ],
                activeColor: Colors.white,
                hoverColor: Colors.purple.shade300,
                rippleColor: Colors.purple.shade400,
                color: Colors.black54,
                tabBorderRadius: 50,
                iconSize: 23,
                tabBackgroundColor: myMainColor,
                selectedIndex: myCubit.currentIndex,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                onTabChange: (index) {
                  myCubit.bottomNavBarScroll(index);
                },
              ),
            ),
            body: myCubit.Screens[myCubit.currentIndex],
          );
        },
      ),
    );
  }
}
