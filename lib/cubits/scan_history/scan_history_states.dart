abstract class ScanHistoryStates {}

class ScanHistoryInitial extends ScanHistoryStates {}

class ScanHistoryLoading extends ScanHistoryStates {}

class ScanHistoryLoaded extends ScanHistoryStates {
  final int selectedIndex;
  final List scannedData;
  ScanHistoryLoaded(this.selectedIndex, {this.scannedData = const []});
}

class ScanHistoryFailure extends ScanHistoryStates {
  final String message;
  ScanHistoryFailure(this.message);
}
