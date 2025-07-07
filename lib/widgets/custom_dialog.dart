import 'package:flutter/material.dart';

class CustomSelectionDialog<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final T? selectedItem;
  final String Function(T) itemLabelBuilder;

  const CustomSelectionDialog({
    Key? key,
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.itemLabelBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          children: items.map((item) {
            return RadioListTile<T>(
              title: Text(itemLabelBuilder(item)),
              value: item,
              groupValue: selectedItem,
              onChanged: (value) => Navigator.pop(context, value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
