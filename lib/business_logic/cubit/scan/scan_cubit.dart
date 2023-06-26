
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/firecase/firebase_reposatory.dart';
import 'scan_states.dart';

class ScanCubit extends Cubit<ScanStates> {
  ScanCubit() : super(InitialAdminState());

  static ScanCubit get(context) => BlocProvider.of(context);

  final FirebaseReposatory _firebaseReposatory = FirebaseReposatory();
}
