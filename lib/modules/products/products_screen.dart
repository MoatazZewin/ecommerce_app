import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/layout/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/layout/home_cubit/home_states.dart';
import 'package:ecommerce_app/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model  = HomeCubit.get(context).homeModel;
        return Scaffold(
          body: model != null ? productsBuilder(model):Center(child: CircularProgressIndicator())
            ,
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model) => Column(
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
        ],
      );
}
