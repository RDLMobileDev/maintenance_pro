import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future getIdFillNewEmpat(String ecmitemId, String userId, String token) async {
  String myUrl = MyUrl().getUrlDevice();
  String url = "$myUrl/ecmstep4_getid?ecmitem_id=$ecmitemId&user_id=$userId";
  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  });
  print('Token : ${token}');
  print(response);

  if (response.body.isNotEmpty) {
    var convertDatatoJson = jsonDecode(response.body);
    json.decode(response.body);
    return convertDatatoJson;
  }
}
