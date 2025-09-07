import 'package:alarm/util/app_color/app_colors.dart';
import 'package:alarm/view/widget/custome_text/custome_text.dart';
import 'package:flutter/material.dart';


class CustomeButton extends StatelessWidget {
  final String buttonName;
  final void Function()? onTap;
  const CustomeButton({
    super.key,
    required this.buttonName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.brand,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: CustomeText(
            text: buttonName,
            color: AppColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}