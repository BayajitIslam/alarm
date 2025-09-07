import 'package:alarm/util/app_color/app_colors.dart';
import 'package:alarm/util/app_image/app_image.dart';
import 'package:alarm/util/app_static_text/app_static.dart';
import 'package:alarm/view/screen/location/location_screen.dart';
import 'package:alarm/view/widget/custome_button/custome_button.dart';
import 'package:alarm/view/widget/custome_indicator/custome_indicator.dart';
import 'package:alarm/view/widget/custome_text/custome_text.dart';
import 'package:flutter/material.dart';

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 429,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),

              //<=========== Background Gif ==========>
              image: DecorationImage(
                image: AssetImage(AppImage.morining),
                fit: BoxFit.cover,
              ),
            ),

            //<=========== Skip Button ==========>
            child: Padding(
              padding: const EdgeInsets.only(top: 32, left: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationScreen(),
                        ),
                      );
                    },
                    child: CustomeText(
                      text: AppStatic.skip,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //<=========== Title ==========>
          SizedBox(height: 18),
          CustomeText(
            text: AppStatic.onbTwoTitle,
            fontSize: 34,
            fontWeight: FontWeight.bold,
            maxLines: 2,
            textAlign: TextAlign.left,
            left: 16,
            right: 16,
          ),

          //<=========== Sub  Title ==========>
          SizedBox(height: 16),
          CustomeText(
            text: AppStatic.onbTwoSubTitle,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            maxLines: 4,
            textAlign: TextAlign.left,
            right: 16,
            left: 16,
          ),

          //<=========== Indicator ==========>
          Spacer(),
          CustomeIndicator(index: 1),

          //<=========== Button ==========>
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomeButton(
              buttonName: AppStatic.next,

              onTap: () {
                //<=========== Route to  next pages ==========>
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationScreen()),
                );
              },
            ),
          ),
          SizedBox(height: 70),
        ],
      ),
    );
  }
}
