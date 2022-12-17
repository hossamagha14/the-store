import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:the_store/view/reusable/myElevatedButton.dart';
import 'package:the_store/view/reusable/myStyle.dart';
import 'package:the_store/view/reusable/myTextFormField.dart';
import 'package:the_store/view/screens/leftProductDetails.dart';
import 'package:the_store/view/screens/rightProductDetails.dart';
import 'package:the_store/view_model/bloc/Home/homeCubit.dart';
import 'package:the_store/view_model/bloc/Home/homeStates.dart';
import 'package:the_store/view_model/models/categoriesModel.dart';
import 'package:the_store/view_model/models/homeModel.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchControl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var pageController = PageController();

  bool searching = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getHomeData()
        ..getCategoryData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is SearchLoadingState) {
            searching = true;
          }
        },
        builder: (context, state) {
          HomeCubit myCubit = HomeCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text('Home'),
              ),
              body: myCubit.homeModel == null || myCubit.categoriesModel == null
                  ? myLoadingAnimation
                  : SafeArea(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 20,
                                    color: Colors.grey.shade100,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                20)),
                                    child: Form(
                                      key: formKey,
                                      child: TextField(
                                        onSubmitted: (value) {
                                          searching = false;
                                          searchControl.text = '';
                                          setState(() {});
                                        },
                                        onChanged: (value) {
                                          myCubit.search(product: value);
                                        },
                                        controller: searchControl,
                                        cursorColor: myMainColor,
                                        decoration: InputDecoration(
                                          suffixIcon: InkWell(
                                              onTap: () {
                                                searching = false;
                                                searchControl.text = '';
                                                setState(() {});
                                              },
                                              child: const Icon(Icons.close,color: Colors.grey,)),
                                          iconColor: mySecondaryColor,
                                          border: InputBorder.none,
                                          hintText: 'Search',
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.search,
                                              color: myMainColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  searching == false
                                      ? const SizedBox(
                                          width: 0,
                                          height: 0,
                                        )
                                      : Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      bottom:
                                                          Radius.circular(20))),
                                          child: myCubit.searchModel == null
                                              ? myLoadingAnimation
                                              : ListView.separated(
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Divider(
                                                      thickness: 1,
                                                      color: myMainColor,
                                                    ),
                                                  ),
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  itemCount: myCubit
                                                      .searchModel!
                                                      .data!
                                                      .searchData!
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Image(
                                                            height: 80,
                                                            width: 80,
                                                            image: NetworkImage(
                                                                myCubit
                                                                    .searchModel!
                                                                    .data!
                                                                    .searchData![
                                                                        index]
                                                                    .image!)),
                                                        Column(
                                                          children: [
                                                            SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.5,
                                                                child: Text(
                                                                  myCubit
                                                                      .searchModel!
                                                                      .data!
                                                                      .searchData![
                                                                          index]
                                                                      .name!,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                )),
                                                            Text(
                                                              myCubit
                                                                  .searchModel!
                                                                  .data!
                                                                  .searchData![
                                                                      index]
                                                                  .price
                                                                  .toString(),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    );
                                                  },
                                                ),
                                        )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Our Hot Deals',
                                style:
                                    TextStyle(fontSize: 40, color: myMainColor),
                              ),
                            ),
                            Column(
                              children: [
                                Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Stack(
                                      alignment: Alignment.centerRight,
                                      children: [
                                        SizedBox(
                                          height: 250,
                                          child: PageView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            controller: pageController,
                                            itemCount: myCubit.homeModel!.data!
                                                .banners!.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: NetworkImage(
                                                            myCubit
                                                                .homeModel!
                                                                .data!
                                                                .banners![index]
                                                                .image!))),
                                              );
                                            },
                                          ),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              pageController.nextPage(
                                                  duration: const Duration(
                                                      microseconds: 500),
                                                  curve: Curves.fastOutSlowIn);
                                            },
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 35,
                                              color: mySecondaryColor,
                                            ))
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: InkWell(
                                          onTap: () {
                                            pageController.previousPage(
                                                duration: const Duration(
                                                    microseconds: 500),
                                                curve: Curves.fastOutSlowIn);
                                          },
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            size: 35,
                                            color: mySecondaryColor,
                                          )),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SmoothPageIndicator(
                                      effect: WormEffect(
                                          activeDotColor: mySecondaryColor,
                                          dotColor: Colors.orange.shade200),
                                      controller: pageController,
                                      count: myCubit
                                          .homeModel!.data!.banners!.length),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Categories',
                                style:
                                    TextStyle(fontSize: 40, color: myMainColor),
                              ),
                            ),
                            SizedBox(
                              height: 180,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: myCubit.categoriesModel!.data!
                                    .categoryData!.length,
                                itemBuilder: (context, index) {
                                  CategoryData category = myCubit
                                      .categoriesModel!
                                      .data!
                                      .categoryData![index];
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    category.image!)),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Container(
                                              width: 140,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  color: mySecondaryColor
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(20)),
                                              child: Center(
                                                  child: Text(category.name!)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'New Products',
                                style:
                                    TextStyle(fontSize: 40, color: myMainColor),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: myCubit.rightProducts.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            RightProductDetailsScreen(
                                                                productIndex:
                                                                    index),
                                                      ));
                                                },
                                                child: Card(
                                                  elevation: 30,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Image(
                                                            height: 130,
                                                            image: NetworkImage(
                                                                myCubit
                                                                    .rightProducts[
                                                                        index]
                                                                    .image!
                                                                    .toString()),
                                                            loadingBuilder:
                                                                (context, child,
                                                                    loadingProgress) {
                                                              if (loadingProgress ==
                                                                  null) {
                                                                return child;
                                                              }
                                                              return Center(
                                                                child: SizedBox(
                                                                    width: 130,
                                                                    child:
                                                                        myLoadingAnimation),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        Center(
                                                          child: Text(
                                                            myCubit
                                                                .rightProducts[
                                                                    index]
                                                                .name!
                                                                .toString(),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 17,
                                                              fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                        myCubit
                                                                    .rightProducts[
                                                                        index]
                                                                    .price ==
                                                                myCubit
                                                                    .rightProducts[
                                                                        index]
                                                                    .oldPrice
                                                            ? const SizedBox(
                                                                width: 0,
                                                                height: 37,
                                                              )
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                child: Text(
                                                                  '${myCubit.rightProducts[index].oldPrice!} EGP',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                    fontSize:
                                                                        17,
                                                                  ),
                                                                ),
                                                              ),
                                                        Text(
                                                          '${myCubit.rightProducts[index].price!.toString()} EGP',
                                                          maxLines: 1,
                                                          
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style:
                                                              const TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              MyElevatedButton(
                                                                  height: 30,
                                                                  width: 1,
                                                                  widget: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        const Icon(
                                                                            Icons.add_shopping_cart),
                                                                        Text(
                                                                          myCubit.cartProducts[myCubit.rightProducts[index].id] == false
                                                                              ? 'Add to cart'
                                                                              : 'Remove',
                                                                          style:
                                                                              const TextStyle(fontSize: 15),
                                                                        )
                                                                      ]),
                                                                  function: () {
                                                                    myCubit.addToCart(myCubit
                                                                        .rightProducts[
                                                                            index]
                                                                        .id);
                                                                  }),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: InkWell(
                                                    onTap: () {
                                                      myCubit.addToFavorite(
                                                          productId: myCubit
                                                              .rightProducts[
                                                                  index]
                                                              .id);
                                                      print(myCubit
                                                          .rightProducts[index]
                                                          .id);
                                                    },
                                                    child: Icon(
                                                      Icons.favorite,
                                                      color: myCubit.favoriteProducts[
                                                                  myCubit
                                                                      .rightProducts[
                                                                          index]
                                                                      .id] ==
                                                              true
                                                          ? Colors.red
                                                          : Colors.grey,
                                                    )),
                                              ),
                                            ],
                                          ),
                                          myCubit.rightProducts[index].price ==
                                                  myCubit.rightProducts[index]
                                                      .oldPrice
                                              ? const SizedBox(
                                                  width: 0,
                                                  height: 0,
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Container(
                                                    width: 60,
                                                    height: 15,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color: Colors.red),
                                                    child: const Center(
                                                      child: Text(
                                                        'DISCOUNT',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            LeftProductDetailsScreen(
                                                                productIndex:
                                                                    index),
                                                      ));
                                                },
                                                child: Card(
                                                  elevation: 30,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Image(
                                                            height: 130,
                                                            image: NetworkImage(
                                                                myCubit
                                                                    .leftProducts[
                                                                        index]
                                                                    .image!
                                                                    .toString()),
                                                            loadingBuilder:
                                                                (context, child,
                                                                    loadingProgress) {
                                                              if (loadingProgress ==
                                                                  null) {
                                                                return child;
                                                              }
                                                              return Center(
                                                                child: SizedBox(
                                                                    height: 130,
                                                                    child:
                                                                        myLoadingAnimation),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        Center(
                                                          child: Text(
                                                            myCubit
                                                                .leftProducts[
                                                                    index]
                                                                .name!
                                                                .toString(),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 17,
                                                              fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                        myCubit
                                                                    .leftProducts[
                                                                        index]
                                                                    .price ==
                                                                myCubit
                                                                    .leftProducts[
                                                                        index]
                                                                    .oldPrice
                                                            ? const SizedBox(
                                                                width: 0,
                                                                height: 37,
                                                              )
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                child: Text(
                                                                  '${myCubit.leftProducts[index].oldPrice!.toString()} EGP',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  style:
                                                                      const TextStyle(
                                                                        
                                                                    color: Colors
                                                                        .black54,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                    fontSize:
                                                                        17,
                                                                  ),
                                                                ),
                                                              ),
                                                        Text(
                                                          '${myCubit.leftProducts[index].price!.toString()} EGP',
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style:
                                                              const TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              MyElevatedButton(
                                                                  height: 30,
                                                                  width: 1,
                                                                  widget: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        const Icon(
                                                                            Icons.add_shopping_cart),
                                                                        Text(
                                                                          myCubit.cartProducts[myCubit.leftProducts[index].id] == false
                                                                              ? 'Add to cart'
                                                                              : 'Remove',
                                                                          style:
                                                                              const TextStyle(fontSize: 15),
                                                                        )
                                                                      ]),
                                                                  function: () {
                                                                    myCubit.addToCart(myCubit
                                                                        .leftProducts[
                                                                            index]
                                                                        .id);
                                                                  }),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: InkWell(
                                                    onTap: () {
                                                      myCubit.addToFavorite(
                                                          productId: myCubit
                                                              .leftProducts[
                                                                  index]
                                                              .id);
                                                    },
                                                    child: Icon(
                                                      Icons.favorite,
                                                      color: myCubit.favoriteProducts[
                                                                  myCubit
                                                                      .leftProducts[
                                                                          index]
                                                                      .id] ==
                                                              true
                                                          ? Colors.red
                                                          : Colors.grey,
                                                    )),
                                              )
                                            ],
                                          ),
                                          myCubit.leftProducts[index].price ==
                                                  myCubit.leftProducts[index]
                                                      .oldPrice
                                              ? const SizedBox(
                                                  width: 0,
                                                  height: 0,
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Container(
                                                    width: 60,
                                                    height: 15,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color: Colors.red),
                                                    child: const Center(
                                                      child: Text(
                                                        'DISCOUNT',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ));
        },
      ),
    );
  }
}

 // SafeArea(
        //     child: SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       const Center(child: Text('HomePage')),
        //       ElevatedButton(onPressed: (){
        //         CacheHelper.clearToken(key: 'token').then((value) {
        //           if(value){
        //             Navigator.push(context, MaterialPageRoute(builder:(context) => LogInScreen(),));
        //           }
        //         });
        //       }, child: const Text('Sign Out'))
        //     ],
        //   ),
        // ),