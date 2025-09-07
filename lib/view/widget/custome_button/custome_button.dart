import 'package:alarm/util/app_color/app_colors.dart';
import 'package:alarm/util/app_image/app_image.dart';
import 'package:alarm/view/widget/custome_text/custome_text.dart';
import 'package:flutter/material.dart';

class CustomeButton extends StatelessWidget {
  final String buttonName;
  final void Function()? onTap;
  final Color bgColor;
  final String icon;
  final bool isIconEnable;
  final double height;
  final int fontsize;
  final double redius;
  const CustomeButton({
    super.key,
    required this.buttonName,
    required this.onTap,
    this.bgColor = AppColors.brand,
    this.icon = AppImage.location,
    this.isIconEnable = false,
    this.height = 56,
    this.fontsize = 16,
    this.redius =  8
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(redius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomeText(
              text: buttonName,
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),

            isIconEnable
                ? Image.asset(icon, height: 24, width: 24)
                : Container(),
          ],
        ),
      ),
    );
  }
}
