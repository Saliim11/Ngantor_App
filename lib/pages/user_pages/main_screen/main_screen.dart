import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ngantor/services/providers/maps_provider.dart';
import 'package:ngantor/utils/colors/app_colors.dart';
import 'package:ngantor/utils/styles/app_btn_style.dart';
import 'package:ngantor/utils/widgets/loading_dialog.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mapsProv = Provider.of<MapsProvider>(context);

    final Completer<GoogleMapController> _controller =
       Completer<GoogleMapController>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          CircleAvatar(
            backgroundColor: AppColors.primary,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showLoadingDialog(context);
          await mapsProv.fetchLocation();
          hideLoadingDialog(context);

          showModalBottomSheet(
            context: context,
            builder: (context) {
              String _currentAddress = mapsProv.currentAddress;
              String _currentLatLong = mapsProv.currentLatLong;
              final _currentLat = mapsProv.currentLat;
              final _currentLong = mapsProv.currentLong;

              return Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        height: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(_currentLat, _currentLong),
                              zoom: 14.4746,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                            mapType: MapType.normal,
                            myLocationEnabled: true,
                            compassEnabled: true,
                            // circles: Set<Circle>.of(<Circle>[
                            //   Circle(
                            //     circleId: const CircleId("circle"),
                            //     center: LatLng(_currentLat, _currentLong),
                            //     radius: 5,
                            //     fillColor: AppColors.accent.withOpacity(
                            //       0.5,
                            //     ),
                            //     strokeWidth: 2,
                            //     strokeColor: AppColors.accent,
                            //   ),
                            // ]),
                            gestureRecognizers: {
                              Factory<OneSequenceGestureRecognizer>(
                                () => EagerGestureRecognizer(),
                              ),
                            },
                          ),
                        ),
                    ),

                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // aksi check-in
                        },
                        icon: const Icon(Icons.login, color: Colors.white),
                        label: const Text("Check-In Sekarang"),
                        style: AppBtnStyle.hijau
                      ),
                    ),
                  ],
                )
              );
            },
          );
        },
        child: Icon(Icons.event_available_outlined, color: Colors.white,),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}