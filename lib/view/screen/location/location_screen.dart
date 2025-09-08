import 'package:alarm/util/app_color/app_colors.dart';
import 'package:alarm/util/app_image/app_image.dart';
import 'package:alarm/util/app_static_text/app_static.dart';
import 'package:alarm/util/local_database/local_database.dart';
import 'package:alarm/view/screen/home/home.dart';
import 'package:alarm/view/screen/location/location_controller/location_controller.dart';
import 'package:alarm/view/widget/custome_button/custome_button.dart';
import 'package:alarm/view/widget/custome_text/custome_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({super.key});

  final LocationController lc = LocationController();
  final LocalStorage db = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //<=========== Title ==========>
            CustomeText(
              text: AppStatic.locationTitle,
              fontSize: 34,
              fontWeight: FontWeight.bold,
              maxLines: 2,
              textAlign: TextAlign.start,
            ),

            //<=========== Sub Title ==========>
            SizedBox(height: 16),
            CustomeText(
              text: AppStatic.locationSubTitle,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              maxLines: 2,
              textAlign: TextAlign.start,
            ),

            //<=========== Photo ==========>
            SizedBox(height: 34),
            Image.asset(AppImage.wellcome),

            //<=========== Location Acces Button ==========>
            CustomeButton(
              bgColor: AppColors.buttonBg,
              isIconEnable: true,
              icon: AppImage.location,
              buttonName: AppStatic.useCurrentLocation,

              onTap: () async {
                //<=========== Location Acces Method ==========>
                try {
                  Position pos = await lc.determinePosition();
                  if (kDebugMode) {
                    print(
                      "Latitude: ${pos.latitude}, Longitude: ${pos.longitude}",
                    );
                    List<Placemark> placemarks = await placemarkFromCoordinates(
                      pos.latitude,
                      pos.longitude,
                    );
                    if (placemarks.isNotEmpty) {
                      Placemark place = placemarks[0];
                      String address =
                          "${place.street}, ${place.locality}, ${place.country}";
                      db.write("location", address);
                      if (kDebugMode) {
                        print("location : ${db.read("location")}");
                      }

                      //<=========== route to home ==========>
                      Navigator.push(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    }
                  }
                } catch (e) {
                  if (kDebugMode) {
                    print("$e");
                  }
                }
              },
            ),

            //<=========== Home Button ==========>
            SizedBox(height: 7),
            CustomeButton(
              bgColor: AppColors.buttonBg,
              buttonName: AppStatic.home,

              onTap: () {
                //<=========== print location ==========>

                if (kDebugMode) {
                  print("location : ${db.read("location")}");
                }
                //<=========== route to home ==========>
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
