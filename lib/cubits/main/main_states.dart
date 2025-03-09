abstract class MainStates {}

class MainInitial extends MainStates {
  final int index;
  MainInitial({required this.index});
}

class MainLoading extends MainStates {}

class MainFailure extends MainStates {
  final String message;
  MainFailure(this.message);
}
