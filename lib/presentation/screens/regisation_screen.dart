import 'package:butterfly_touch/presentation/screens/users/admin/admin_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/regidtration_cubit/registration_cubit.dart';
import '../../business_logic/cubit/regidtration_cubit/registration_states.dart';
import '../../data/local/cache_helper.dart';
import '../../presentation/screens/users/user/user_home.dart';
import '../widgets/global/logo.dart';
import '../widgets/global/toast.dart';
import '../widgets/registration/login_container.dart';
import '../widgets/registration/registration_background.dart';
import '../widgets/registration/registration_text.dart';
import '../widgets/registration/sign_up_container.dart';

class Registration extends StatelessWidget {
  Registration({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegistrationCubit(),
      child: BlocConsumer<RegistrationCubit, RegistrationState>(
        listener: (BuildContext context, RegistrationState state) {
          if (state is LoginLoadingRegistrationState ||
              state is SignUpLoadingRegistrationState) {
            flag = true;
          }
          if (state is LoginErrorRegistrationState) {
            flag = false;
            showToast(
              message: state.error,
            );
          }
          if (state is LoginSuccessRegistrationState) {
            if (emailController.text == 'admin@admin.com') {
              CacheHelper.putData(key: "user", value: 'admin').then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminScan(),
                    ));
              });
            } else {
              CacheHelper.putData(key: "user", value: state.uid).then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserHome(),
                    ));
              });
            }
            flag = false;
            showToast(
              message: "you are welcome",
            );
          }
          if (state is SignUpErrorRegistrationState) {
            flag = false;
            showToast(
              message: state.error,
            );
          }
          if (state is SignUpSuccessRegistrationState) {
            flag = false;
            showToast(
              message: "Sign up Successfully",
            );
          }
        },
        builder: (BuildContext context, RegistrationState state) {
          RegistrationCubit cub = RegistrationCubit.get(context);
          return SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                body: Stack(
                  children: [
                    registrationBackground(context: context),
                    Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 7,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: logo(size: 100),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        registrationText(
                                            text: 'Sign Up',
                                            isClick: !cub.registrationFlag,
                                            onTap: () {
                                              cub.changeRegistration(false);
                                            }),
                                        registrationText(
                                            text: 'Login',
                                            isClick: cub.registrationFlag,
                                            onTap: () {
                                              cub.changeRegistration(true);
                                            })
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                    ),
                                    Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.passthrough,
                                      children: [
                                        cub.registrationFlag
                                            ? loginContainer(
                                                flag: flag,
                                                formKey: formKey,
                                                onTap: () {
                                                  print(
                                                      '----------------------${formKey.currentState}');
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    cub.login(
                                                        email: emailController
                                                            .text,
                                                        password:
                                                            passwordController
                                                                .text,
                                                        buildContext: context);
                                                  }
                                                },
                                                context: context,
                                                emailController:
                                                    emailController,
                                                passwordController:
                                                    passwordController)
                                            : signUpContainer(
                                                formKey: formKey,
                                                flag: flag,
                                                onTap: () {
                                                  print(
                                                      '----------------------${formKey.currentState}');
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    cub.signUp(
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text,
                                                      firstName:
                                                          firstNameController
                                                              .text,
                                                      lastName:
                                                          lastNameController
                                                              .text,
                                                    );
                                                  }
                                                },
                                                context: context,
                                                emailController:
                                                    emailController,
                                                passwordController:
                                                    passwordController,
                                                confirmPasswordController:
                                                    confirmPasswordController,
                                                firstNameController:
                                                    firstNameController,
                                                lastNameController:
                                                    lastNameController,
                                              ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              40,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                )),
          );
        },
      ),
    );
  }
}
