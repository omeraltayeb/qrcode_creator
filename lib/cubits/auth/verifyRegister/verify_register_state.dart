abstract class VerifyRegisterState {}

class VerifyRegisterInitial extends VerifyRegisterState {}

class VerifyRegisterLoading extends VerifyRegisterState {}

class VerifyRegisterLoaded extends VerifyRegisterState {}

class VerifyRegisterFailure extends VerifyRegisterState {
  final String message;
  VerifyRegisterFailure(this.message);
}
