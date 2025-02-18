import 'package:flutter/material.dart';
import 'package:flutter_custom_widgets/meal_card/meal_card.dart';

final routes = <PageRoute>[
  PageRoute(
    routeName: MealCardPage.routeName,
    title: 'Meal Card',
    widget: const MealCardPage(),
  ),
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
