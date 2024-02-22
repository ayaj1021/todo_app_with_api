import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_api/provider/auth_provider/auth_provider.dart';
import 'package:todo_app_with_api/screens/authentication/register.dart';
import 'package:todo_app_with_api/utils/router.dart';
import 'package:todo_app_with_api/utils/snack_message.dart';
import 'package:todo_app_with_api/widgets/button.dart';
import 'package:todo_app_with_api/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  void dispose() {
    _email.clear();
    _password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
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
                        text: 'Login',
                        tap: () {
                          if (_email.text.isEmpty || _password.text.isEmpty) {
                            showMessage(
                              message: 'All fields are required',
                              context: context,
                            );
                          } else {
                            auth.loginUser(
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
                            .nextPage(page: const RegisterPage());
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account? '),
                          Text('Register'),
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
