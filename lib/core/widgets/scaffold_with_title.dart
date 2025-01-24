import 'package:flutter/material.dart';
import 'package:task_management_test/core/settings/screen_settings.dart';

class ScaffoldWithTitle extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? bottomWidget;
  const ScaffoldWithTitle(
      {super.key, required this.title, required this.body, this.bottomWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomWidget,
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: ScreenSettings.verticalPadding,
          horizontal: ScreenSettings.horizontalPadding,
        ),
        child: body,
      ),
    );
  }
}
