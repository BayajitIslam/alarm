import 'package:alarm/util/app_color/app_colors.dart';
import 'package:flutter/material.dart';

class CustomeSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const CustomeSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomeSwitch> createState() => _CustomeSwitchState();
}

class _CustomeSwitchState extends State<CustomeSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 33,
        height: 16,
        decoration: BoxDecoration(
          color: widget.value ? AppColors.brand : AppColors.secandary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: AnimatedAlign(
          alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
          duration: Duration(microseconds: 200),
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary
            ),
          ),
        ),
      ),
    );
  }
}
