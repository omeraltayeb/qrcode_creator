abstract class CheckEmailState {}

class CheckEmailInitial extends CheckEmailState {}

class CheckEmailLoading extends CheckEmailState {}

class CheckEmailLoaded extends CheckEmailState {}

class CheckEmailFailure extends CheckEmailState {
  final String message;
  CheckEmailFailure(this.message);
}
