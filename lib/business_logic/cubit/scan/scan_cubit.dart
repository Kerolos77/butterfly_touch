import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/firecase/firebase_reposatory.dart';
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

  void deleteBarcode({
    required String barcode,
  }) {
    emit(DeleteBarcodeLoadingScanStates());
    _firebaseReposatory.deleteBarcode(barcode: barcode).then((value) {
      emit(DeleteBarcodeSuccessScanStates());
    }).catchError((error) {
      emit(DeleteBarcodeErrorScanStates(error));
    });
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
      emit(GetBarcodeSuccessScanStates());
    }).catchError((error) {
      emit(GetBarcodeErrorScanStates(error));
    });
  }
}
