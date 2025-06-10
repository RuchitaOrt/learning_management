import 'package:flutter/material.dart';

class TabDTO {
  String imagePathSelected;
  String imagePathUnselected;
  String name;
  bool isSelected;
  Widget pageIC;
  Widget pageManager;
  Function() onClicked;

  TabDTO({
    required this.name,
    required this.imagePathSelected,
    required this.imagePathUnselected,
    required this.isSelected,
    required this.pageIC,
    required this.pageManager,
    required this.onClicked,
  });
}
