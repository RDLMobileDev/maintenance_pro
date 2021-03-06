import 'dart:convert';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:e_cm/homepage/home/model/part_model.dart';
import 'package:http/http.dart' as http;

class ApiLocationPartService {
  static Future<List<PartModel>> getPartLocations(
      String ecmId, String tokenUser) async {
    var url = MyUrl().getUrlDevice();

    try {
      final response =
          await http.get(Uri.parse("$url/get_part?ecm_id=$ecmId"), headers: {
        "Accept": "Application/json",
        'Authorization': 'Bearer $tokenUser',
      });

      var decodedData = json.decode(response.body)['data'] as List;

      return decodedData.map((e) => PartModel.fromJson(e)).toList();
    } catch (e) {
      print("exception occured -> $e");
      return List<PartModel>.empty();
    }
  }
}
