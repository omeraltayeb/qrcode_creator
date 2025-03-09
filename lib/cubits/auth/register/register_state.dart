abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {}

class Authenticated extends RegisterState {
  Authenticated();
}

class Unauthenticated extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String message;
  RegisterFailure(this.message);
}
