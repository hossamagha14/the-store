import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/introPageModel.dart';
import 'introstates.dart';

class IntroCubit extends Cubit<IntroStates> {
  IntroCubit() : super(IntroIntialState());

  static IntroCubit get(context) => BlocProvider.of(context);
  bool isLast = false;
  bool finishIntro = false;
  List<IntroModel> intromodel = [
    IntroModel(
        image: 'assets/images/people-shopping-composition.png',
        text: 'Everything you want in one application'),
    IntroModel(
        image: 'assets/images/flower-vase-handbag-and-shoe.png',
        text: 'Shopping has never been easier'),
    IntroModel(
        image: 'assets/images/girl-with-umbrella.png',
        text: 'zero delivery fees, zero tax for the best experience'),
  ];

  navigateToLogin(int index) {
    if (index == intromodel.length - 1) {
      isLast = true;
      emit(IntroLastPage());
    } else if (index != intromodel.length - 1) {
      isLast = false;

      emit(IntroNotLastPage());
    }
    emit(IntroIntialState());
  }

 
}
