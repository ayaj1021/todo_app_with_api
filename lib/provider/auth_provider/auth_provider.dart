// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:todo_app_with_api/constants/url.dart';
import 'package:todo_app_with_api/database/dbprovider.dart';
import 'package:todo_app_with_api/screens/authentication/login.dart';
import 'package:todo_app_with_api/screens/task_page/home_page.dart';
import 'package:todo_app_with_api/utils/router.dart';

class AuthenticationProvider extends ChangeNotifier {
  var logger = Logger();
  final requestBaseUrl = AppUrl.secondBaseUrl;

  bool _isLoading = false;
  String _resMessage = '';

  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  //register user
  void registerUser({
    required String email,
    required String password,
    required String firstName,
    // required String lastName,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/users/register";

    final body = {
      "name": firstName,
      // "lastName": lastName,
      "email": email,
      "password": password,
    };

    print(body);

    try {
      final response = await http.post(Uri.parse(url), body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = json.decode(response.body);
        print(res);
        _isLoading = false;
        _resMessage = 'Account created';
        notifyListeners();
        PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
      } else {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = 'Please try again';
      notifyListeners();
      print(":::: $e");
    }
  }

//login user
  void loginUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    //08039608089
    notifyListeners();

    String url = "$requestBaseUrl/users/login";

    final body = {
      "email": email,
      "password": password,
    };

    print(body);

    try {
      final response = await http.post(Uri.parse(url), body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = json.decode(response.body);
        print(res);
        _isLoading = false;
        _resMessage = 'Login successful';
        notifyListeners();
        if (context!.mounted) {
          PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
        }
        //Save user's data and then navigate to home page

        final userId = res['_id'];
        final token = res['token'];
        print(userId);
        print(token);
        DatabaseProvider().saveToken(token);
        DatabaseProvider().saveUserId(userId);
        PageNavigator(ctx: context).nextPageOnly(page: const HomePage());
      } else {
        final res = json.decode(response.body);

        _resMessage = res['message'];
        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = 'Please try again';
      notifyListeners();
      print(":::: $e");
    }
  }

  void clear() {
    _resMessage = "";
    notifyListeners();
  }
}
