import 'package:ecommerce_app/modules/register/register_cubit/register_cubit.dart';
import 'package:ecommerce_app/modules/register/register_cubit/register_states.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/home_screen.dart';
import '../../shared/network/local/cache_helper.dart';

class RegisterScreeen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is RegisterSuccessState)
            {
              print("the status in the registerSuccessState ${state.model!.status}");
              if(state.model!.status)
                {
                  print('befor the sharedpreferance');
                  CacheHelper.setData(
                      key: 'token', value: state.model?.data!.token)
                      .then((value) {
                    showToast(
                        message: 'the Register is success', color: ToastState.SUCESS);

                    navigateAndFinish(context: context, widget: HomeScreen());
                  });
                }else {
                showToast(
                    message: state.model?.message??'', color: ToastState.EROERR);
              }
            }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'REGISTER',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Register now to browse our hot offers',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultTextFromField(
                          label: 'Name',
                          prefixIcon: Icons.person,
                          controller: nameController,
                          textInputType: TextInputType.name,
                          validatorMethod: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the name';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultTextFromField(
                          label: 'Email Address',
                          prefixIcon: Icons.email,
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          validatorMethod: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the email';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultTextFromField(
                          label: 'Password',
                          obscure: cubit.isObscure,
                          prefixIcon: Icons.lock,
                          suffixIcon: cubit.icon,
                          controller: passwordController,
                          suffixOnpressed: () {
                            cubit.changePasswordVisibility();
                          },
                          textInputType: TextInputType.visiblePassword,
                          validatorMethod: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the password';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20.0,
                      ),
                     state is! RegisterLoadingState ? defaultTextFromField(
                          label: 'Phone',
                          prefixIcon: Icons.phone_android,
                          controller: phoneController,
                          textInputType: TextInputType.phone,
                          validatorMethod: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the phone';
                            }
                            return null;
                          }):const CircularProgressIndicator(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                          text: 'Register',
                          onPressed: () {
                            print(nameController.text);
                            print(emailController.text);
                            print(passwordController.text);
                            print(phoneController.text);

                            if (keyForm.currentState!.validate()) {
                              cubit.userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text);
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
