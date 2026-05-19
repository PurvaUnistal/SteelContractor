import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_color.dart';

class ActivityMeta {
  final IconData icon;
  final Color iconColor, iconBg, iconBorder, barColor;

  const ActivityMeta({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.iconBorder,
    required this.barColor,
  });
}

// ✅ Fix 1: All items are `const`, and the list itself is `const`
const List<ActivityMeta> metas = [
  ActivityMeta(
    icon: Icons.bolt_rounded,
    iconColor: AppColor.purple,
    iconBg: AppColor.purpleBg,
    iconBorder: AppColor.purpleBd,
    barColor: AppColor.red,
  ),
  ActivityMeta(
    icon: Icons.verified_user_outlined,
    iconColor: AppColor.green,
    iconBg: AppColor.greenBg,
    iconBorder: AppColor.greenBorder,
    barColor: AppColor.green,
  ),
  ActivityMeta(
    icon: Icons.inventory_2_outlined,
    iconColor: AppColor.amber,
    iconBg: AppColor.amberBg,
    iconBorder: AppColor.amberDark,
    barColor: AppColor.amber,
  ),
  ActivityMeta(
    icon: Icons.description_outlined,
    iconColor: AppColor.blue,
    iconBg: AppColor.blueBg,
    iconBorder: AppColor.blueBorder,
    barColor: AppColor.blue,
  ),
  ActivityMeta(
    icon: Icons.alt_route_rounded,
    iconColor: AppColor.purple,
    iconBg: AppColor.purpleBg,
    iconBorder: AppColor.purpleBd,
    barColor: AppColor.red,

  ),
  ActivityMeta(
    icon: Icons.auto_graph_rounded,
    iconColor: AppColor.green,
    iconBg: AppColor.greenBg,
    iconBorder: AppColor.greenBorder,
    barColor: AppColor.amber,
  ),
  ActivityMeta(
    icon: Icons.comment_bank_outlined,
    iconColor: AppColor.blue,
    iconBg: AppColor.blueBg,
    iconBorder: AppColor.blueBorder,
    barColor: AppColor.green,
  ),
  ActivityMeta(
    icon: Icons.offline_share_outlined,
    iconColor: AppColor.amber,
    iconBg: AppColor.amberBg,
    iconBorder: AppColor.amberDark,
    barColor: AppColor.blue,
  ),
  ActivityMeta(
    icon: Icons.terrain_rounded,
    iconColor: AppColor.purple,
    iconBg: AppColor.purpleBg,
    iconBorder: AppColor.purpleBd,
    barColor: AppColor.purple,
  ),
  ActivityMeta(
    icon: Icons.air_rounded,
    iconColor: AppColor.blue,
    iconBg: AppColor.blueBg,
    iconBorder: AppColor.blueBorder,
    barColor: AppColor.amber,
  ),
];
