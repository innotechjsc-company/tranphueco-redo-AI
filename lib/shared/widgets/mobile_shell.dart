import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class MobileShell extends StatelessWidget {
  const MobileShell({
    super.key,
    required this.child,
    this.bottomBar,
    this.withTabBar = false,
    this.backgroundColor,
  });

  final Widget child;
  final Widget? bottomBar;
  final bool withTabBar;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background,
      extendBody: true,
      body: child,
      bottomNavigationBar: bottomBar,
    );
  }
}
