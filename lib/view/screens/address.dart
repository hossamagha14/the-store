import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_store/view/reusable/myStyle.dart';
import 'package:the_store/view/reusable/myTextFormField.dart';
import 'package:the_store/view/screens/bottomNavBarScreen.dart';
import 'package:the_store/view/screens/cart.dart';
import 'package:the_store/view/screens/checkOut.dart';
import 'package:the_store/view_model/bloc/Home/homeCubit.dart';
import 'package:the_store/view_model/bloc/Home/homeStates.dart';

import '../reusable/myElevatedButton.dart';

class AddAddressScreen extends StatefulWidget {
  AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  var nameControl = TextEditingController();

  var cityControl = TextEditingController();

  var regionControl = TextEditingController();

  var detailsControl = TextEditingController();

  var notesControl = TextEditingController();

  double height = 0;

  double width = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAllAddresses(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit myCubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Choose a shipping address'),
              centerTitle: true,
            ),
            body: myCubit.getAllAddressesModel == null
                ? myLoadingAnimation
                : SafeArea(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                           myCubit.getAllAddressesModel!.data!.adressesData!.isEmpty ? const SizedBox(height: 10,width: 0,) :Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              child: Text(
                                                '${myCubit.getAllAddressesModel!.data!.adressesData![index].details}, ${myCubit.getAllAddressesModel!.data!.adressesData![index].region}, ${myCubit.getAllAddressesModel!.data!.adressesData![index].city}, ${myCubit.getAllAddressesModel!.data!.adressesData![index].notes}',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward_ios,
                                                color: mySecondaryColor)
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CheckOutScreen(
                                                      addressIndex: index),
                                            ));
                                      },
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Divider(
                                        thickness: 2,
                                      ),
                                    ),
                                itemCount: myCubit.getAllAddressesModel!.data!.adressesData!.length),
                          ),
                          Center(
                            child: MyElevatedButton(
                                height: 50,
                                width: 0.8,
                                widget: const Text(
                                  'Add New Address',
                                  style: TextStyle(fontSize: 25),
                                ),
                                function: () {
                                  if (width == 0 && height == 0) {
                                    width = MediaQuery.of(context).size.width;
                                    height = 600;
                                  } else if (width != 0 && height != 0) {
                                    width = 0;
                                    height = 0;
                                  }
                                  setState(() {});
                                }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 1),
                            height: height,
                            width: width,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: MyTextFormField(
                                      control: nameControl,
                                      keyboardType: TextInputType.name,
                                      secure: false,
                                      label: 'Work or Home',
                                      preIcon: Icons.home),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: MyTextFormField(
                                      control: cityControl,
                                      keyboardType: TextInputType.name,
                                      secure: false,
                                      label: 'City',
                                      preIcon: Icons.location_city),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: MyTextFormField(
                                      control: regionControl,
                                      keyboardType: TextInputType.name,
                                      secure: false,
                                      label: 'Region',
                                      preIcon: Icons.stream),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: MyTextFormField(
                                      control: detailsControl,
                                      keyboardType: TextInputType.name,
                                      secure: false,
                                      label: 'Address details',
                                      preIcon: Icons.add_home),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: MyTextFormField(
                                      control: notesControl,
                                      keyboardType: TextInputType.name,
                                      secure: false,
                                      label: 'Notes',
                                      preIcon: Icons.note),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 10),
                                  child: Center(
                                      child: MyElevatedButton(
                                          height: 50,
                                          width: 0.7,
                                          widget: const Text(
                                            'Add your address',
                                            style: TextStyle(fontSize: 25),
                                          ),
                                          function: () {
                                            myCubit.addAddress(
                                                name: nameControl.text,
                                                city: cityControl.text,
                                                region: regionControl.text,
                                                details: detailsControl.text,
                                                notes: notesControl.text);
                                            if (myCubit.getAllAddressesModel!
                                                    .status ==
                                                true) {
                                              height = 0;
                                              width = 0;
                                              setState(() {});
                                            }
                                          })),
                                ),
                              ],
                            ),
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
