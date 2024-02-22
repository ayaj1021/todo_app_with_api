import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_api/database/dbprovider.dart';
import 'package:todo_app_with_api/provider/auth_provider/auth_provider.dart';
import 'package:todo_app_with_api/provider/auth_provider/task_provider/add_task_provider.dart';
import 'package:todo_app_with_api/provider/auth_provider/task_provider/delete_task_provider.dart';
import 'package:todo_app_with_api/splash_screen.dart';
import 'package:todo_app_with_api/styles/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProvider(create: (_) => DeleteTaskProvider()),
        ChangeNotifierProvider(create: (_) => AddTaskProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: primaryColor,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: primaryColor,
          ),
          primaryColor: primaryColor,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
