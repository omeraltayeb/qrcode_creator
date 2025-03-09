import 'dart:io';
import '../../../core/constant/links.dart';
import '../../../core/class/crud.dart';

class MyQrData {
  Crud crud = Crud();

  addQR(String labelName, String userid, File fileImage) async {
    var response = await crud.postData(Links.addQRcode, {
      "labelName": labelName,
      "userid": userid,
      "qr_codes_image": fileImage,
    });
    return response;
  }

  addFile(File files) async {
    var response = await crud.postData(Links.addFile, {
      "files": files,
    });
    return response;
  }

  getData(String userid) async {
    var response = await crud.postData(Links.viewQRcode, {
      "userid": userid,
    });
    return response;
  }

  deleteData(String recordId) async {
    var response = await crud.postData(Links.deleteQRcode, {
      "recordId": recordId,
    });
    return response;
  }
}
