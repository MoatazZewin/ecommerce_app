import 'package:ecommerce_app/modules/login/cubit/login_cubit.dart';
import 'package:ecommerce_app/modules/login/cubit/login_states.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/home_screen.dart';
import '../../shared/components/constants.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSucessState) {
            print('state login ${state.loginModel.status}');
            if (state.loginModel.status) {
              print('message if is true ${state.loginModel.message}');
              CacheHelper.setData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                navigateAndFinish(context: context, widget: HomeScreen());
              });
            } else {
              showToast(
                  message: state.loginModel.message, color: ToastState.EROERR);
            }
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Login to browse our hot offers',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultTextFromField(
                          label: "Email Address",
                          prefixIcon: Icons.email_outlined,
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          validatorMethod: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the email';
                            }
                          }),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultTextFromField(
                          functionOnFieldSubmitted: (value) {
                            if (keyForm.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          label: "Password",
                          suffixOnpressed: () {
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                          prefixIcon: Icons.lock_outline,
                          controller: passwordController,
                          suffixIcon: LoginCubit.get(context).suffix,
                          textInputType: TextInputType.visiblePassword,
                          obscure: LoginCubit.get(context).isScure,
                          validatorMethod: (value) {
                            if (value!.isEmpty) {
                              return 'the password is too short';
                            }
                          }),
                      const SizedBox(
                        height: 20.0,
                      ),
                      state is! LoginLoadingState
                          ? defaultButton(
                              text: 'login',
                              onPressed: () {
                                if (keyForm.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              })
                          : const Center(child: CircularProgressIndicator()),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\`t have an account?'),
                          const SizedBox(
                            width: 5.0,
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(
                                  context: context, widget: RegisterScreeen());
                            },
                            child: const Text(
                              'REGISTER',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
