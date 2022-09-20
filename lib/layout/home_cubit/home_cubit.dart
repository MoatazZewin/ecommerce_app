import 'package:ecommerce_app/layout/home_cubit/home_states.dart';
import 'package:ecommerce_app/models/home_model.dart';
import 'package:ecommerce_app/modules/favorites/favorites_screen.dart';
import 'package:ecommerce_app/modules/products/products_screen.dart';
import 'package:ecommerce_app/modules/setting/setting_screen.dart';
import 'package:ecommerce_app/shared/network/end_points.dart';
import 'package:ecommerce_app/shared/network/remote/dio/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/categories_model.dart';
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

  void getHomeData() {
    emit(EcommerceAppLoadingHomeDataState());
    print(token);
    DioHelper.get(
      path: HOME,
      token: token,
    ).then((value) {
      print("inised then");
      homeModel = HomeModel.formJson(value.data);
      print(homeModel.toString());
      emit(EcommerceAppSuccessHomeDataState());
    }).catchError((onError) {
      print(onError.toString());
      emit(EcommerceAppErrorHomeDataState());
    });
  }
  
  void getCategoriesData()
  {
    DioHelper.get(path: CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(EcommerceAppSuccessCategoriesState());
    } ).catchError((onError){
      print(onError.toString());
      emit(EcommerceAppErrorCategoriesState());
    });
  }
}
