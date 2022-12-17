import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_store/view/screens/cart.dart';
import 'package:the_store/view/screens/favorites.dart';
import 'package:the_store/view/screens/homePage.dart';
import 'package:the_store/view/screens/login.dart';
import 'package:the_store/view/screens/profile.dart';
import 'package:the_store/view_model/bloc/Home/homeStates.dart';
import 'package:the_store/view_model/database/network/cache_helpher.dart';
import 'package:the_store/view_model/database/network/dio_helper.dart';
import 'package:the_store/view_model/database/network/end_points.dart';
import 'package:the_store/view_model/models/addFavoriteModel.dart';
import 'package:the_store/view_model/models/cartModel.dart';
import 'package:the_store/view_model/models/categoriesModel.dart';
import 'package:the_store/view_model/models/getAddressModel.dart';
import 'package:the_store/view_model/models/getCartModel.dart';
import 'package:the_store/view_model/models/getFavoriteModel.dart';
import 'package:the_store/view_model/models/homeModel.dart';
import 'package:the_store/view_model/models/newAddressModel.dart';

import '../../models/searchModel.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeIntialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  HomeModel? homeModel;
  bool isFavorite = false;
  int currentIndex = 0;

  List<Products> rightProducts = [];
  List<Products> leftProducts = [];
  Map<dynamic, bool> favoriteProducts = {};
  Map<dynamic, bool> cartProducts = {};
  AddfavoriteModel? addfavoriteModel;
  GetfavoriteModel? getfavoriteModel;
  CategoriesModel? categoriesModel;
  GetCartModel? getCartModel;
  NewAddressModel? newAddressModel;
  SearchModel ? searchModel;
  GetAllAddressesModel? getAllAddressesModel;
  CartModel? cartModel;
  List<Widget> Screens = [
    HomePage(),
    const FavoriteScreen(),
    CartScreen(),
     ProfileScreen()
  ];

  getHomeData() {
    emit(HomeLoading());
    DioHelper.getData(url: homeEndPoint, token: token).then((value) {
      if (value.statusCode == 200) {
        homeModel = HomeModel.fromJson(value.data);

        for (var element in homeModel!.data!.products!) {
          favoriteProducts.addAll({element.id: element.inFavorites!});
          cartProducts.addAll({element.id: element.inCart!});
        }
        print(cartProducts);
        for (int i = 0; i < homeModel!.data!.products!.length; i++) {
          if (i.isEven || i == 0) {
            rightProducts.add(homeModel!.data!.products![i]);
          } else {
            leftProducts.add(homeModel!.data!.products![i]);
          }
        }
      }
      emit(HomeSuccessful());
    }).catchError((onError) {
      print(onError.toString());
      emit(HomeFail());
    });
  }

  bottomNavBarScroll(index) {
    currentIndex = index;
    emit(BottomNavBarScrollState());
  }

  signOut(context, {required String key}) async {
    await CacheHelper.clearToken(key: key);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LogInScreen()));
  }

  addToFavorite({required int productId}) {
    emit(FavoritesLoadingState());
    favoriteProducts[productId] = !favoriteProducts[productId]!;
    DioHelper.postData(
            url: favoritesEndPoint,
            data: {"product_id": productId},
            token: token)
        .then((value) {
      addfavoriteModel = AddfavoriteModel.fromJson(value.data);
      print(value.data);
      if (value.statusCode == 200) {
        if (addfavoriteModel!.status! == false) {
          favoriteProducts[productId] = !favoriteProducts[productId]!;
          emit(FavoritesFailedState());
        } else {
          getAllFavorite();
          emit(FavoritesSuccessfulState());
        }
      } else {
        favoriteProducts[productId] = !favoriteProducts[productId]!;
        emit(FavoritesFailedState());
      }
    }).catchError((onError) {
      print(onError.toString());
      favoriteProducts[productId] = !favoriteProducts[productId]!;
      emit(FavoritesFailedState());
    });
  }

  getAllFavorite() {
    emit(GetFavoritesLoadingState());
    DioHelper.getData(url: favoritesEndPoint, token: token).then((value) {
      getfavoriteModel = GetfavoriteModel.fromJson(value.data);
      emit(GetFavoritesSuccessfulState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetFavoritesFailedState());
    });
  }

  getCategoryData() {
    emit(HomeLoading());
    DioHelper.getData(url: categoriesEndPoint, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(CategoriesSuccessfulState());
    }).catchError((onError) {
      emit(CategoriesFailedState());
      print(onError.toString());
    });
  }

  addToCart(int productId) {
    cartProducts[productId] = !cartProducts[productId]!;
    DioHelper.postData(
        url: cartEndPoint,
        token: token,
        data: {'product_id': productId}).then((value) {
      if (value.statusCode == 200) {
        cartModel = CartModel.fromJson(value.data);
        if (cartModel!.status == false) {
          cartProducts[productId] = !cartProducts[productId]!;
          emit(CartFailedState());
        } else {
          getCart();
          print(value.data);
          emit(CartSuccessfulState());
        }
      } else {
        cartProducts[productId] = !cartProducts[productId]!;
        emit(CartFailedState());
      }
    }).catchError((onError) {
      print(onError.toString());
      cartProducts[productId] = !cartProducts[productId]!;
      emit(CartFailedState());
    });
  }

  addOne(int i) {
    i++;
    emit(AddState());
  }

  minusOne(int i) {
    i--;
    emit(MinusState());
  }

  getCart() {
    DioHelper.getData(url: cartEndPoint, token: token).then((value) {
      getCartModel = GetCartModel.fromJson(value.data);
      emit(GetCartSuccessfulState());
    }).catchError((onError) {
      emit(GetCartFailedState());
      print(onError.toString());
    });
  }

  addAddress(
      {required String name,
      required String city,
      required String region,
      required String details,
      required String notes}) {
    DioHelper.postData(
            url: addressEndPoint,
            data: {
              'name': name,
              'city': city,
              'region': region,
              'details': details,
              'latitude': 30.30,
              'longitude': 30.30,
              'notes': notes
            },
            token: token)
        .then((value) {
      newAddressModel = NewAddressModel.fromJson(value.data);
      if (value.statusCode == 200) {
        if(newAddressModel!.status == true){getAllAddresses();
        emit(AddAddressSuccessfulState());}
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(AddAddressFailedState());
    });
  }

  getAllAddresses() {
    DioHelper.getData(url: addressEndPoint, token: token).then((value) {
      getAllAddressesModel = GetAllAddressesModel.fromJson(value.data);
      emit(GetAddressSuccessfulState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetAddressFailedState());
    });
  }

  search({
    required String product
  }){
    emit(SearchLoadingState());
    DioHelper.postData(url: searchEndPoint, data: {'text':product},token: token).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(value.data);
      if(value.statusCode==200){
        if(searchModel!.status == true){
          emit(SearchSuccessState());
        }else{
          emit(SearchFailState());
        }
      }else{
        emit(SearchFailState());
      }
    }).catchError((onError){
      print(onError.toString());
      emit(SearchFailState());
    });
  }
}
