import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ngantor/services/providers/attendance_provider.dart';
import 'package:ngantor/services/providers/maps_provider.dart';
import 'package:ngantor/services/shared_preferences/prefs_handler.dart';
import 'package:ngantor/utils/colors/app_colors.dart';
import 'package:ngantor/utils/styles/app_btn_style.dart';
import 'package:ngantor/utils/widgets/dialog.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    final mapsProv = Provider.of<MapsProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        actions: [
          CircleAvatar(
            backgroundColor: AppColors.accent,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: Center(
              child: StreamBuilder<DateTime>(
                stream: Stream.periodic(Duration(seconds: 1), (_) => DateTime.now()),
                builder: (context, snapshot) {
                  final now = snapshot.data ?? DateTime.now();

                  final formattedDate = DateFormat("EEEE, d MMMM yyyy").format(now);
                  final formattedTime = DateFormat("HH:mm:ss").format(now);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        formattedTime,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))
              ),
            ),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          CustomDialog().loading(context);
          await mapsProv.fetchLocation();
          CustomDialog().hide(context);

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              String _currentAddress = mapsProv.currentAddress;
              String _currentAddress2 = mapsProv.currentAddress2;
              String _currentLatLong = mapsProv.currentLatLong;
              final _currentLat = mapsProv.currentLat;
              final _currentLong = mapsProv.currentLong;

              final attendProv = Provider.of<AttendanceProvider>(context);

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
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context, 
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Check out Kantor"),
                                    content: Text("Anda akan melakukan Check out di\n$_currentAddress2\n"),
                                    actionsAlignment: MainAxisAlignment.center,
                                    actions: [           
                                      ElevatedButton(
                                        onPressed: () async{
                                          String token = await PrefsHandler.getToken();
                                          print("isi token: $token");
                                          await attendProv.checkOutUser(context, lat: _currentLat, long: _currentLong, location: _currentLatLong, address: _currentAddress, token: token);
                                        }, 
                                        style: AppBtnStyle.merah,
                                        child: Text("Check out")
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.logout, color: Colors.white),
                            label: const Text("Check-out"),
                            style: AppBtnStyle.merah
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context, 
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Check in Kantor"),
                                    content: Text("Anda akan melakukan check in di\n$_currentAddress2\n"),
                                    actionsAlignment: MainAxisAlignment.spaceBetween,
                                    actions: [
                                      TextButton(
                                        onPressed: (){}, 
                                        child: Text("Izin", style: TextStyle(color: AppColors.textPrimary))
                                      ),
                                                  
                                      ElevatedButton(
                                        onPressed: () async{
                                          String token = await PrefsHandler.getToken();
                                          print("isi token: $token");
                                          await attendProv.checkInUser(context, lat: _currentLat, long: _currentLong, address: _currentAddress, token: token);
                                        }, 
                                        style: AppBtnStyle.hijau,
                                        child: Text("Check in")
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.login, color: Colors.white),
                            label: const Text("Check-In"),
                            style: AppBtnStyle.hijau
                          ),
                        ),
                      ],
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