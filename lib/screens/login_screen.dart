import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:srv_project/constants/regexps.dart';
import 'package:srv_project/helpers/database_helper.dart';
import 'package:srv_project/widgets/custom_form_field.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomFormField(
                passwordController: _usernameController,
                hintText: 'Email',
                validationRegExp: EMAIL_VALIDATION_REGEX,
              ),
              const SizedBox(height: 20),
              CustomFormField(
                passwordController: _passwordController,
                hintText: 'Password',
                validationRegExp: PASSWORD_VALIDATION_REGEX,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ref.read(authProvider.notifier).login(
                          _usernameController.text,
                          _passwordController.text,
                        );
                    final dbHelper = DatabaseHelper();

                    // Заполняем базу данных тестовыми продуктами
                    await dbHelper.populateTestProducts();

                    context.go('/home');
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
