import 'package:flutter/material.dart';
import 'package:flutter_custom_widgets/meal_card/meal_card.dart';
import 'package:flutter_custom_widgets/round_progress_upload_animation/upload_progress_page.dart';
import 'package:flutter_custom_widgets/telegram_theme_switcher_animation/tg_theme_switcher_page.dart';

final routes = <PageRoute>[
  PageRoute(
    routeName: MealCardPage.routeName,
    title: 'Meal Card',
    widget: const MealCardPage(),
  ),
  PageRoute(
      routeName: TelegramThemeSwitcherPage.routeName,
      title: 'Telegram Theme Switcher Animation',
      widget: const TelegramThemeSwitcherPage()),
  PageRoute(
      routeName: UploadProgressPage.routeName,
      title: 'Upload Progress Animation',
      widget: const UploadProgressPage())
];

class PageRoute {
  final String routeName;
  final String title;
  final bool isUnfinished;
  final Widget widget;

  PageRoute({
    required this.routeName,
    required this.title,
    required this.widget,
    this.isUnfinished = false,
  });
}
