abstract class ResultCreateState {}

class ResultCreateInitial extends ResultCreateState {}

class ResultCreateLoading extends ResultCreateState {}

class ResultCreateLoaded extends ResultCreateState {}

class ResultCreateFailure extends ResultCreateState {
  final String error;
  ResultCreateFailure(this.error);
}
