import 'package:ecommerce_app/models/search_model.dart';
import 'package:ecommerce_app/modules/search/search_cubit/search_states.dart';
import 'package:ecommerce_app/shared/components/constants.dart';
import 'package:ecommerce_app/shared/network/end_points.dart';
import 'package:ecommerce_app/shared/network/remote/dio/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

   SearchModel? searchModel;

  void getSearch(String name) {
    emit(SearchLoadingState());
    DioHelper.Post(path: search, token: token, data: {
      'text': name,
    }).then((value) {
      searchModel = SearchModel.formJson(value.data);
      emit(SearchSuccessState());

    }).catchError((onError){
      print(onError.toString());
      emit(SearchErrorState());
    });
  }
}
