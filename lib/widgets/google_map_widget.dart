// import 'dart:async';
//
// import 'package:flikka/widgets/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class GoogleMapIntegration extends StatefulWidget {
//   const GoogleMapIntegration({Key? key}) : super(key: key);
//
//   @override
//   _GoogleMapIntegrationState createState() => _GoogleMapIntegrationState();
// }
//
// class _GoogleMapIntegrationState extends State<GoogleMapIntegration> {
//   Completer<GoogleMapController> _controller = Completer();
//   static final CameraPosition _kGoogle = const CameraPosition(
//     target: LatLng(20.42796133580664, 80.885749655962),
//     zoom: 10.4746,
//   );
//
// // on below line we have created the list of markers
//   final List<Marker> _markers = <Marker>[
//     Marker(
//         markerId: MarkerId('1'),
//         position: LatLng(20.42796133580664, 75.885749655962),
//         infoWindow: InfoWindow(
//           title: 'My Position',
//         )
//     ),
//   ];
//
// // created method for getting user current location
//   Future<Position> getUserCurrentLocation() async {
//     await Geolocator.requestPermission().then((value){
//     }).onError((error, stackTrace) async {
//       await Geolocator.requestPermission();
//       print("ERROR"+error.toString());
//     });
//     return await Geolocator.getCurrentPosition();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         title: const Text("Choose Location"),
//         centerTitle: true,
//       ),
//       body: Container(
//         child: SafeArea(
//           // on below line creating google maps
//           child: GoogleMap(
//             // on below line setting camera position
//             initialCameraPosition: _kGoogle,
//             // on below line we are setting markers on the map
//             markers: Set<Marker>.of(_markers),
//             // on below line specifying map type.
//             mapType: MapType.normal,
//             // on below line setting user location enabled.
//             myLocationEnabled: true,
//             // on below line setting compass enabled.
//             compassEnabled: true,
//             // on below line specifying controller on map complete.
//             onMapCreated: (GoogleMapController controller){
//               _controller.complete(controller);
//             },
//           ),
//         ),
//       ),
//       // on pressing floating action button the camera will take to user current location
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: AppColors.black,
//         onPressed: () async{
//           getUserCurrentLocation().then((value) async {
//             print(value.latitude.toString() +" "+value.longitude.toString());
//
//             // marker added for current users location
//             _markers.add(
//                 Marker(
//                   markerId: MarkerId("2"),
//                   position: LatLng(value.latitude, value.longitude),
//                   infoWindow: InfoWindow(
//                     title: 'My Current Location',
//                   ),
//                 )
//             );
//
//             // specified current users location
//             CameraPosition cameraPosition = new CameraPosition(
//               target: LatLng(value.latitude, value.longitude),
//               zoom: 14,
//             );
//
//             final GoogleMapController controller = await _controller.future;
//             controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//             setState(() {
//             });
//           });
//         },
//         child: Icon(Icons.local_activity,color: AppColors.white,),
//       ),
//     );
//   }
// }
//
//
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/Job%20Seeker/marketing_page.dart';
import 'package:flikka/controllers/SeekerMapJobsController/SeekerMapJobsController.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Job Seeker/SeekerBottomNavigationBar/tab_bar.dart';
import '../data/response/status.dart';
import '../res/components/general_expection.dart';
import '../res/components/internet_exception_widget.dart';
import '../res/components/request_timeout_widget.dart';

class GoogleMapIntegration extends StatefulWidget {
  final double? lat;
  final double? long;
  final bool? jobPageView;
  const GoogleMapIntegration({Key? key, this.lat, this.long, this.jobPageView})
      : super(key: key);

  @override
  GoogleMapIntegrationState createState() => GoogleMapIntegrationState();
}

class GoogleMapIntegrationState extends State<GoogleMapIntegration> {
  Completer<GoogleMapController> mapController = Completer();
  static const CameraPosition kGoogle = CameraPosition(
    target: LatLng(54.7024, -3.2768),
    zoom: 8,
  );

  Set<Marker> markers = Set();

  var selectedRadius; // Default radius
  double lat = 20.427;
  double long = 80.885;

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      if (kDebugMode) {
        print("ERROR$error");
      }
    });
    return await Geolocator.getCurrentPosition();
  }

  // Method to filter markers based on the selected radius

  var radiusList = [1, 2, 5, 10, 20, 30, 40, 50];

  SeekerMapJobsController jobsController = Get.put(SeekerMapJobsController());

  @override
  void initState() {
    if (widget.jobPageView != true) {
      jobsController.mapJobsApi();
      // updateUserLocation();
      updateMap(10);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.jobPageView == true
        ? SafeArea(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.lat ?? lat, widget.long ?? long),
                zoom: 5,
              ),
              markers: <Marker>{
                Marker(
                  markerId: const MarkerId("1"),
                  position: LatLng(widget.lat ?? lat, widget.long ?? long),
                  infoWindow: const InfoWindow(
                    title: "Job Location",
                  ),
                ),
              },
              mapType: MapType.normal,
              myLocationEnabled: true,
              compassEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                mapController.complete(controller);
              },
            ),
          )
        : Obx(() {
            switch (jobsController.rxRequestStatus.value) {
              case Status.LOADING:
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );

              case Status.ERROR:
                if (jobsController.error.value == 'No internet') {
                  return Scaffold(
                    body: InterNetExceptionWidget(
                      onPress: () {
                        jobsController.mapJobsApi();
                      },
                    ),
                  );
                } else if (jobsController.error.value == 'Request Time out') {
                  return Scaffold(
                    body: RequestTimeoutWidget(onPress: () {
                      jobsController.mapJobsApi();
                    }),
                  );
                } else {
                  return Scaffold(
                    body: GeneralExceptionWidget(onPress: () {
                      jobsController.mapJobsApi();
                    }),
                  );
                }
              case Status.COMPLETED:
                return Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 65,
                    leading: IconButton(
                        onPressed: () {
                          Get.offAll(const TabScreen(index: 0));
                        },
                        icon: Image.asset(
                          "assets/images/icon_back_blue.png",
                          height: Get.height * .06,
                        )),
                    backgroundColor: AppColors.black,
                    title: Text(
                      "Map",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(color: AppColors.white),
                    ),
                    // centerTitle: true,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          dropdownColor: AppColors.black,
                          hint: const Text("Select"),
                          value: selectedRadius,
                          items: radiusList.map<DropdownMenuItem>((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                '$value miles',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppColors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedRadius = newValue;
                              updateMap(newValue);
                              // Call the method to filter markers based on the selected radius
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  body: SafeArea(
                    child:  GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(54.7024, -3.2768), // Center of the UK
                        zoom: 6.0,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      onCameraMove: (CameraPosition position) {
                        if (!_allowedBounds.contains(position.target)) {
                          // If the new camera position is outside the allowed bounds, update the camera position
                          _updateCameraPosition(position);
                        }
                      },
                    ),
                    // GoogleMap(
                    //   initialCameraPosition: kGoogle,
                    //   markers: Set<Marker>.of(markers),
                    //   mapType: MapType.normal,
                    //   myLocationEnabled: true,
                    //   compassEnabled: true,
                    //   onMapCreated: (GoogleMapController controller) {
                    //     mapController.complete(controller);
                    //     LatLngBounds ukBounds = LatLngBounds(
                    //       southwest: const LatLng(49.823809, -7.572167), // Southwest coordinates
                    //       northeast: const LatLng(58.788884, 1.681530),  // Northeast coordinates
                    //     );
                    //     controller.moveCamera(
                    //       CameraUpdate.newLatLngBounds(ukBounds, 0), // No padding
                    //     );
                    //   },
                    // ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: AppColors.black,
                    onPressed: () async {
                      updateUserLocation();
                    },
                    child: const Icon(Icons.local_activity,
                        color: AppColors.white),
                  ),
                );
            }
          });
  }

  Completer<GoogleMapController> _controller = Completer();
  LatLngBounds _allowedBounds = LatLngBounds(
    southwest: LatLng(49.823809, -7.572167), // Southwest coordinates
    northeast: LatLng(58.788884, 1.681530),  // Northeast coordinates
  );

  Future<void> _updateCameraPosition(CameraPosition position) async {
    GoogleMapController controller = await _controller.future;

    // Calculate the constrained target coordinates
    double newLat = position.target.latitude.clamp(
      _allowedBounds.southwest.latitude,
      _allowedBounds.northeast.latitude,
    );
    double newLng = position.target.longitude.clamp(
      _allowedBounds.southwest.longitude,
      _allowedBounds.northeast.longitude,
    );

    // Update the camera position
    CameraPosition newPosition = CameraPosition(
      target: LatLng(newLat, newLng),
      zoom: position.zoom,
      tilt: position.tilt,
      bearing: position.bearing,
    );

    controller.moveCamera(CameraUpdate.newCameraPosition(newPosition));
  }

  void updateMap(int radius) async {
    // Clear existing markers
    markers.clear();

    Position currentPosition = await Geolocator.getCurrentPosition();

    if (jobsController.jobsData.value.jobs != null &&
        jobsController.jobsData.value.jobs?.length != 0) {
      for (int i = 0; i < jobsController.jobsData.value.jobs!.length; i++) {
        var data = jobsController.jobsData.value.jobs?[i];
        // Calculate distance in meters using the Haversine formula
        double distanceInMeters = Geolocator.distanceBetween(
          currentPosition.latitude,
          currentPosition.longitude,
          data?.lat,
          data?.long,
        );

        // Convert distance to miles
        double distanceInMiles = distanceInMeters / 1609.344;

        print(
            "Distance from current location to center: $distanceInMiles miles");

        // Filter markers within the specified radius
        double markerDistance = Geolocator.distanceBetween(
              currentPosition.latitude,
              currentPosition.longitude,
              data?.lat,
              data?.long,
            ) /
            1609.344; //

        if (markerDistance <= radius) {
          markers.add(Marker(
              markerId: MarkerId("${data?.id}"),
              position: LatLng(
                  double.parse("${data?.lat}"), double.parse("${data?.long}")),
              infoWindow:
                  InfoWindow(title: "${data?.recruiterDetails?.companyName}"),
              icon: await getMarkerIcon("assets/images/icon_map.png", 5),
              onTap: () async {
                debugPrint("tapped");
                Get.to(() =>
                    MarketingIntern(jobData: data, appliedJobScreen: false));
              }));
        }
        // Trigger a rebuild to update the markers on the map
      }
    }
    markers.add(
      Marker(
        markerId: const MarkerId("My location"),
        position: LatLng(lat, long),
        infoWindow: const InfoWindow(
          title: 'My Current Location',
        ),
      ),
    );
    setState(() {});
  }

  Future<BitmapDescriptor> getMarkerIcon(String assetName, double size) async {
    final ByteData data = await rootBundle.load(assetName);
    final Uint8List bytes = data.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(bytes, size: const Size(20, 20));
  }

  updateUserLocation() {
    getUserCurrentLocation().then((value) async {
      if (kDebugMode) {
        print("${value.latitude} ${value.longitude}");
      }
      lat = value.latitude;
      long = value.longitude;

      // Marker added for the current user's location
      markers.add(
        Marker(
          markerId: const MarkerId("1"),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(
            title: 'My Current Location',
          ),
        ),
      );

      // Specified current user's location
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );

      final GoogleMapController controller = await mapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  String getCustomMapStyle() {
    return '''
    [
      {
        "featureType": "administrative.land_parcel",
        "elementType": "labels",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "labels.text",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "poi.business",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "labels.icon",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "road.arterial",
        "elementType": "labels",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "labels",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "road.local",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "road.local",
        "elementType": "labels",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "transit",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      }
    ]
  ''';
  }
}
