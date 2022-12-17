import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:the_store/view/screens/login.dart';

import '../../view_model/bloc/intro/introCubit.dart';
import '../../view_model/bloc/intro/introstates.dart';
import '../../view_model/database/network/cache_helpher.dart';
import '../reusable/myStyle.dart';

class IntroPage extends StatelessWidget {
  IntroPage({Key? key}) : super(key: key);
  var pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IntroCubit(),
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  stops: const [0.2, 1],
                  colors: [Colors.white, backGroundPurple])),
          child: BlocConsumer<IntroCubit, IntroStates>(
            listener: (context, state) {},
            builder: (context, state) {
              IntroCubit myCubit = IntroCubit.get(context);
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    if (myCubit.isLast == true) {
                      CacheHelper.saveData(key: 'finishIntro', value: true)
                          .then((value) {
                        if (value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LogInScreen(),
                              ));
                        }
                      });
                    } else if (myCubit.isLast == false) {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  CacheHelper.saveData(
                                          key: 'finishIntro', value: true)
                                      .then((value) {
                                    if (value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LogInScreen(),
                                          ));
                                    }
                                  });
                                },
                                child: const Text(
                                  'Skip',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: PageView.builder(
                              physics: const BouncingScrollPhysics(),
                              controller: pageController,
                              onPageChanged: (index) {
                                myCubit.navigateToLogin(index);
                              },
                              itemCount: myCubit.intromodel.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 60,
                                          ),
                                          Image(
                                              image: AssetImage(myCubit
                                                  .intromodel[index].image)),
                                        ],
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        myCubit.intromodel[index].text,
                                        style: const TextStyle(
                                          fontSize: 21,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                        SmoothPageIndicator(
                          controller: pageController, // PageController
                          count: myCubit.intromodel.length,
                          effect: WormEffect(
                              dotColor: Colors.white70,
                              activeDotColor:
                                  mySecondaryColor), // your preferred effect
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
