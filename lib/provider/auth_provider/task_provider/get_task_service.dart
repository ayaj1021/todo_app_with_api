import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_app_with_api/constants/url.dart';
import 'package:todo_app_with_api/database/dbprovider.dart';
import 'package:todo_app_with_api/model/task_model.dart';

class GetUserTask {
  final url = AppUrl.baseUrl;

  Future<TaskModel> getTask() async {
    final userId = await DatabaseProvider().getUserId();
    final token = await DatabaseProvider().getToken();

    // ignore: no_leading_underscores_for_local_identifiers
    String _url = "$url/users/$userId/tasks?lastId=&pagination=20";

    try {
      final request = await http
          .get(Uri.parse(_url), headers: {'Authorization': 'Bearer $token'});

      if (request.statusCode == 200 || request.statusCode == 201) {
        if (json.decode(request.body)['tasks'] == null) {
          return TaskModel();
        } else {
          final taskModel = taskModelFromJson(request.body);
          return taskModel;
        }
      } else {
        // final notificationModel = notificationModelFromJson(request.body);

        return TaskModel();
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
