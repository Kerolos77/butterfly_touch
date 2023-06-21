import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../business_logic/cubit/users/user/UserCubit.dart';
import '../../../../business_logic/cubit/users/user/UserStates.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../widgets/global/default_text/default_text.dart';
import '../../../widgets/global/toast.dart';
import '../../regisation_screen.dart';

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
            if (state is LogOutSuccessUserState) {

              showToast(
                message: 'Log out Successfully',
              );
              CacheHelper.removeData(key: "user");
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  Registration(),
                  ));
            }
      }, builder: (BuildContext context, UserStates state) {
        UserCubit userCube = UserCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(onPressed: (){
                userCube.logout();
              }, icon: const Icon(
                FontAwesomeIcons.signOutAlt,
                size: 20,
                color: Colors.green,
              ),)
            ],
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: defaultText(text: 'USER ', color: Colors.black),
          ),
        );
      }),
    );
  }
}
