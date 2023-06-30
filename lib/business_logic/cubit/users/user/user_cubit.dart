import 'package:butterfly_touch/utiles/id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../data/firecase/firebase_reposatory.dart';
import 'user_states.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(InitialUserState());

  static UserCubit get(context) => BlocProvider.of(context);

  Map<String, dynamic>? user;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> couponData = [];

  bool obscurePassFlag = true;

  bool obscureConfirmFlag = true;

  final FirebaseReposatory _firebaseReposatory = FirebaseReposatory();

  void getUserData() {
    // emit(GetUserLoadingState());
    _firebaseReposatory.getUserData().then((value) {
      user = value.data() as Map<String, dynamic>;
      checkScore();
      getCoupons();
      emit(GetUserSuccessState());
      // print(user?['score']);
    }).catchError((error) {
      emit(GetUserErrorState(error.toString()));
    });
  }

  void logout() {
    _firebaseReposatory.logout();
    emit(LogOutSuccessUserState());
  }

  void changeObscurePassFlag(flag) {
    obscurePassFlag = flag;
    emit(ChangeObscurePassFlagUserState());
  }

  void changeObscureConfirmFlag(flag) {
    obscureConfirmFlag = flag;
    emit(ChangeObscureConfirmFlagUserState());
  }

  void createCoupon({
    required String coupon,
    required String startDate,
    required String endDate,
  }) {
    _firebaseReposatory
        .createCoupon(
      coupon: coupon,
      startDate: startDate,
      endDate: endDate,
    )
        .then((value) {
      updateScore();
      emit(CreateCouponSuccessState());
    }).catchError((error) {
      emit(CreateCouponErrorState(error.toString()));
    });
  }

  void updateScore() {
    _firebaseReposatory.updateScore(
        score: ((int.parse(user?['score'])) - 50).toString());
  }

  void getCoupons() {
    emit(GetCouponLoadingState());
    _firebaseReposatory.getCoupons().then((querySnapshot) {
      couponData = querySnapshot.docs;
      emit(GetCouponSuccessState());
    }).catchError((error) {
      emit(GetCouponErrorState(error.toString()));
    });
  }

  void checkScore() {
    if (int.parse(user?['score']) == 50) {
      createCoupon(
        coupon: CreateId.createId(),
        startDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        endDate: DateFormat('yyyy-MM-dd')
            .format(DateTime.now().add(const Duration(days: 30))),
      );
    }
  }
}
