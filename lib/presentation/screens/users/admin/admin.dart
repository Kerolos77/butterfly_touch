import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/cubit/users/admin/AdminCubit.dart';
import '../../../../business_logic/cubit/users/admin/AdminStates.dart';
import '../../../widgets/global/default_text/default_text.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AdminCubit(),
      child: BlocConsumer<AdminCubit, AdminStates>(
          listener: (BuildContext context, AdminStates state) {},
          builder: (BuildContext context, AdminStates state) {
            AdminCubit AdminCube = AdminCubit.get(context);

            return Scaffold(
              backgroundColor: Colors.white,

              body: SafeArea(
                child: RefreshIndicator(
                  onRefresh: () async {},
                  child: DoubleBackToCloseApp(
                    snackBar: SnackBar(
                      content: defaultText(text: 'Tap back again to leave'),
                    ),
                    child: Center(
                      child: defaultText(text: 'ADMIN', color: Colors.black),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
