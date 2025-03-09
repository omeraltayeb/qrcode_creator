import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../function/check_internet.dart';

class Crud {
  Future<dynamic> postData(String linkurl, Map<String, dynamic> data) async {
    if (await checkInternet()) {
      var uri = Uri.parse(linkurl);
      var request = http.MultipartRequest('POST', uri);

      // Add regular fields to the request
      data.forEach((key, value) {
        if (value is String || value is int || value is double) {
          request.fields[key] = value.toString();
        }
      });

      // Add file fields to the request
      for (var entry in data.entries) {
        if (entry.value is File) {
          File file = entry.value;
          var fileStream = await http.MultipartFile.fromPath(
            entry.key,
            file.path,
          );
          request.files.add(fileStream);
        }
      }

      // Send the request
      var response = await request.send();

      // Get the response
      var responseBody = await http.Response.fromStream(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = jsonDecode(responseBody.body);
        return responseData;
      } else {
        log('Error: ${response.statusCode}, Response body: ${responseBody.body}');
        return 'Server error: ${response.statusCode}';
      }
    } else {
      return 'Server error: No internet access';
    }
  }
}
