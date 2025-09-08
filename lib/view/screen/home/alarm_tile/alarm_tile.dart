import 'package:alarm/model/alarm_model/alarm_model.dart';
import 'package:alarm/util/app_color/app_colors.dart';
import 'package:alarm/view/widget/custome_text/custome_switch.dart';
import 'package:alarm/view/widget/custome_text/custome_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AlarmTile extends StatelessWidget {
  final AlarmModel alarmModel;
  final void Function(bool) onChanged;
  const AlarmTile({
    super.key,
    required this.alarmModel,
    required this.onChanged,
  });

  final bool alarmValue = false;

  @override
  Widget build(BuildContext context) {
    //extract date and time
    final dt = alarmModel.dateTime;
    final timeText =
        "${dt.hour.toString().padLeft(2, "0")}:${dt.minute.toString().padLeft(2, "0")}";

    final dateText = DateFormat('EEE dd MMM yyyy').format(dt);

    return Container(
      width: double.infinity,
      height: 84,
      decoration: BoxDecoration(
        color: AppColors.buttonBg,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          CustomeText(
            text: timeText,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
          Spacer(),
          CustomeText(
            text: dateText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),

          //switch
          SizedBox(width: 8),
          CustomeSwitch(value: alarmModel.isActive, onChanged: onChanged),
        ],
      ),
    );
  }
}
