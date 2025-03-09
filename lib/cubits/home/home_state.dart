abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeLoading extends HomeStates {}

class HomeLoaded extends HomeStates {}

class HomeFailure extends HomeStates {
  final String message;
  HomeFailure(this.message);
}
