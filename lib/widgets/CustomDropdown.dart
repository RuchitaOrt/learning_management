import 'package:flutter/material.dart';
import '../Utils/learning_colors.dart';
import '../Utils/lms_styles.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final String hintText;
  final List<T> items;
  final String Function(T)? itemToString;
  final Widget Function(T)? itemBuilder;
  final void Function(T?)? onChanged;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.hintText,
    required this.items,
    this.itemToString,
    this.itemBuilder,
    this.onChanged,
    this.height = 38,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: LearningColors.darkBlue.withOpacity(0.2),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          hint: Text(
            hintText,
            style: LMSStyles.tsHeading.copyWith(
              fontSize: 16,
              color: LearningColors.neutral500,
            ),
          ),
          dropdownColor: Colors.white,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: LearningColors.darkBlue,
          ),
          style: LMSStyles.tsHeading.copyWith(
            color: LearningColors.black,
          ),
          borderRadius: BorderRadius.circular(12),
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: itemBuilder?.call(item) ?? Text(
                itemToString?.call(item) ?? item.toString(),
                style: LMSStyles.tsHeading.copyWith(fontSize: 16),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}