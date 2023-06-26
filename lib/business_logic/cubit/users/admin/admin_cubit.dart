import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/firecase/firebase_reposatory.dart';
import 'admin_states.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(InitialAdminState());

  static AdminCubit get(context) => BlocProvider.of(context);

  Map<String, dynamic>? admin;

  List<Map<String, dynamic>> infractionsAdminData = [];

  bool obscurePassFlag = true;

  bool obscureConfirmFlag = true;

  final FirebaseReposatory _firebaseReposatory = FirebaseReposatory();

  // void getAdminData() {
  //   emit(GetAdminLoadingState());
  //   _firebaseReposatory.getUserData().then((value) {
  //     admin = value.data() as Map<String, dynamic>;
  //     emit(GetAdminSuccessState());
  //   }).catchError((error) {
  //     emit(GetAdminErrorState(error.toString()));
  //   });
  // }

  void logout() {
    _firebaseReposatory.logout();
    emit(LogOutSuccessAdminState());
  }

  void changeObscurePassFlag(flag) {
    obscurePassFlag = flag;
    emit(ChangeObscurePassFlagAdminState());
  }

  void changeObscureConfirmFlag(flag) {
    obscureConfirmFlag = flag;
    emit(ChangeObscureConfirmFlagAdminState());
  }
}
