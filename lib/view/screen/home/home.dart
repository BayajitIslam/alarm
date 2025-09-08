import 'package:alarm/model/alarm_model/alarm_model.dart';
import 'package:alarm/util/app_color/app_colors.dart';
import 'package:alarm/util/app_image/app_image.dart';
import 'package:alarm/util/app_static_text/app_static.dart';
import 'package:alarm/util/local_database/local_database.dart';
import 'package:alarm/view/screen/home/alarm_tile/alarm_tile.dart';
import 'package:alarm/view/widget/custome_button/custome_button.dart';
import 'package:alarm/view/widget/custome_text/custome_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Local Storage
  final LocalStorage db = LocalStorage();

  //<=========== Aarm List ==========>
  final List<AlarmModel> alarmList = [];

  @override
  Widget build(BuildContext context) {
    //storage adress
    String? address = db.read("location");

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 175),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //<=========== Selected Location ==========>
                  CustomeText(
                    text: AppStatic.selectedLocation,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),

                  //<=========== Current Location ==========>
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Image.asset(AppImage.locationTwo),

                      SizedBox(width: 9),
                      Expanded(
                        child: CustomeText(
                          text: address ?? AppStatic.defaultLocation,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  //<=========== Add Alarm Button ==========>
                  SizedBox(height: 10),
                  CustomeButton(
                    height: 48,
                    buttonName: AppStatic.addAlarm,
                    fontsize: 14,
                    bgColor: AppColors.buttonBg,
                    redius: 4,
                    onTap: () {
                      //<=========== Add Alarm Method ==========>
                      //<=========== show Date & time picker ==========>
                      //<===========  Date picker ==========>
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime.now(),
                        maxTime: DateTime(2099, 3, 25),
                        onConfirm: (DateTime? date) {
                          if (date == null) return;

                          //<===========  time picker ==========>
                          DatePicker.showTimePicker(
                            context,
                            showTitleActions: true,
                            onConfirm: (DateTime? time) {
                              if (time == null) return;

                              //<=========== Join time and date ==========>
                              final dateTime = DateTime(
                                date.year,
                                date.month,
                                date.day,
                                time.hour,
                                time.minute,
                              );

                              //<=========== add to list ==========>
                              setState(() {
                                alarmList.add(
                                  AlarmModel(
                                    dateTime: dateTime,
                                    isActive: true,
                                  ),
                                );
                              });
                            },
                          );
                        },

                        currentTime: DateTime.now(),
                        locale: LocaleType.en,
                      );
                    },
                  ),
                ],
              ),
            ),
            //<=========== Alarm Text ==========>
            SizedBox(height: 34),
            CustomeText(
              text: AppStatic.alarms,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),

            //<=========== List Of Alarm ==========>
            Expanded(
              child: ListView.builder(
                itemCount: alarmList.length,
                itemBuilder: (context, index) {
                  //individual alarm
                  final dt = alarmList[index];
                  return AlarmTile(
                    alarmModel: AlarmModel(
                      dateTime: dt.dateTime,
                      isActive: dt.isActive,
                    ),
                    onChanged: (value) {
                      setState(() {
                        dt.isActive = value;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
