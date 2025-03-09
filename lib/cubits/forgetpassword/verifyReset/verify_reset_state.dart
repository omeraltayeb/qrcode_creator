abstract class VerifyResetState {}

class VerifyResetInitial extends VerifyResetState {}

class VerifyResetLoading extends VerifyResetState {}

class VerifyResetLoaded extends VerifyResetState {}

class VerifyResetFailure extends VerifyResetState {
  final String message;
  VerifyResetFailure(this.message);
}
