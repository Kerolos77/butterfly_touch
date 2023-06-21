import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/firecase/firebase_reposatory.dart';
import 'UserStates.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(InitialUserState());

  static UserCubit get(context) => BlocProvider.of(context);

  Map<String, dynamic>? user;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> infractionsUserData = [];

  bool obscurePassFlag = true;

  bool obscureConfirmFlag = true;

  final FirebaseReposatory _firebaseReposatory = FirebaseReposatory();

  void getUserData() {
    // emit(GetUserLoadingState());
    _firebaseReposatory.getUserData().then((value) {
      user = value.data() as Map<String, dynamic>;
      emit(GetUserSuccessState());
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
}
