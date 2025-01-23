import 'package:flutter/material.dart';
import 'package:task_management_test/configs/routing/routes.dart';
import 'package:task_management_test/features/auth/presentation/screens/login_screen.dart';
import 'package:task_management_test/features/auth/presentation/screens/register_screen.dart';
import 'package:task_management_test/features/tasks/domain/entities/task_entity.dart';
import 'package:task_management_test/features/tasks/presentation/screens/create_task_screen.dart';
import 'package:task_management_test/features/tasks/presentation/screens/edit_task_screen.dart';
import 'package:task_management_test/features/tasks/presentation/screens/tasks_screen.dart';

class AppRouting {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.home:
        return _customPageRoute(TasksScreen());

      case Routes.login:
        return _customPageRoute(LoginScreen());

      case Routes.register:
        return _customPageRoute(RegisterScreen());

      case Routes.createTaskScreen:
        return _customPageRoute(CreateTaskScreen());

      case Routes.editTaskScreen:
        final args = routeSettings.arguments as TaskEntity;
        return _customPageRoute(EditTaskScreen(taskEntity: args));

      default:
        return undefinedRoute();
    }
  }

  static PageRouteBuilder _customPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: ((context) => const Scaffold(
            body: Center(
              child: Text('No route found'),
            ),
          )),
    );
  }
}
