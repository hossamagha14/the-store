import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:the_store/view_model/bloc/signup/sign_States.dart';

import '../../../view/screens/signUpSuccessful.dart';
import '../../database/network/dio_helper.dart';
import '../../database/network/end_points.dart';
import '../../models/signUpModel.dart';

class SignCubit extends Cubit<SignStates> {
  SignCubit() : super(SignIntialState());

  static SignCubit get(context) => BlocProvider.of(context);
  bool isPressed = true;
  SignUpModel? signUpModel;

  signUpFunction(context,
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    emit(SignLoadingState());
    DioHelper.postData(url: registerEndPoint, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone
    }).then((value) {
      print(value.data);
      signUpModel = SignUpModel.fromJson(value.data);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignUpSuccessfulScreen(),
          ));
      emit(SignSuccesfulState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SignFailState());
    });
  }

  showPassword() {
    isPressed = !isPressed;
    emit(ShowPasswordState());
  }
}
