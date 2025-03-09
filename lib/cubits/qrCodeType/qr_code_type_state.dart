abstract class QrCodeTypeState {}

class QrCodeTypeInitial extends QrCodeTypeState {}

class QrCodeTypeLoading extends QrCodeTypeState {}

class QrCodeTypeLoaded extends QrCodeTypeState {}

class QrCodeTypeFailure extends QrCodeTypeState {
  final String error;
  QrCodeTypeFailure(this.error);
}
