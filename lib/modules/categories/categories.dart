import 'package:ecommerce_app/layout/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/layout/home_cubit/home_states.dart';
import 'package:ecommerce_app/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeLayoutStates>(
        builder: (context, state) {
          var model = HomeCubit.get(context).categoriesModel;
          return Scaffold(
            body: ListView.separated(
                itemBuilder: (context, index) =>
                    bulidCatItem(model!.data!.data[index]),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: model!.data!.data.length),
          );
        },
        listener: (context, state) {});
  }

  Widget bulidCatItem(DataModel model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage("${model.image}"),
            height: 100,
            width: 100,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            "${model.name}",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
