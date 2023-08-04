import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestAPI {
  static const address = '7f83-193-168-46-11.ngrok-free.app';
//  static const address =  'd0fa-8-41-37-217.ngrok.io';

  /// Generic request
  ///
  Future<dynamic> fetch(String destination) async {
    final client = HttpClient();
    debugPrint('Client wants to connect to $destination');

    final HttpClientRequest request = await client.get(address, 80, destination);
    request.headers.contentType = ContentType('application', 'json', charset: 'utf-8');
    final HttpClientResponse response = await request.close();
    final stringData = await response.transform(utf8.decoder).join();
    final decoded = jsonDecode(stringData);
    print(stringData);

    try {
      return decoded as List<dynamic>;
    } catch (error) {
      return stringData;
    }
  }

  /// addUser TEST
  Future addUser(int id) async {
    final response = await http.post(
      Uri.http(address, 'userPost'),
      body: jsonEncode({
        "name": "Игорь",
        "fam": "Игорев",
        "otch": "Игоревич",
        "role": "1",
      }),
    );

    return utfResponse(response);
  }

  Future updateUserStatus(
    int id, {
    bool? banned,
    bool? deleted,
  }) async {
    final response = await http.put(
      Uri.http(address, 'userUpdate'),
      body: jsonEncode({
        "user": id,
        if (banned != null) "banned": banned,
        if (deleted != null) "deleted": deleted,
      }),
    );

    return utfResponse(response);
  }

  /// addBrack TEST
  Future addBrack({
    required int name,
    required int time,
    required int rating,
    required int serveTime,
    required String note,
    required int userID,
    required int supervisorID,
  }) async {
    final response = await http.post(
      Uri.http(address, 'brackPost'),
      body: jsonEncode({
        "dish": name,
        "timespend": time,
        "rating": rating,
        "serveTime": serveTime,
        "note": note,
        "user": userID,
        "userdone": supervisorID,
      }),
    );

    return utfResponse(response);
  }

  /// addHealth TEST
  Future addHealth({
    required int username,
    required int prof,
    required bool okz,
    required bool anginamark,
    required String diagnos,
    required bool passtowork,
  }) async {
    final response = await http.post(
      Uri.http(address, 'healthPost'),
      body: jsonEncode({
        "user": username,
        "connectionUserProfession": prof,
        "okz": okz,
        "anginamark": anginamark,
        "diagnos": diagnos,
        "passtowork": passtowork,
        "signsupervisor": true,
        "signworker": true,
      }),
    );

    return utfResponse(response);
  }

  /// addHealth TEST
  Future addTemperatureControl({
    required int temperature,
    required int vlazhn,
    required String warehouse,
    required bool signature,
    required int applianceId,
  }) async {
    print('started addTemperatureControl');
    final response = await http.post(
      Uri.http(address, 'tempControlPost'),
      body: jsonEncode({
        // "warehouse": warehouse,
        "temperature": temperature,
        "vlazhn": vlazhn,
        "user": 1,
        "sign": signature,
        "appliance": applianceId,
      }),
    );

    print(response);
    print(response.statusCode);
    return utfResponse(response);
  }

  /// addHealth TEST
  Future postTodaysMenu({
    required int id,
    required bool active,
  }) async {
    final response = await http.post(
      Uri.http(address, 'activeUpdate'),
      body: jsonEncode({"id": id, "active": active}),
    );

    return utfResponse(response);
  }
}

String utfResponse(http.Response response) {
  return const Utf8Decoder().convert(response.body.codeUnits);
}
