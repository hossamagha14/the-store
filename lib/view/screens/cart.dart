import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_store/view/reusable/myElevatedButton.dart';
import 'package:the_store/view/reusable/myStyle.dart';
import 'package:the_store/view/reusable/myTextFormField.dart';
import 'package:the_store/view/screens/address.dart';
import 'package:the_store/view_model/bloc/Home/homeCubit.dart';
import 'package:the_store/view_model/bloc/Home/homeStates.dart';

class CartScreen extends StatelessWidget {
  TextEditingController promoCodeControl = TextEditingController();
  int? addressIndex;

  CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    addressIndex ??= 0;
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getHomeData()
        ..getCart()
        ..getAllAddresses(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          
          HomeCubit myCubit = HomeCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text('Cart'),
                centerTitle: true,
              ),
              body: myCubit.homeModel == null ||
                      myCubit.getCartModel == null ||
                      myCubit.getAllAddressesModel == null
                  ? myLoadingAnimation
                  : myCubit.getCartModel!.data!.cartItems!.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/images/3d-plastic-people-girl-in-shopping-cart.png'),
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'What are you waiting for',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: mySecondaryColor),
                                    ),
                                    Text(
                                      'go check our last offers ',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: mySecondaryColor),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      : SafeArea(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: myCubit
                                        .getCartModel!.data!.cartItems!.length,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 20,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image(
                                                  width: 100,
                                                  image: NetworkImage(myCubit
                                                      .getCartModel!
                                                      .data!
                                                      .cartItems![index]
                                                      .product!
                                                      .image!)),
                                              SizedBox(
                                                width: 200,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      myCubit
                                                          .getCartModel!
                                                          .data!
                                                          .cartItems![index]
                                                          .product!
                                                          .name!
                                                          .toString(),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 17),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(15),
                                                      child: Center(
                                                          child: Text(
                                                        'FREE DELIVERY ',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black45),
                                                      )),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          '${myCubit.getCartModel!.data!.cartItems![index].product!.price!} EGP',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            myCubit.addToCart(
                                                                myCubit
                                                                    .getCartModel!
                                                                    .data!
                                                                    .cartItems![
                                                                        index]
                                                                    .product!
                                                                    .id!);
                                                          },
                                                          child:
                                                              const CircleAvatar(
                                                            backgroundColor:
                                                                Colors.red,
                                                            child: Icon(
                                                              Icons.delete,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                               
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: MyTextFormField(
                                      control: promoCodeControl,
                                      keyboardType: TextInputType.name,
                                      secure: false,
                                      label: 'Entre Promo code',
                                      preIcon: Icons.percent),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 30, 20, 10),
                                  child: Text('Payment Summary',
                                      style: TextStyle(
                                          color: myMainColor, fontSize: 30)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Basket total',
                                          style: TextStyle(
                                              color: Colors.purple.shade300,
                                              fontSize: 20)),
                                      Text(
                                          '${myCubit.getCartModel!.data!.subTotal} EGP',
                                          style: TextStyle(
                                              color: Colors.purple.shade300,
                                              fontSize: 20)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Delivery Fees',
                                          style: TextStyle(
                                              color: Colors.purple.shade300,
                                              fontSize: 20)),
                                      Text('0.00 EGP',
                                          style: TextStyle(
                                              color: Colors.purple.shade300,
                                              fontSize: 20)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 40),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total',
                                          style: TextStyle(
                                              color: myMainColor,
                                              fontSize: 30)),
                                      Text(
                                          '${myCubit.getCartModel!.data!.subTotal} EGP',
                                          style: TextStyle(
                                              color: Colors.purple.shade400,
                                              fontSize: 26)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,0,20),
                                  child: Center(
                                    child: MyElevatedButton(
                                        height: 50,
                                        width: 0.8,
                                        widget: const Text(
                                          'Choose your Address',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25),
                                        ),
                                        function: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddressScreen(),));
                                        }),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ));
        },
      ),
    );
  }
}
