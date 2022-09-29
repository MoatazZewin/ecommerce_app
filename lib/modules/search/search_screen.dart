import 'package:ecommerce_app/modules/search/search_cubit/search_cubit.dart';
import 'package:ecommerce_app/modules/search/search_cubit/search_states.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit() ,
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state){},
        builder: (context, state){
          var cubit = SearchCubit.get(context).searchModel?.data;
          return  Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultTextFromField(
                      label: 'Search',
                      prefixIcon: Icons.search,
                      controller: searchController,
                      textInputType: TextInputType.text,
                      validatorMethod: (value){
                        if(value!.isEmpty)
                        {
                          return "please enter text";
                        }
                        return null;
                      },
                      functionOnFieldSubmitted: (value)
                      {
                        SearchCubit.get(context).getSearch(value);
                      }
                  ),
                  const SizedBox(height: 10.0,),
                  if(state is SearchLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 10.0,),
                  if(state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(itemBuilder: (context, index)=>buildProductItem(cubit?.data[index],context,isOldPrice: false),
                        separatorBuilder: (context, index)=>myDivider(),
                        itemCount: cubit?.data.length??2),
                  )
                ],
              ),
            ),
          );
        },

      ),
    );
  }
}
