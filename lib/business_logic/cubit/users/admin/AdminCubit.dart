import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/firecase/firebase_reposatory.dart';
import '../../../../data/local/cache_helper.dart';
import 'AdminStates.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(InitialAdminState());

  static AdminCubit get(context) => BlocProvider.of(context);

  Map<String, dynamic>? admin;

  List<Map<String, dynamic>> infractionsAdminData = [];

  bool obscurePassFlag = true;

  bool obscureConfirmFlag = true;

  final FirebaseReposatory _firebaseReposatory = FirebaseReposatory();

  void getAdminData() {
    emit(GetAdminLoadingState());
    _firebaseReposatory.getUserData().then((value) {
      admin = value.data() as Map<String, dynamic>;
      setAdminDataInCash();
      emit(GetAdminSuccessState());
    }).catchError((error) {
      emit(GetAdminErrorState(error.toString()));
    });
  }

  dynamic getAdminInfractionsData() async {
    emit(GetAdminLoadingState());
    FirebaseFirestore.instance
        .collectionGroup('Infraction')
        .get()
        .then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        FirebaseFirestore.instance
            .collection('Infraction')
            .doc(element.id)
            .collection('Infractions')
            .get()
            .then((value) {
          for (var element2 in value.docs) {
            print(element2.data());
            infractionsAdminData.add(element2.data());
          }
        });
      }
      setAdminDataInCash();
      emit(GetAdminSuccessState());
    }).catchError((error) {
      emit(GetAdminErrorState(error.toString()));
      return null;
    });
  }

  void setAdminDataInCash() {
    if (admin!.isNotEmpty) {
      admin!.forEach((key, value) {
        CacheHelper.putData(key: key, value: value);
      });
    }
  }



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
