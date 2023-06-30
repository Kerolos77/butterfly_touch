import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/firecase/firebase_reposatory.dart';
import '../../../constants/conestant.dart';
import 'scan_states.dart';

class ScanCubit extends Cubit<ScanStates> {
  ScanCubit() : super(InitialAdminState());

  static ScanCubit get(context) => BlocProvider.of(context);

  final FirebaseReposatory _firebaseReposatory = FirebaseReposatory();

  bool envFlag = true;
  bool showContainerFlag = false;

  Map<String, dynamic>? barcode;

  void createBarcode({
    required String barcode,
    required bool isGood,
    required String description,
  }) {
    emit(CreateBarcodeLoadingScanStates());
    _firebaseReposatory
        .createBarcode(
            barcode: barcode, isGood: isGood, description: description)
        .then((value) {
      emit(CreateBarcodeSuccessScanStates());
    }).catchError((error) {
      emit(CreateBarcodeErrorScanStates(error));
    });
  }

  // void deleteBarcode({
  //   required String barcode,
  // }) {
  //   emit(DeleteBarcodeLoadingScanStates());
  //   _firebaseReposatory.deleteBarcode(barcode: barcode).then((value) {
  //     emit(DeleteBarcodeSuccessScanStates());
  //   }).catchError((error) {
  //     emit(DeleteBarcodeErrorScanStates(error));
  //   });
  // }

  Map<String, dynamic>? user;

  void getUserData() {
    _firebaseReposatory.getUserData().then((value) {
      user = value.data() as Map<String, dynamic>;
    }).catchError((error) {});
  }

  void updateScore(ChangeScore score) {
    if (score == ChangeScore.increase) {
      _firebaseReposatory.updateScore(
          score: ((int.parse(user?['score'])) + 1).toString());
    }
    if (score == ChangeScore.decrease && int.parse(user?['score']) > 0) {
      _firebaseReposatory.updateScore(
          score: ((int.parse(user?['score'])) - 1).toString());
    }
  }

  void changeEnvFlag(flag) {
    envFlag = flag;
    emit(ChangeEnvState());
  }

  void changeShowContainerFlag(flag) {
    showContainerFlag = flag;
    emit(ChangeEnvState());
  }

  void logout() {
    _firebaseReposatory.logout();
    emit(LogOutSuccessScanStates());
  }

  void getBarcode({required barcode}) {
    emit(GetBarcodeLoadingScanStates());
    _firebaseReposatory.getBarcode(barcode: barcode).then((value) {
      barcode = value.data() as Map<String, dynamic>;
      print(barcode);
      emit(GetBarcodeSuccessScanStates(value.data()));
    }).catchError((error) {
      emit(GetBarcodeErrorScanStates(error));
    });
  }
}
