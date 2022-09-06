import 'package:ecommerce_app/modules/login/cubit/login_cubit.dart';
import 'package:ecommerce_app/modules/login/cubit/login_states.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                      SizedBox(
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
                      SizedBox(
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
                              return 'please enter the email';
                            }
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      state is !LoginLoadingState? defaultButton(
                          text: 'login',
                          onPressed: () {

                            if (keyForm.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          }):Center(child: CircularProgressIndicator()),
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
