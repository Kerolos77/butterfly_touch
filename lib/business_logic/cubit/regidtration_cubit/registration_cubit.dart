import 'package:butterfly_touch/business_logic/cubit/regidtration_cubit/registration_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/conestant.dart';
import '../../../data/firecase/firebase_reposatory.dart';
import '../../../data/local/cache_helper.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  static RegistrationCubit get(context) => BlocProvider.of(context);

  bool registrationFlag = true;
  FirebaseReposatory firebaseReposatory = FirebaseReposatory();

  void changeRegistration(bool registrationFlag) {
    this.registrationFlag = registrationFlag;
    emit(ChangeRegistration());
  }

  signUp({
    required firstName,
    required lastName,
    required email,
    required password,
  }) async {
    emit(SignUpLoadingRegistrationState());
    firebaseReposatory
        .signUp(email: email, password: password)
        .then((value) => {
              if (value.user?.uid != null)
                {
                  firebaseReposatory
                      .createUser(
                          userId: value.user!.uid,
                          firstName: firstName,
                          lastName: lastName,
                          email: email,
                          password: password)
                      .then((value) {
                    CacheHelper.putData(key: 'name', value: '');
                    CacheHelper.putData(key: 'email', value: '');
                    emit(SignUpSuccessRegistrationState());
                    registrationFlag = true;
                  }).catchError((error) {
                    emit(SignUpErrorRegistrationState(error.toString()));
                  })
                }
            })
        .catchError((error) {
      emit(SignUpErrorRegistrationState(error.toString()));
    });
  }

  login({
    required buildContext,
    required email,
    required password,
  }) async {
    emit(LoginLoadingRegistrationState());
    firebaseReposatory.login(email: email, password: password).then((value) {
      constUid = value.user!.uid;
      FirebaseFirestore.instance
          .collection('users')
          .doc(constUid)
          .get()
          .then((value) {
        CacheHelper.putData(key: 'name', value: value.data()!['name']);
        CacheHelper.putData(key: 'email', value: value.data()!['email']);
      });
      emit(LoginSuccessRegistrationState(value.user!.uid));
    }).catchError((error) {
      emit(LoginErrorRegistrationState(error.toString()));
    });
  }

  logout() {
    firebaseReposatory.logout().then((value) {
      emit(LogoutSuccessRegistrationState());
    }).catchError((error) {
      emit(LogoutErrorRegistrationState(error.toString()));
    });
  }
}
