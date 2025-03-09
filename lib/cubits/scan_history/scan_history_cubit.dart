import 'dart:convert';
import 'dart:developer';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode_creator/core/services/services.dart';
import 'package:qrcode_creator/cubits/scan_history/scan_history_states.dart';
import '../../data/datasource/remote/scan_history_data.dart';

class ScanHistoryCubit extends Cubit<ScanHistoryStates> {
  final pageController = PageController();
  int selectedIndex = 0;
  final scanHistoryData = ScanHistoryData();
  List<dynamic> scanData = [];
  ScanHistoryCubit() : super(ScanHistoryInitial());
  final myServices = MyServices();

  void updateSelectedIndex(int index) async {
    emit(ScanHistoryLoading());
    await fetchScannedData(index);
    emit(ScanHistoryLoaded(index));
  }

  Future<void> fetchScannedData(int index) async {
    emit(ScanHistoryLoading());

    final isLoggedIn = await myServices.getValue("isLogin") == "true";
    if (isLoggedIn) {
      String? userId = await myServices.getValue("userid");
      if (userId != null) {
        // Fetch remote data
        var response = await scanHistoryData.getData(userId);
        if (response["status"] == "success") {
          List<dynamic> remoteData = response["data"];

          // Fetch local data
          List<dynamic> localData = [];
          String? scannedValues = await myServices.getValue("scannedValues");
          String? localDataString = scannedValues;
          if (localDataString != null && localDataString.isNotEmpty) {
            localData = jsonDecode(localDataString);
          }

          // Combine remote and local data
          scanData = [...remoteData, ...localData];

          log("Combined Data: $scanData");
          emit(ScanHistoryLoaded(index, scannedData: scanData));
        } else {
          emit(ScanHistoryFailure("Failed to fetch remote scanned data"));
        }
      } else {
        emit(ScanHistoryFailure("User ID not found"));
      }
    } else {
      // Fetch only local data if not logged in
      String? scannedValues = await myServices.getValue("scannedValues");
      String? localDataString = scannedValues;
      if (localDataString != null && localDataString.isNotEmpty) {
        scanData = jsonDecode(localDataString);
        emit(ScanHistoryLoaded(index, scannedData: scanData));
        log("Local Data: $scanData");
      } else {
        emit(ScanHistoryFailure("No local scanned data found"));
      }
    }
  }

  deleteHistory(String id, BuildContext context) async {
    var response = await scanHistoryData.deleteData(id);
    if (response["status"] == "success") {
      CherryToast.success(
        title: Text("success", style: TextStyle(color: Colors.black)),
        action: Text("QR code Record deleted from history scan",
            style: TextStyle(color: Colors.black)),
      ).show(context);
      emit(ScanHistoryLoaded(selectedIndex, scannedData: scanData));
    } else {
      CherryToast.warning(
        title: Text("warning", style: TextStyle(color: Colors.black)),
        action: Text("Field delete QR code Record",
            style: TextStyle(color: Colors.black)),
      ).show(context);
      emit(ScanHistoryFailure("Field delete QR code Record"));
    }
  }
}
