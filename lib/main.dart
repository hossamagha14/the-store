import 'package:flutter/material.dart';
import 'package:the_store/view/reusable/myStyle.dart';
import 'package:the_store/view/screens/bottomNavBarScreen.dart';
import 'package:the_store/view/screens/introPage.dart';
import 'package:the_store/view/screens/login.dart';
import 'package:the_store/view_model/database/network/cache_helpher.dart';
import 'package:the_store/view_model/database/network/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  bool? finishIntro = CacheHelper.getData(key: 'finishIntro');
  String? token = CacheHelper.getData(key: 'token');
  finishIntro ??= false;
  token ??= '';
  runApp(
    MyApp(
      finishIntro: finishIntro,
      token: token,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool finishIntro;
  final String token;
  const MyApp({Key? key, required this.finishIntro, required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              elevation: 20,
              selectedItemColor: myMainColor,
              unselectedItemColor: myMainColor,
              showUnselectedLabels: true,
              backgroundColor: Colors.green),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: mySecondaryColor, elevation: 50),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: myMainColor),
            color: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
                color: myMainColor, fontSize: 20, fontWeight: FontWeight.bold),
            centerTitle: true,
          ),
          primaryColor: const Color(0xFF8624A6),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(mySecondaryColor)))),
      home: finishIntro == false
          ? IntroPage()
          : token == ''
              ? LogInScreen()
              : BottomNavBarScreen(),
    );
  }
}
