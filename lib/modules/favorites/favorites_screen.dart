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
    return BlocConsumer<HomeCubit,HomeLayoutStates>(
        listener: (context, state) {},
        builder:(context, state) {
          var model = HomeCubit.get(context).favoritesModel.data;
          print(model.data[0].product.toString());

          return state is EcommerceAppLoadingGetFavoriteState?Center(child: CircularProgressIndicator()):Scaffold(
            body: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder:(context, index)=> buildFavoriteItem(model.data[index].product, context),
                separatorBuilder:(context, index)=>  myDivider(),
                itemCount: model.data.length) ,
          );
        },
        );
  }


  Widget buildFavoriteItem(Product? model , context)
  {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model?.image}'),
                  width: 120,
                  height: 120,
                ),
                if (model?.discount!= 0)
                  Container(
                    color: Colors.red,
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 8.0, color: Colors.white),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 20.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "'${model?.description}'",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model?.price}',
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      if (model?.discount!= 0)
                        Text(
                          '${model?.oldPrice}',
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                           HomeCubit.get(context).changeFavoritesDataModel(model!.id);
                        },
                        icon: Icon(Icons.favorite,
                        ),
                        color: HomeCubit.get(context).favorite[model?.id]!?Colors.red:Colors.grey,
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}