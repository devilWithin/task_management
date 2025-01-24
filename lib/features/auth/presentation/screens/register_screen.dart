import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_test/configs/routing/routes.dart';
import 'package:task_management_test/core/base_state.dart';
import 'package:task_management_test/core/settings/screen_settings.dart';
import 'package:task_management_test/core/utils/string_validator.dart';
import 'package:task_management_test/core/widgets/custom_elevated_button.dart';
import 'package:task_management_test/core/widgets/widgets.dart';
import 'package:task_management_test/features/auth/presentation/cubit/register_cubit.dart';
import 'package:task_management_test/injection_container.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _registerCubit = sl<RegisterCubit>();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithTitle(
      title: 'Register',
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                  return 'Password Must be more than 5 Characters Alpha Numeric & Symbols';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                errorMaxLines: 2,
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: _confirmPasswordController,
              autofillHints: [AutofillHints.password],
              validator: (value) {
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Enter your password again',
                border: OutlineInputBorder(),
              ),
            ),
            BlocConsumer<RegisterCubit, BaseState<User>>(
              buildWhen: (previous, current) => previous != current,
              bloc: _registerCubit,
              listener: (context, state) {
                if (state.isFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.failure!.message!),
                    ),
                  );
                } else if (state.isSuccess) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.tasksScreen, (route) => false);
                }
              },
              builder: (context, state) {
                if (state.isInProgress) {
                  return CircularProgressIndicator();
                }
                return CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _registerCubit.register(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                    }
                  },
                  title: 'Create Account',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
