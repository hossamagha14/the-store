import 'package:bloc/bloc.dart';
import 'package:the_store/view_model/bloc/profile/profileCubit.dart';

abstract class ProfileStates{}

class ProfileIntialState extends ProfileStates{}

class ProfileSuccessfullState extends ProfileStates{}

class ProfileFailedState extends ProfileStates{}

class ProfileLoadingState extends ProfileStates{}

class LogOutSuccessfullState extends ProfileStates{}

class LogOutFailedState extends ProfileStates{}

class LogOutLoadingState extends ProfileStates{}

class UpdateSuccessfullState extends ProfileStates{}

class UpdateFailedState extends ProfileStates{}

class ChangePasswordSuccessfullState extends ProfileStates{}

class ChangePasswordFailedState extends ProfileStates{}

class ChangePasswordloadingState extends ProfileStates{}