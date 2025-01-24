import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_test/configs/routing/routes.dart';
import 'package:task_management_test/core/widgets/base_state.dart';
import 'package:task_management_test/core/utils/string_validator.dart';
import 'package:task_management_test/core/widgets/widgets.dart';
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
    return ScaffoldWithTitle(
      title: 'Login',
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            CustomTextFormField(
              controller: _emailController,
              validationType: ValidationType.email,
              label: 'Email',
              hint: 'Enter your email',
            ),
            CustomTextFormField(
              controller: _passwordController,
              isPassword: true,
              validationType: ValidationType.password,
              label: 'Password',
              hint: 'Enter your password',
            ),
            BlocConsumer<LoginCubit, BaseState<User>>(
              bloc: _loginCubit,
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
                      _loginCubit.login(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                    }
                  },
                  title: 'Login',
                );
              },
            ),
            CustomElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.register);
              },
              title: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
