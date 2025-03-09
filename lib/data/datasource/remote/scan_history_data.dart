import '../../../../core/class/crud.dart';
import '../../../core/constant/links.dart';

class ScanHistoryData {
  Crud crud = Crud();
  getData(String userid) async {
    var response = await crud.postData(Links.viewHistory, {
      "userid": userid,
    });
    return response;
  }

  deleteData(String id) async {
    var response = await crud.postData(Links.deleteHistory, {
      "id": id,
    });
    return response;
  }
}
