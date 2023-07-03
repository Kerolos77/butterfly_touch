import 'package:butterfly_touch/presentation/widgets/global/default_text/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../business_logic/cubit/users/user/user_cubit.dart';
import '../../../../business_logic/cubit/users/user/user_states.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../widgets/global/coupon_card/coupon_card.dart';
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
        create: (BuildContext context) => UserCubit()
          ..getUserData()
          ..getCoupons(),
        child: BlocConsumer<UserCubit, UserStates>(
          listener: (BuildContext context, UserStates state) {
            if (state is GetUserErrorState) {
              showToast(
                message: state.error,
              );
            }
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
          },
          builder: (BuildContext context, UserStates state) {
            UserCubit userCube = UserCubit.get(context);

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
                child: RefreshIndicator(
                  onRefresh: () async {
                    userCube.getUserData();
                    userCube.getCoupons();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Card(
                                elevation: 0,
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.06,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: const Color.fromRGBO(
                                              161, 222, 200, 0.7),
                                          radius: 70,
                                          child: userCube.user != null
                                              ? defaultText(
                                                  text:
                                                      '${userCube.user?['score']}',
                                                  color: Colors.white,
                                                  size: 50.0,
                                                )
                                              : const CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.06,
                                        ),
                                        defaultText(
                                            text:
                                                '${CacheHelper.getData(key: 'name')}',
                                            size: 15),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        defaultText(
                                            text:
                                                '${CacheHelper.getData(key: 'email')}',
                                            size: 15),
                                        const SizedBox(
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
                            child: userCube.couponData.isNotEmpty
                                ? ListView.separated(
                                    itemBuilder: (context, index) => coupon(
                                      couponId: userCube.couponData[index]
                                          .data()['coupon'],
                                      startDate: userCube.couponData[index]
                                          .data()['startDate'],
                                      endDate: userCube.couponData[index]
                                          .data()['endDate'],
                                    ),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 20),
                                    itemCount: userCube.couponData.length,
                                  )
                                : Center(
                                    child: defaultText(
                                      text: 'No Coupons Found',
                                    ),
                                  ),
                          )),
                        ]),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
