import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_test/configs/routing/routes.dart';
import 'package:task_management_test/core/widgets/base_state.dart';
import 'package:task_management_test/core/utils/string_validator.dart';
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
            CustomTextFormField(
              controller: _emailController,
              validationType: ValidationType.email,
              label: 'Email',
              hint: 'Enter your email',
            ),
            CustomTextFormField(
              controller: _passwordController,
              validationType: ValidationType.password,
              label: 'Password',
              hint: 'Enter your password',
              isPassword: true,
            ),
            CustomTextFormField(
              controller: _confirmPasswordController,
              validationType: ValidationType.password,
              hint: 'Confirm your password',
              label: 'Confirm Password',
              isPassword: true,
            ),
            BlocConsumer<RegisterCubit, BaseState<User>>(
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
