import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_test/configs/routing/routes.dart';
import 'package:task_management_test/core/base_state.dart';
import 'package:task_management_test/core/utils/string_validator.dart';
import 'package:task_management_test/features/auth/presentation/cubit/login_cubit.dart';
import 'package:task_management_test/injection_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginCubit = sl<LoginCubit>();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          spacing: 16,
          children: [
            TextFormField(
              controller: _emailController,
              autofillHints: [AutofillHints.email],
              validator: (value) {
                if (!value.isValidEmail) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: _passwordController,
              autofillHints: [AutofillHints.password],
              validator: (value) {
                if (!value.isValidPassword) {
                  return 'Please enter a valid password';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                border: OutlineInputBorder(),
              ),
            ),
            BlocConsumer<LoginCubit, BaseState<User>>(
              buildWhen: (previous, current) => previous != current,
              bloc: _loginCubit,
              listener: (context, state) {
                if (state.isFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.failure!.message!),
                    ),
                  );
                } else if (state.isSuccess) {
                  Navigator.of(context).pushNamed(Routes.home);
                }
              },
              builder: (context, state) {
                if (state.isInProgress) {
                  return CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _loginCubit.login(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                    }
                  },
                  child: Text('Login'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
