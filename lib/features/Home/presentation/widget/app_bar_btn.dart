import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_color.dart';

class AppBarBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const AppBarBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: AppColor.white, size: 16),
    );
  }
}