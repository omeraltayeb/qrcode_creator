import '../../../core/constant/links.dart';
import '../../../core/class/crud.dart';

class ScanData {
  Crud crud = Crud();

  postData(String value, String userid) async {
    var response = await crud.postData(Links.addHistory, {
      "value": value,
      "userid": userid,
    });
    return response;
  }
}
