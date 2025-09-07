import 'package:alarm/util/app_color/app_colors.dart';
import 'package:flutter/material.dart';

class CustomeIndicator extends StatelessWidget {
  final int index;
  const CustomeIndicator({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(3, (dotIndex) {
          return Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: index == dotIndex ? AppColors.brand : AppColors.secandary,
            ),
            margin: EdgeInsets.only(right: 4, left: 4),
          );
        }),
      ],
    );
  }
}
