import 'package:flutter/material.dart';
import 'package:task_management_test/core/settings/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String? title;
  final double width;
  final double height;
  final void Function() onPressed;
  final Color? backgroundColor;
  final bool withBorder;
  final Color? borderColor;
  final Color? textColor;
  final Widget? child;
  final bool isActive;

  const CustomElevatedButton({
    super.key,
    this.title,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 54,
    this.backgroundColor = AppColors.primaryColor,
    this.withBorder = false,
    this.borderColor = AppColors.primaryColor,
    this.textColor,
    this.child,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isActive ? backgroundColor : AppColors.inActiveButtonColor,
        minimumSize: Size(width, height),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: withBorder ? BorderSide(color: borderColor!) : BorderSide.none,
        ),
      ),
      onPressed: onPressed,
      child: child ??
          Text(
            title!,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold, color: textColor ?? Colors.white),
          ),
    );
  }
}
