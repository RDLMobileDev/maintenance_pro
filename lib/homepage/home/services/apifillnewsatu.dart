// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;

String url = MyUrl().getUrlDevice();

Future fillNewSatu(
  String token,
  String classificationId,
  String date,
  String userId,
  List<String> teamMember,
  String locationId,
  String locationGroupId,
  String machineId,
  String machineDetailId,
) async {
  try {
    // print(token);
    // print(classificationId);
    // print(date);
    // print(userId);
    // print(teamMember);
    // print(locationId);
    // print(locationGroupId);
    // print(machineId);
    // print(machineDetailId);

    Map<String, String> data;

    data = {
      'classification_id': classificationId,
      'date': date,
      'user_id': userId,
      'factory_id': locationId,
      'group_id': locationGroupId,
      'machine_name': machineId,
      'machine_number': machineDetailId
    };

    for (int i = 0; i < teamMember.length; i++) {
      data.addAll({"team_member[$i]": teamMember[i]});
    }

    // String url = MyUrl().getUrlDevice();
    final response = await http.post(Uri.parse("$url/ecm_step1"),
        headers: {
          "Accept": "Application/json",
          'Authorization': 'Bearer $token',
        },
        body: data);

    if (response.body.isNotEmpty) {
      var convertDatatoJson = jsonDecode(response.body);
      json.decode(response.body);
      return convertDatatoJson;
    }
  } on SocketException catch (e) {
    print(e);
  } on TimeoutException catch (e) {
    print(e);
  } catch (e) {
    print(e);
  }
}

Future getStep1Data(String ecmId, String token) async {
  try {
    final response = await http.get(
      Uri.parse("$url/ecm_step1_get?ecm_id=$ecmId"),
      headers: {
        "Accept": "Application/json",
        'Authorization': 'Bearer $token',
      },
    );

    return jsonDecode(response.body);
  } catch (e) {
    print(e);
    return [];
  }
}

Future getStepSatuDataForEdit(String ecmId, String token) async {
  try {
    final response =
        await http.get(Uri.parse("$url/ecm_step1_get?ecm_id=$ecmId"), headers: {
      "Accept": "Application/json",
      'Authorization': 'Bearer $token',
    });

    return jsonDecode(response.body);
  } catch (e) {
    print(e);
  }
}

Future postStepSatuEdit(
  String token,
  String ecmId,
  String classificationId,
  String date,
  String userId,
  List teamMember,
  String locationId,
  String locationGroupId,
  String machineId,
  String machineDetailId,
) async {
  Map<String, dynamic> dataPost;

  dataPost = {
    "classification_id": classificationId,
    "date": date,
    "user_id": userId,
    "factory_id": locationId,
    "group_id": locationGroupId,
    "machine_name": machineId,
    "machine_number": machineDetailId,
    "t_ecm_id": ecmId
  };

  for (int i = 0; i < teamMember.length; i++) {
    dataPost.addAll({"team_member[$i]": teamMember[i]});
  }

  try {
    final response = await http.post(Uri.parse("$url/ecm_step1_update"),
        headers: {
          "Accept": "Application/json",
          'Authorization': 'Bearer $token',
        },
        body: dataPost);

    return jsonDecode(response.body);
  } catch (e) {
    print(e);
  }
}
