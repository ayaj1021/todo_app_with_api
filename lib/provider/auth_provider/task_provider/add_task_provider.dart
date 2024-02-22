import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app_with_api/constants/url.dart';
import 'package:todo_app_with_api/database/dbprovider.dart';

class AddTaskProvider extends ChangeNotifier {
  final url = AppUrl.secondBaseUrl;

  bool _status = false;

  String _response = '';

  bool get getStatus => _status;

  String get getResponse => _response;

  ///To get graphql client

  ///Add task method
  void addTask({String? title}) async {
    final token = await DatabaseProvider().getToken();
    final userId = await DatabaseProvider().getUserId();
    _status = true;
    notifyListeners();

    // ignore: no_leading_underscores_for_local_identifiers
    final _url = "$url/tasks/";

    final body = {
      "title": title,
      "startTime": "2022-08-18T11:01:00.000+00:00",
      "endTime": "2022-09-18T12:00:00.000+00:00",
      "userId": userId,
      "reminderPeriod": "2022-07-19T12:00:00.000+00:00"
    };

    final result = await http.post(Uri.parse(_url),
        body: json.encode(body), headers: {'Authorization': 'Bearer $token'});

    if (result.statusCode == 200 || result.statusCode == 201) {
      final res = result.body;

      _status = false;

      _response = json.decode(res)['message'];

      notifyListeners();
    } else {
      final res = result.body;

      _response = json.decode(res)['message'];

      _status = false;

      notifyListeners();
    }
  }

  void clear() {
    _response = '';
    notifyListeners();
  }
}
