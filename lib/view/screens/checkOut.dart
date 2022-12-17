import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_store/view/reusable/myElevatedButton.dart';
import 'package:the_store/view/reusable/myStyle.dart';
import 'package:the_store/view/screens/orderSuccessful.dart';
import 'package:the_store/view_model/bloc/Home/homeCubit.dart';
import 'package:the_store/view_model/bloc/Home/homeStates.dart';

class CheckOutScreen extends StatelessWidget {
  final int addressIndex;
  const CheckOutScreen({Key? key, required this.addressIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getAllAddresses()
        ..getCart(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit myCubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Check out'),
            ),
            body: myCubit.getAllAddressesModel == null ||
                    myCubit.getCartModel == null
                ? myLoadingAnimation
                : SafeArea(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Order Summary',
                              style: TextStyle(fontSize: 30, color: myMainColor)),
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                        width: 50,
                                        height: 50,
                                        image: NetworkImage(myCubit
                                            .getCartModel!
                                            .data!
                                            .cartItems![index]
                                            .product!
                                            .image!)),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                     
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.6,
                                          child: Text(
                                            myCubit.getCartModel!.data!
                                                .cartItems![index].product!.name!,
                                            maxLines: 1,
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        Text('${myCubit.getCartModel!.data!
                                            .cartItems![index].product!.price} EGP',style: TextStyle(color: mySecondaryColor,fontSize: 15),)
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Divider(
                                    thickness: 2,
                                  ),
                                ),
                            itemCount:
                                myCubit.getCartModel!.data!.cartItems!.length),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10,30,0,0),
                              child: Text('Address',style: TextStyle(color: myMainColor,fontSize: 30,),),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  '${myCubit.getAllAddressesModel!.data!.adressesData![addressIndex].details}, ${myCubit.getAllAddressesModel!.data!.adressesData![addressIndex].region}, ${myCubit.getAllAddressesModel!.data!.adressesData![addressIndex].city}, ${myCubit.getAllAddressesModel!.data!.adressesData![addressIndex].notes}',
                                  maxLines: 3,
                                  style: const TextStyle(fontSize: 20),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 30, 20, 10),
                          child: Text('Payment Summary',
                              style:
                                  TextStyle(color: myMainColor, fontSize: 30)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total',
                                  style: TextStyle(
                                      color: myMainColor, fontSize: 30)),
                              Text(
                                  '${myCubit.getCartModel!.data!.subTotal} EGP',
                                  style: TextStyle(
                                      color: Colors.purple.shade400,
                                      fontSize: 26)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: MyElevatedButton(
                                height: 50,
                                width: 0.6,
                                widget: const Text(
                                  'Order now',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                function: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderSuccessfulScreen(),));
                                }),
                          ),
                        )
                      ],
                    ),
                  )),
          );
        },
      ),
    );
  }
}
