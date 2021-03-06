import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future getHistoryDaily(String token, dateTarget, dateNow) async {
  String myUrl = MyUrl().getUrlDevice();
  String url =
      "$myUrl/history_semuatgl?tgltujuan=$dateTarget&tglsekarang=$dateNow";
  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  });
  // print('Token : ${token}');
  print(response.body);

  if (response.body.isNotEmpty) {
    var convertDatatoJson = jsonDecode(response.body);
    json.decode(response.body);
    return convertDatatoJson;
  }
}
