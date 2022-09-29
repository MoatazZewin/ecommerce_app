import 'package:ecommerce_app/layout/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/layout/home_cubit/home_states.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
   SettingScreen({Key? key}) : super(key: key);
  final  nameController = TextEditingController();
  final  emailController = TextEditingController();
  final  phoneController = TextEditingController();
  var keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeLayoutStates>(
      listener: (context, states){},
      builder: (context, states){
        var model = HomeCubit.get(context).loginModel!.data;
        nameController.text = model!.name;
        emailController.text = model.email;
        phoneController.text = model.phone;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: keyForm,
              child: Column(
                children: [
                  if(states is EcommerceAppLoadingUpdateUserState)
                  const LinearProgressIndicator(),
                  const SizedBox(height: 20.0,),
                  defaultTextFromField(
                      label: 'Name',
                      prefixIcon: Icons.person,
                      controller: nameController,
                      textInputType: TextInputType.name,
                      validatorMethod: ( value)
                      {
                        if(value!.isEmpty) {
                          return 'please enter the name';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20.0,
                  ),

                  defaultTextFromField(
                      label: 'Email address',
                      prefixIcon: Icons.email,
                      controller: emailController,
                      textInputType: TextInputType.name,
                      validatorMethod: ( value)
                      {
                        if(value!.isEmpty) {
                          return 'please enter the email';
                        }
                        return null;
                      }),

                  const SizedBox(
                    height: 20.0,
                  ),

                  defaultTextFromField(
                      label: 'Phone',
                      prefixIcon: Icons.phone,
                      controller: phoneController,
                      textInputType: TextInputType.name,
                      validatorMethod: ( value)
                      {
                        if(value!.isEmpty) {
                          return 'please enter the phone';
                        }
                        return null;
                      }),

                  const SizedBox(
                    height: 20.0,
                  ),

                  defaultButton(text: 'Logout',
                      onPressed: ()
                      {
                        signOut(context);

                      }),

                  const SizedBox(
                    height: 20.0,
                  ),

                  defaultButton(text: 'update',
                      onPressed: ()
                      {
                        if(keyForm.currentState!.validate())
                          {
                            HomeCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          }


                      }),

                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
