import 'package:ecommerce_app/layout/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/layout/home_cubit/home_states.dart';
import 'package:ecommerce_app/modules/search/search_screen.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeLayoutStates>(
         listener: (context,state){
         },
      builder: (context,state){
           var cubit = HomeCubit.get(context);
           return Scaffold(
             appBar: AppBar(
               title: Text(
                   'Home',
                 style: TextStyle(
                   fontSize: 20.0,
                   color: Colors.black,
                 ),
               ),
               actions: [
                 IconButton(onPressed: (){
                   navigateTo(context: context, widget: SearchScreen());

           }, icon: Icon(Icons.search,)),
               ],
             ),
             body: cubit.bottomScreens[cubit.currentIndex] ,
             bottomNavigationBar: BottomNavigationBar(

               onTap: (index){
                 cubit.changeBottomIndex(index);
               },
               currentIndex: cubit.currentIndex,

               items: [
                 BottomNavigationBarItem(icon: Icon(Icons.home),
                     label: 'Home'),
                 BottomNavigationBarItem(icon: Icon(Icons.apps),
                     label: 'Categories'),
                 BottomNavigationBarItem(icon: Icon(Icons.favorite),
                     label: 'Favorite'),
                 BottomNavigationBarItem(icon: Icon(Icons.settings),
                     label: 'Settings'),

               ],
             ),
           );
      }
    );
  }
}
