abstract class MyQrStates {}

class MyQrInitial extends MyQrStates {}

class MyQrLoading extends MyQrStates {}

class MyQrLoaded extends MyQrStates {
  final List data;
  MyQrLoaded({this.data = const []});
}

class MyQrFailure extends MyQrStates {
  final String error;
  MyQrFailure(this.error);
}
