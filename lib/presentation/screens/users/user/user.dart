import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/cubit/users/user/UserCubit.dart';
import '../../../../business_logic/cubit/users/user/UserStates.dart';
import '../../../widgets/global/default_text/default_text.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late File imageFile = File('assets/images/Profile Image.png');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserStates>(
          listener: (BuildContext context, UserStates state) {
        print('-------------------------------------------------$state');
      }, builder: (BuildContext context, UserStates state) {
        UserCubit userCube = UserCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: defaultText(text: 'USER ', color: Colors.black),
          ),
        );
      }),
    );
  }
}
