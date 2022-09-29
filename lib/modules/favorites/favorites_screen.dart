import 'package:ecommerce_app/layout/home_cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/home_cubit/home_cubit.dart';
import '../../models/favorites_model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = HomeCubit.get(context).favoritesModel.data;
        // print(model.data[0].product.toString());

        return state is EcommerceAppLoadingGetFavoriteState
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                body: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildProductItem(model.data[index].product, context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: model.data.length),
              );
      },
    );
  }


}
