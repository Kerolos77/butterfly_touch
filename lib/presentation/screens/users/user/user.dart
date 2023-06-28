import 'package:butterfly_touch/presentation/widgets/global/coupon_card/coupon_card.dart';
import 'package:butterfly_touch/presentation/widgets/global/default_text/default_text.dart';
import 'package:butterfly_touch/utiles/id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../business_logic/cubit/users/user/user_cubit.dart';
import '../../../../business_logic/cubit/users/user/user_states.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../widgets/global/toast.dart';
import '../../regisation_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
                builder: (context) => Registration(),
              ));
        }
      }, builder: (BuildContext context, UserStates state) {
        UserCubit userCube = UserCubit.get(context);
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  userCube.logout();
                },
                icon: const Icon(
                  FontAwesomeIcons.signOutAlt,
                  size: 20,
                  color: Colors.green,
                ),
              )
            ],
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Card(
                        elevation: 1,
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            SvgPicture.asset(
                              "assets/image/background_login_top.svg",
                              color: const Color.fromRGBO(
                                  26, 188, 0, 0.8274509803921568),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.06,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                CircleAvatar(
                                  backgroundColor:
                                      Color.fromRGBO(161, 222, 200, 0.7),
                                  radius: 70,
                                  child: defaultText(
                                    text: '50',
                                    color: Colors.white,
                                    size: 50.0,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                                defaultText(
                                    text: '${CacheHelper.getData(key: 'name')}',
                                    size: 15),
                                SizedBox(
                                  height: 5,
                                ),
                                defaultText(
                                    text:
                                        '${CacheHelper.getData(key: 'email')}',
                                    size: 15),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SvgPicture.asset(
                        "assets/image/background_login_bottom.svg",
                        color: const Color.fromRGBO(
                            26, 188, 0, 0.8274509803921568),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListView.separated(
                          itemBuilder: (context, index) => coupon(
                                couponId: CreateId.createId(),
                                endDate: DateFormat('yyyy-MM-dd').format(
                                    DateTime.now()
                                        .add(const Duration(days: 30))),
                                startDate: DateFormat('yyyy-MM-dd')
                                    .format(DateTime.now()),
                              ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemCount: 5),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
