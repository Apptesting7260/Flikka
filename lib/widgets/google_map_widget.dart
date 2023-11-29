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
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapIntegration extends StatefulWidget {
  const GoogleMapIntegration({Key? key}) : super(key: key);

  @override
  GoogleMapIntegrationState createState() => GoogleMapIntegrationState();
}

class GoogleMapIntegrationState extends State<GoogleMapIntegration> {
  Completer<GoogleMapController> mapController = Completer();
  static const CameraPosition kGoogle = CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 10.4746,
  );

  final List<Marker> _markers = <Marker>[
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(20.42796133580664, 75.885749655962),
      infoWindow: InfoWindow(
        title: 'My Position',
      ),
    ),
  ];

  var selectedRadius = 10; // Default radius

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      if (kDebugMode) {
        print("ERROR$error");
      }
    });
    return await Geolocator.getCurrentPosition();
  }

  // Method to filter markers based on the selected radius
  void _filterMarkers(radius) {
    Position currentPosition;
    getUserCurrentLocation().then((value) {
      currentPosition = value;

      // Clear existing markers
      _markers.clear();

      // Add marker for the current user's location
      _markers.add(
        Marker(
          markerId: const MarkerId("2"),
          position: LatLng(currentPosition.latitude, currentPosition.longitude),
          infoWindow: const InfoWindow(
            title: 'My Current Location',
          ),
        ),
      );

      // Example markers within the specified radius (adjust as needed)
      // In a real scenario, you would retrieve these from your data source
      _markers.add(
        Marker(
          markerId: const MarkerId("3"),
          position: LatLng(currentPosition.latitude + 0.01, currentPosition.longitude + 0.01),
          infoWindow: const InfoWindow(
            title: 'Location A',
          ),
        ),
      );
      _markers.add(
        Marker(
          markerId: const MarkerId("4"),
          position: LatLng(currentPosition.latitude - 0.02, currentPosition.longitude - 0.02),
          infoWindow: const InfoWindow(
            title: 'Location B',
          ),
        ),
      );
      // Add more markers as needed
      for (int value in radiusList) {
        _addMarkersWithinRadius(currentPosition, value);
      }
      // Update the UI
      setState(() {});
    });
  }

  var radiusList = [10, 20, 30, 40, 50] ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text("Choose Location"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              value: selectedRadius,
              items: radiusList.map<DropdownMenuItem>((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text('$value miles'),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedRadius = newValue;
                  // Call the method to filter markers based on the selected radius
                  _filterMarkers(selectedRadius);
                });
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: kGoogle,
          markers: Set<Marker>.of(_markers),
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            mapController.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.black,
        onPressed: () async {
          getUserCurrentLocation().then((value) async {
            if (kDebugMode) {
              print("${value.latitude} ${value.longitude}");
            }

            // Marker added for the current user's location
            _markers.add(
              Marker(
                markerId: const MarkerId("2"),
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
        },
        child: const Icon(Icons.local_activity, color: AppColors.white),
      ),
    );
  }

  void _addMarkersWithinRadius(Position currentPosition, int radius) {
    _markers.add(
      Marker(
        markerId: MarkerId("Marker_${radius.toString()}"),
        position: LatLng(currentPosition.latitude + 0.01, currentPosition.longitude + 0.01),
        infoWindow: InfoWindow(
          title: 'Location within $radius miles',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId("Marker_${radius.toString()}"),
        position: LatLng(currentPosition.latitude - 0.02, currentPosition.longitude - 0.02),
        infoWindow: InfoWindow(
          title: 'Location within $radius miles',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId("Marker_${radius.toString()}"),
        position: LatLng(currentPosition.latitude + 0.03, currentPosition.longitude - 0.02),
        infoWindow: InfoWindow(
          title: 'Location within $radius miles',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId("Marker_${radius.toString()}"),
        position: LatLng(currentPosition.latitude + 0.2, currentPosition.longitude + 0.02),
        infoWindow: InfoWindow(
          title: 'Location within $radius miles',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId("Marker_${radius.toString()}"),
        position: LatLng(currentPosition.latitude + 0.2, currentPosition.longitude + 0.2),
        infoWindow: InfoWindow(
          title: 'Location within $radius miles',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId("Marker_${radius.toString()}"),
        position: LatLng(currentPosition.latitude + 0.07, currentPosition.longitude - 0.05),
        infoWindow: InfoWindow(
          title: 'Location within $radius miles',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId("Marker_${radius.toString()}"),
        position: LatLng(currentPosition.latitude - 0.05, currentPosition.longitude + 0.07),
        infoWindow: InfoWindow(
          title: 'Location within $radius miles',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId("Marker_${radius.toString()}"),
        position: LatLng(currentPosition.latitude + 0.2, currentPosition.longitude - 0.2),
        infoWindow: InfoWindow(
          title: 'Location within $radius miles',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId("Marker_${radius.toString()}"),
        position: LatLng(currentPosition.latitude - 0.3, currentPosition.longitude + 0.3),
        infoWindow: InfoWindow(
          title: 'Location within $radius miles',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId("Marker_${radius.toString()}"),
        position: LatLng(currentPosition.latitude  + .5, currentPosition.longitude + .5),
        infoWindow: InfoWindow(
          title: 'Location within $radius miles',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId("Marker_${radius.toString()}"),
        position: LatLng(currentPosition.latitude - 0.25, currentPosition.longitude + 0.057),
        infoWindow: InfoWindow(
          title: 'Location within $radius miles',
        ),
      ),
    );
    // Add more markers as needed
  }
}
