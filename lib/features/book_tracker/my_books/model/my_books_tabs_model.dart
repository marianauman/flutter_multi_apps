import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class MyBooksTabsModel {
  final String title;
  final IconData icon;
  final Color color;
  final int count;
  final BookStatus status;
  final bool isSelected;

  MyBooksTabsModel({
    required this.title,
    required this.icon,
    required this.color,
    required this.count,
    required this.status,
    this.isSelected = false,
  });
}