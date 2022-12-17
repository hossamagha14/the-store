import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:the_store/view/reusable/myElevatedButton.dart';
import 'package:the_store/view/reusable/myStyle.dart';
import 'package:the_store/view/screens/bottomNavBarScreen.dart';
import 'package:the_store/view_model/bloc/Home/homeCubit.dart';
import 'package:the_store/view_model/bloc/Home/homeStates.dart';
import 'package:the_store/view_model/models/homeModel.dart';

class RightProductDetailsScreen extends StatelessWidget {
  final int productIndex;
  RightProductDetailsScreen({Key? key, required this.productIndex})
      : super(key: key);
  var pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit myCubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>   BottomNavBarScreen()));
                  },
                  child: const Icon(Icons.arrow_back_ios_new_sharp)),
            ),
            body: SafeArea(
                child: state is HomeLoading
                    ? Center(
                        child: SizedBox(width: 130, child: myLoadingAnimation))
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: SizedBox(
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                width: double.infinity,
                                child: Center(
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      PageView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        controller: pageController,
                                        itemCount: myCubit
                                            .rightProducts[productIndex]
                                            .images!
                                            .length,
                                        itemBuilder: (context, index) {
                                          return Image(
                                              image: NetworkImage(myCubit
                                                  .rightProducts[productIndex]
                                                  .images![index]));
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: InkWell(
                                            onTap: () {
                                              myCubit.addToFavorite(
                                                  productId: myCubit
                                                      .rightProducts[productIndex].id);
                                                      print(myCubit.favoriteProducts[
                                                          myCubit
                                                              .rightProducts[
                                                                  productIndex]
                                                              .id]);
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              size: 35,
                                              color: myCubit.favoriteProducts[
                                                          myCubit
                                                              .rightProducts[
                                                                  productIndex]
                                                              .id] ==
                                                      true
                                                  ? Colors.red
                                                  : Colors.grey,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SmoothPageIndicator(
                                    effect: WormEffect(
                                        dotColor: Colors.purple.shade100),
                                    controller: pageController,
                                    count: myCubit.rightProducts[productIndex]
                                        .images!.length),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      myCubit.rightProducts[productIndex].name!,
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          '${myCubit.rightProducts[productIndex].price} EGP',
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: mySecondaryColor),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: MyElevatedButton(
                                              height: 40,
                                              width: 0.5,
                                              widget: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children:  [
                                                    const Icon(
                                                      Icons.shopping_cart,
                                                      size: 20,
                                                    ),
                                                    Text(
                                                      myCubit.cartProducts[myCubit.rightProducts[productIndex].id]==true ? 'Remove' :'Add to cart',
                                                      style: const TextStyle(
                                                          fontSize: 20),
                                                    )
                                                  ]),
                                              function: () {
                                                myCubit.addToCart(myCubit.rightProducts[productIndex].id);
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 5, 30, 20),
                                child: Divider(
                                  thickness: 2,
                                  color: Colors.purple.shade100,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Description',
                                  style: TextStyle(
                                      fontSize: 25, color: mySecondaryColor),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  myCubit
                                      .rightProducts[productIndex].description!,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
          );
        },
      ),
    );
  }
}
