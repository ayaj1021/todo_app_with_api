import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_api/provider/auth_provider/auth_provider.dart';
import 'package:todo_app_with_api/screens/authentication/login.dart';
import 'package:todo_app_with_api/utils/router.dart';
import 'package:todo_app_with_api/utils/snack_message.dart';
import 'package:todo_app_with_api/widgets/button.dart';
import 'package:todo_app_with_api/widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  @override
  void dispose() {
    _email.clear();
    _password.clear();
    _firstName.clear();
    _lastName.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    customTextField(
                      title: 'First name',
                      controller: _firstName,
                      hint: 'Enter your first name',
                    ),
                    customTextField(
                      title: 'Last name',
                      controller: _lastName,
                      hint: 'Enter your last name',
                    ),
                    customTextField(
                      title: 'Email',
                      controller: _email,
                      hint: 'Enter your valid email address',
                    ),
                    customTextField(
                      title: 'Password',
                      controller: _password,
                      hint: 'Enter your secured password',
                    ),
                    Consumer<AuthenticationProvider>(
                        builder: (context, auth, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (auth.resMessage != '') {
                          showMessage(
                            message: auth.resMessage,
                            context: context,
                          );
                          auth.clear();
                        }
                      });

                      return customButton(
                        text: 'Register',
                        tap: () {
                          if (_firstName.text.isEmpty ||
                              _lastName.text.isEmpty ||
                              _email.text.isEmpty ||
                              _password.text.isEmpty) {
                            showMessage(
                              message: 'All fields are required',
                              context: context,
                            );
                          } else {
                            auth.registerUser(
                                firstName: _firstName.text.trim(),
                                // lastName: _lastName.text.trim(),
                                email: _email.text.trim(),
                                password: _password.text.trim(),
                                context: context);
                          }
                        },
                        context: context,
                        status: auth.isLoading,
                      );
                    }),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: const LoginPage());
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account? '),
                          Text('Login'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
