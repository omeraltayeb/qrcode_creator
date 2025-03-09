import 'dart:io';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gal/gal.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrcode_creator/core/function/check_internet.dart';
import 'package:qrcode_creator/core/services/services.dart';
import 'package:qrcode_creator/cubits/myQr/my_qr_states.dart';
import 'package:qrcode_creator/core/constant/links.dart';
import '../../data/datasource/remote/my_qr_data.dart';
import '../../data/model/myqr_model.dart';
import '../notificationHelper/notification_helper.dart';

class MyQrCubit extends Cubit<MyQrStates> {
  MyQrData myQrData = MyQrData();
  MyServices myServices = MyServices();
  List<MyQRModel> data = [];
  MyQrCubit() : super(MyQrInitial());

  Future<void> fetchData() async {
    emit(MyQrLoading());
    String? userId = await myServices.getValue('userid');
    var response = await myQrData.getData(userId!);
    if (response["status"] == "success") {
      List lisdata = response["data"];
      data.addAll(lisdata.map((e) => MyQRModel.fromJson(e)));
      emit(MyQrLoaded(data: response["data"]));
    } else {
      emit(MyQrFailure("fail"));
    }
  }

  Future<void> downloadQRCode(BuildContext context, String imageUrl) async {
    if (await checkInternet()) {
      final tempDir = await getDownloadsDirectory();
      final fileName = imageUrl;
      final filePath = '${tempDir!.path}/$fileName';
      final httpClient = HttpClient();
      final request =
          await httpClient.getUrl(Uri.parse('${Links.qrcodeImage}/$imageUrl'));
      final response = await request.close();
      if (response.statusCode == 200) {
        final file = File(filePath);
        await response.pipe(file.openWrite());
        await Gal.putImage(filePath);
        // Show notification
        await NotificationHelper.showNotification(
          title: 'Download Complete',
          body: basename(filePath),
        );
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('QR Code saved to gallery!')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to download image: ${response.statusCode}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No internet connection!')),
      );
      return;
    }
  }

  deleteQrCode(String id, BuildContext context) async {
    emit(MyQrLoading());
    if (await checkInternet()) {
      var response = await myQrData.deleteData(id);
      if (response["status"] == "success") {
        CherryToast.success(
          title: Text("success", style: TextStyle(color: Colors.black)),
          action: Text("QR code Record deleted successfully",
              style: TextStyle(color: Colors.black)),
        ).show(context);
        emit(MyQrLoaded(data: []));
      } else {
        emit(MyQrFailure('Failed to delete QR code Record'));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete QR code Record')),
        );
      }
    } else {
      emit(MyQrFailure('No internet access'));
    }
  }
}
