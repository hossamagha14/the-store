abstract class HomeStates {}

class HomeIntialState extends HomeStates{}
class HomeSuccessful extends HomeStates{}
class HomeFail extends HomeStates{}
class HomeLoading extends HomeStates{}

class FavoriteState extends HomeStates{}
class BottomNavBarScrollState extends HomeStates{}

class FavoritesLoadingState extends HomeStates{}
class FavoritesSuccessfulState extends HomeStates{}
class FavoritesFailedState extends HomeStates{}

class GetFavoritesLoadingState extends HomeStates{}
class GetFavoritesSuccessfulState extends HomeStates{}
class GetFavoritesFailedState extends HomeStates{}
class GetFavoritesStillLoadingState extends HomeStates{}

class CategoriesSuccessfulState extends HomeStates{}
class CategoriesFailedState extends HomeStates{}
class CartSuccessfulState extends HomeStates{}
class CartFailedState extends HomeStates{}

class AddState extends HomeStates{}
class MinusState extends HomeStates{}

class GetCartSuccessfulState extends HomeStates{}
class GetCartFailedState extends HomeStates{}
class GetAddressSuccessfulState extends HomeStates{}
class GetAddressFailedState extends HomeStates{}

class AddAddressSuccessfulState extends HomeStates{}
class AddAddressFailedState extends HomeStates{}
class AnimatedContainerExpandState extends HomeStates{}
class AnimatedContainerShrinkState extends HomeStates{}

class SearchLoadingState extends HomeStates{}
class SearchSuccessState extends HomeStates{}
class SearchFailState extends HomeStates{}

