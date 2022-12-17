import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:the_store/main.dart';
import 'package:the_store/view/reusable/myElevatedButton.dart';
import 'package:the_store/view/reusable/myStyle.dart';
import '../../view_model/bloc/Home/homeCubit.dart';
import '../../view_model/bloc/Home/homeStates.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorite'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: BlocProvider(
            create: (context) => HomeCubit()
              ..getHomeData()
              ..getAllFavorite()
              ..getCart(),
            child: BlocConsumer<HomeCubit, HomeStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  HomeCubit myCubit = HomeCubit.get(context);
                  return myCubit.homeModel == null ||
                          myCubit.getfavoriteModel == null
                      ? myLoadingAnimation
                      : myCubit.getfavoriteModel!.data!.favoriteData!.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left:65),
                                    child: Image(
                                        image: AssetImage(
                                            'assets/images/people-shopping-composition.png')),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                          'Go check our latest offers...',
                                          style: TextStyle(
                                              color: mySecondaryColor,
                                              fontSize: 24),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                          'for sure you will find',
                                          style: TextStyle(
                                              color: mySecondaryColor,
                                              fontSize: 24),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                          'something to add',
                                          style: TextStyle(
                                              color: mySecondaryColor,
                                              fontSize: 24),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          : SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Stack(
                                      alignment: Alignment.topLeft,
                                      children: [
                                        Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Card(
                                              elevation: 30,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Image(
                                                      height: 130,
                                                      image: NetworkImage(
                                                          myCubit
                                                              .getfavoriteModel!
                                                              .data!
                                                              .favoriteData![
                                                                  index]
                                                              .product!
                                                              .image!),
                                                      loadingBuilder: (context,
                                                          child,
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
                                                          .getfavoriteModel!
                                                          .data!
                                                          .favoriteData![index]
                                                          .product!
                                                          .name
                                                          .toString(),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                  ),
                                                  myCubit
                                                              .getfavoriteModel!
                                                              .data!
                                                              .favoriteData![
                                                                  index]
                                                              .product!
                                                              .price ==
                                                          myCubit
                                                              .getfavoriteModel!
                                                              .data!
                                                              .favoriteData![
                                                                  index]
                                                              .product!
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
                                                            '${myCubit.getfavoriteModel!.data!.favoriteData![index].product!.oldPrice!} EGP',
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
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        ),
                                                  Text(
                                                    "${myCubit.getfavoriteModel!.data!.favoriteData![index].product!.price} EGP",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    style: const TextStyle(
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: InkWell(
                                                  onTap: () {
                                                    myCubit.addToFavorite(
                                                        productId: myCubit
                                                            .getfavoriteModel!
                                                            .data!
                                                            .favoriteData![
                                                                index]
                                                            .product!
                                                            .id!);
                                                  },
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: myCubit.favoriteProducts[myCubit
                                                                .getfavoriteModel!
                                                                .data!
                                                                .favoriteData![
                                                                    index]
                                                                .product!
                                                                .id] ==
                                                            true
                                                        ? Colors.red
                                                        : Colors.grey,
                                                  )),
                                            )
                                          ],
                                        ),
                                        myCubit
                                                    .getfavoriteModel!
                                                    .data!
                                                    .favoriteData![index]
                                                    .product!
                                                    .price! ==
                                                myCubit
                                                    .getfavoriteModel!
                                                    .data!
                                                    .favoriteData![index]
                                                    .product!
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
                                                          BorderRadius.circular(
                                                              4),
                                                      color: Colors.red),
                                                  child: const Center(
                                                    child: Text(
                                                      'DISCOUNT',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              )
                                      ],
                                    ),
                                  );
                                },
                                itemCount: myCubit.getfavoriteModel!.data!
                                    .favoriteData!.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, mainAxisExtent: 300),
                              ),
                            );
                })));
  }
}
