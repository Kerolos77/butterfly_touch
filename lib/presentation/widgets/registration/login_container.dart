import 'package:butterfly_touch/presentation/widgets/registration/registration_button.dart';
import 'package:butterfly_touch/presentation/widgets/registration/registration_text_field.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget loginContainer({
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required GestureTapCallback onTap,
  required Key formKey,
  required BuildContext context,
  required bool flag,
}) {
  return Form(
    key: formKey,
    child: SizedBox(
      child: Column(
        children: [
          registrationTextField(
            control: emailController,
            text: 'E-mail',
            type: TextInputType.emailAddress,
            validate: (value) {
              if (value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height / 30,
          ),
          registrationTextField(
              control: passwordController,
              text: 'Password',
              type: TextInputType.emailAddress,
              obscure: true,
              validate: (value) {
                if (value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              }),
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height / 30,
          ),
          ConditionalBuilder(
            condition: (!flag),
            builder: (BuildContext context) =>
                registrationButton(
                    context: context, text: "Login", onTap: onTap),
            fallback: (BuildContext context) =>
            const Center(
              child: CircularProgressIndicator(),
            ),
          ),

        ],
      ),
    ),
  );
}
