abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class ChangeRegistration extends RegistrationState {}

class SignUpLoadingRegistrationState extends RegistrationState {}

class SignUpSuccessRegistrationState extends RegistrationState {}

class SignUpErrorRegistrationState extends RegistrationState {
  late String error;

  SignUpErrorRegistrationState(this.error);
}

class LoginLoadingRegistrationState extends RegistrationState {}

class LoginSuccessRegistrationState extends RegistrationState {
  late String uid;

  LoginSuccessRegistrationState(this.uid);
}

class LoginErrorRegistrationState extends RegistrationState {
  late String error;

  LoginErrorRegistrationState(this.error);
}

class GoogleLoadingRegistrationState extends RegistrationState {}

class GoogleSuccessRegistrationState extends RegistrationState {
  late String uid;

  GoogleSuccessRegistrationState(this.uid);
}

class GoogleErrorRegistrationState extends RegistrationState {
  late String error;

  GoogleErrorRegistrationState(this.error);
}

class LogoutLoadingRegistrationState extends RegistrationState {}

class LogoutSuccessRegistrationState extends RegistrationState {}

class LogoutErrorRegistrationState extends RegistrationState {
  late String error;

  LogoutErrorRegistrationState(this.error);
}
