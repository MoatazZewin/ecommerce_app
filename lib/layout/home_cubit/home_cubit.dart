import 'package:ecommerce_app/layout/home_cubit/home_states.dart';
import 'package:ecommerce_app/models/change_favorites_model.dart';
import 'package:ecommerce_app/models/home_model.dart';
import 'package:ecommerce_app/models/login_model.dart';
import 'package:ecommerce_app/modules/favorites/favorites_screen.dart';
import 'package:ecommerce_app/modules/products/products_screen.dart';
import 'package:ecommerce_app/modules/setting/setting_screen.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/network/end_points.dart';
import 'package:ecommerce_app/shared/network/remote/dio/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/categories_model.dart';
import '../../models/favorites_model.dart';
import '../../modules/categories/categories.dart';
import '../../shared/components/constants.dart';

class HomeCubit extends Cubit<HomeLayoutStates> {
  HomeCubit() : super(HomeLayoutInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  List bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];

  void changeBottomIndex(index) {
    currentIndex = index;
    emit(HomeLayoutBottomNavStateChange());
  }

  Map<int, bool?> favorite = {};

  void getHomeData() {
    emit(EcommerceAppLoadingHomeDataState());
    print(token);
    DioHelper.get(
      path: HOME,
      token: token,
    ).then((value) {
      print("inised then");
      homeModel = HomeModel.formJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorite.addAll({
          element.id: element.inFavorites,
        });
      });
      print(homeModel.toString());
      emit(EcommerceAppSuccessHomeDataState());
    }).catchError((onError) {
      print(onError.toString());
      emit(EcommerceAppErrorHomeDataState());
    });
  }

  void getCategoriesData() {
    DioHelper.get(path: CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(EcommerceAppSuccessCategoriesState());
    }).catchError((onError) {
      print(onError.toString());
      emit(EcommerceAppErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavoritesDataModel(int productId) {
    bool? hello = favorite[productId];
    favorite[productId] = !hello!;

    emit(EcommerceAppChangeFavorite());

    print('the id product is ${productId}');
    print('the token is ${token}');

    DioHelper.Post(
      path: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.formJson(value.data);
      print('the error is${changeFavoritesModel!.message}');
      print(value.data);
      if (!changeFavoritesModel!.status) {
        print('inside the if in changefavoritesdata');
        bool? hello = favorite[productId];
        favorite[productId] = !hello!;
        showToast(
            message: changeFavoritesModel!.message.toString(),
            color: ToastState.EROERR);
      } else {
        getFavorites();
      }
      emit(EcommerceAppSuccessChangeFavoriteState());
    }).catchError((onError) {
      print("the error is ${onError.toString()}");
      emit(EcommerceAppErrorChangeFavoriteState());
    });
  }

  late FavoritesModel favoritesModel;
  void getFavorites() {
    emit(EcommerceAppLoadingGetFavoriteState());

    DioHelper.get(path: FAVORITES, token: token).then((value) {
      print('insid the get favorites model');
      favoritesModel = FavoritesModel.formJson(value.data);
      print('inside the get favorites ${value.data}');
      emit(EcommerceAppSuccessGetFavoriteState());
    }).catchError((onError) {
      print("erorr inside the get favorite ${onError.toString()}");
      emit(EcommerceAppErrorGetFavoriteState());
    });
  }

  LoginModel? loginModel;
  void getUserData()
  {
    DioHelper.get(
      path: PROFILE,
      token: token,
    ).then((value) {
      print('inside the get getUserData ${value.data}');
      loginModel = LoginModel.fromJson(value.data);
      emit(EcommerceAppSuccessUserDataState());
    }).catchError((onError){

      print(onError.toString());
      emit(EcommerceAppErrorUserDataState());
    });

  }
}
