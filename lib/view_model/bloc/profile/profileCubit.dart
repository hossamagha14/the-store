import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_store/view_model/models/changePasswordModel.dart';
import 'package:the_store/view_model/bloc/profile/profilestates.dart';
import 'package:the_store/view_model/database/network/dio_helper.dart';
import 'package:the_store/view_model/database/network/end_points.dart';
import 'package:the_store/view_model/models/profileModel.dart';
import 'package:the_store/view_model/models/updateProfileModel.dart';

import '../../models/logOutModel.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileIntialState());

  static ProfileCubit get(context) => BlocProvider.of(context);
  ProfileModel? profileModel;
  LogOutModel? logOutModel;
  UpdateProfileModel? updateProfileModel;
  ChangePasswordModel? changePasswordModel;

  getProfile() {
    emit(ProfileLoadingState());
    DioHelper.getData(url: profileEndPoint, token: token).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      print(value.data);
      if (value.statusCode == 200) {
        if (profileModel!.status == true) {
          emit(ProfileSuccessfullState());
        } else {
          emit(ProfileFailedState());
        }
      } else {
        emit(ProfileFailedState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(ProfileFailedState());
    });
  }

  logOut({required String token}) {
    DioHelper.postData(
            url: logoutEndPoint, data: {'token': token}, token: token)
        .then((value) {
      logOutModel = LogOutModel.fromJson(value.data);
      print(value.data);
      if (value.statusCode == 200) {
        if (logOutModel!.status == true) {
          emit(LogOutSuccessfullState());
        } else {
          emit(LogOutFailedState());
        }
      } else {
        emit(LogOutFailedState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(LogOutFailedState());
    });
  }

  updateProfile(
      {required String name, required String phone, required String email}) {
    DioHelper.putData(
            url: updateProfileEndPoint,
            data: {'name': name, 'phone': phone, 'email': email},
            token: token)
        .then((value) {
      updateProfileModel = UpdateProfileModel.fromJson(value.data);
      print(value.data);
      if (value.statusCode == 200) {
        if (updateProfileModel!.status == true) {
          emit(UpdateSuccessfullState());
        } else {
          emit(UpdateFailedState());
        }
      } else {
        emit(UpdateFailedState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateFailedState());
    });
  }

  changePassword({
    required String newpassword,
    required String currentpassword,
  }) {
    emit(ChangePasswordloadingState());
    DioHelper.postData(token: token, url: changepasswordEndPoint, data: {
      'current_password': currentpassword,
      'new_password': newpassword
    }).then((value) {
      changePasswordModel = ChangePasswordModel.fromJson(value.data);
      print(value.data);
      if (value.statusCode == 200) {
        if (changePasswordModel!.status == true) {
          emit(ChangePasswordSuccessfullState());
        } else {
          emit(ChangePasswordFailedState());
        }
      } else {
        emit(ChangePasswordFailedState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(ChangePasswordFailedState());
    });
  }
}
