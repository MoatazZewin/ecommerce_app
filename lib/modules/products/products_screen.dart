import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/layout/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/layout/home_cubit/home_states.dart';
import 'package:ecommerce_app/models/home_model.dart';
import 'package:ecommerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = HomeCubit.get(context).homeModel;
        return Scaffold(
          body: model != null
              ? productsBuilder(model)
              : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayInterval: Duration(seconds: 3),
                scrollDirection: Axis.horizontal,
                autoPlayCurve: Curves.fastOutSlowIn,
                viewportFraction: 1.0,
              ),
            ),
            Container(
              color: Colors.grey,
              child: GridView.count(
                shrinkWrap: true,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1 / 1.65,
                crossAxisCount: 2,
                children: List.generate(
                  model.data.products.length,
                  (index) => buildGridProduct(model.data.products[index]),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(ProductModel model) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                height: 200,
                width: double.infinity,

              ),
              if(model.discount != 0)Container(
                color: Colors.red,
                child: Text('DISCOUNT',
                  style: TextStyle(
                    fontSize: 8.0,
                    color: Colors.white
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text('${model.price.round()}',
                      style: TextStyle(
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    if(model.discount != 0)Text('${model.oldPrice}',
                      style: TextStyle(
                        color: Colors.grey,
                        decoration:  TextDecoration.lineThrough,
                      ),),
                    Spacer(),
                    IconButton(onPressed: (){},
                        icon: Icon(Icons.favorite),
                    padding: EdgeInsets.zero,),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
