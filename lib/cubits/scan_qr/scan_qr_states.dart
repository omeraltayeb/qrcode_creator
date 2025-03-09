abstract class ScanQrStates {}

class ScanQrInitial extends ScanQrStates {}

class ScanQrLoading extends ScanQrStates {}

class ScanQrLoaded extends ScanQrStates {}

class ScanQrSuccess extends ScanQrStates {
  final String scannedValue;
  ScanQrSuccess(this.scannedValue);
}

class ScanQrFailure extends ScanQrStates {
  final String error;
  ScanQrFailure(this.error);
}
