// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app_with_api/constants/url.dart';
import 'package:todo_app_with_api/database/dbprovider.dart';
import 'package:todo_app_with_api/screens/task_page/home_page.dart';
import 'package:todo_app_with_api/utils/router.dart';

class DeleteTaskProvider extends ChangeNotifier {
  final url = AppUrl.baseUrl;

  bool _status = false;

  String _response = '';

  bool get getStatus => _status;

  String get getResponse => _response;

  ///To get graphql client

  ///Add task method
  void deleteTask({String? taskId, BuildContext? ctx}) async {
    final token = await DatabaseProvider().getToken();
    _status = true;
    notifyListeners();

    final _url = "$url/tasks/$taskId";

    final result = await http
        .delete(Uri.parse(_url), headers: {'Authorization': "Bearer $token"});

    if (result.statusCode == 200 || result.statusCode == 201) {
      final res = result.body;

      _status = false;

      _response = json.decode(res)['message'];

      notifyListeners();
      PageNavigator(ctx: ctx).nextPageOnly(page: const HomePage());
    } else {
      final res = result.body;

      _status = false;

      _response = json.decode(res)['message'];

      notifyListeners();
    }
  }

  void clear() {
    _response = '';
    notifyListeners();
  }
}
