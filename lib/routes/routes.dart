// GENERATED FILE - DO NOT EDIT MANUALLY
import 'package:flutter/material.dart';
import '../coverflow_carousel/coverflow_carousel_page.dart';
import '../round_progress_upload_animation/upload_progress_page.dart';
import '../telegram_theme_switcher_animation/tg_theme_switcher_page.dart';
final routes = <PageRoute>[
  const PageRoute(
    routeName: CoverFlowCarouselPage.routeName,
    title: 'Coverflow Carousel',
    widget: CoverFlowCarouselPage(),
  ),
  const PageRoute(
    routeName: UploadProgressPage.routeName,
    title: 'Upload Progress Animation',
    widget: UploadProgressPage(),
  ),
  const PageRoute(
    routeName: TelegramThemeSwitcherPage.routeName,
    title: 'Telegram Dark Mode Switcher Animation',
    widget: TelegramThemeSwitcherPage(),
  ),
];

class PageRoute {
  final String routeName;
  final String title;
  final Widget widget;
  final bool isUnfinished;

  const PageRoute({
    required this.routeName,
    required this.title,
    required this.widget,
    this.isUnfinished = false,
  });
}
