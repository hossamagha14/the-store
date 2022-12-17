import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_store/view/screens/bottomNavBarScreen.dart';

import '../../../view/screens/homePage.dart';
import '../../database/network/cache_helpher.dart';
import '../../database/network/dio_helper.dart';
import '../../database/network/end_points.dart';
import '../../models/logModel.dart';
import 'log_States.dart';

class LogCubit extends Cubit<LogStates> {
  LogCubit() : super(LogIntialState());

  static LogCubit get(context) => BlocProvider.of(context);
  bool isPressed = true;
  LogModel? logModel;

  logIn(context, {required String email, required String password}) {
    emit(LogLoadingState());
    DioHelper.postData(
        url: loginEndPoint,
        data: {'email': email, 'password': password}).then((value) {
      logModel = LogModel.fromJson(value.data);
      if (value.statusCode == 200) {
        CacheHelper.saveData(
              key: 'token', value: logModel!.data!.token.toString());
        if (logModel!.message == "Login done successfully") {
          token= CacheHelper.getData(key: 'token');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  const BottomNavBarScreen(),
              ));
          
          
          emit(LogSuccessState());
        }
      }
    }).catchError((onError) {
      emit(LogFailState());
    });
  }

  showPassword() {
    isPressed = !isPressed;
    emit(ShowPasswordState());
  }
}
