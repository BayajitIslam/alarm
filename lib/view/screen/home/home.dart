import 'package:alarm/util/app_color/app_colors.dart';
import 'package:alarm/util/app_image/app_image.dart';
import 'package:alarm/util/app_static_text/app_static.dart';
import 'package:alarm/util/local_database/local_database.dart';
import 'package:alarm/view/widget/custome_button/custome_button.dart';
import 'package:alarm/view/widget/custome_text/custome_text.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});

  //Local Storage
  final LocalStorage db = LocalStorage();

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
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
