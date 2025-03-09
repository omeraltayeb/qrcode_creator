abstract class CreateQrCodeStates {}

class CreateQrCodeInitial extends CreateQrCodeStates {}

class CreateQrCodeLoading extends CreateQrCodeStates {}

class CreateQrCodeLoaded extends CreateQrCodeStates {}

class CreateQrCodeFailure extends CreateQrCodeStates {
  final String error;
  CreateQrCodeFailure(this.error);
}
