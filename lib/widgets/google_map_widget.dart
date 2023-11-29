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
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Set<Marker> markers = Set();

  var selectedRadius = 10; // Default radius
   double lat = 20.427 ;
   double long = 80.885 ;

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError((error,
        stackTrace) async {
      await Geolocator.requestPermission();
      if (kDebugMode) {
        print("ERROR$error");
      }
    });
    return await Geolocator.getCurrentPosition();
  }

  // Method to filter markers based on the selected radius

  var radiusList = [10, 20, 30, 40, 50];

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
                  updateMap(lat, long, newValue) ;
                  // Call the method to filter markers based on the selected radius
                });
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: kGoogle,
          markers: Set<Marker>.of(markers),
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
            lat = value.latitude ;
            long = value.longitude ;

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
            controller.animateCamera(
                CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: const Icon(Icons.local_activity, color: AppColors.white),
      ),
    );
  }


  void updateMap(double centerLat, double centerLng, int radius) async {
    // Clear existing markers
    markers.clear();

    // Add new markers based on the selected radius
    // This is a simple example with a hardcoded marker; replace it with your own logic
    markers.add(
      Marker(
        markerId: const MarkerId("1"),
        position: LatLng(centerLat + 0.01, centerLng + 0.01),
        infoWindow: const InfoWindow(title: "Marker 1"),
        icon: await getMarkerIcon("https://urlsdemo.xyz/flikka/images/seekers/defalt_profile.png",40),
      ),
    );

    // Get the current location
    Position currentPosition = await Geolocator.getCurrentPosition();

    // Generate multiple markers within the specified range (e.g., 10 to 50 miles)
    for (double distance = 10.0; distance <= 50.0; distance += 10.0) {
      double bearing = 45.0 * distance; // Adjust as needed
      double markerLat = centerLat + (distance / 69.0) * cos(bearing);
      double markerLng = centerLng + (distance / 69.0) * sin(bearing);


      // Calculate distance in meters using the Haversine formula
      double distanceInMeters = Geolocator.distanceBetween(
        currentPosition.latitude,
        currentPosition.longitude,
        centerLat,
        centerLng,
      );

      // Convert distance to miles
      double distanceInMiles = distanceInMeters / 1609.344;

      print("Distance from current location to center: $distanceInMiles miles");

      // Filter markers within the specified radius
      double markerDistance = Geolocator.distanceBetween(
        currentPosition.latitude,
        currentPosition.longitude,
        markerLat,
        markerLng,
      ) / 1609.344; //

      if (markerDistance <= radius) {
        markers.add(
          Marker(
            markerId: MarkerId(distance.toString()),
            position: LatLng(markerLat, markerLng),
            infoWindow: InfoWindow(title: "Marker $distance"),
            icon: await getMarkerIcon("https://urlsdemo.xyz/flikka/images/seekers/defalt_profile.png",40),
          ),
        );
      }

      // Update the map
      if (mapController != null) {
        GoogleMapController controller = await mapController.future;
        controller.animateCamera(
            CameraUpdate.newLatLng(LatLng(centerLat, centerLng)));
      }

      // Trigger a rebuild to update the markers on the map
      setState(() {});
    }
  }

  Future<BitmapDescriptor> getMarkerIcon(String imageURL, double size) async {
    final Completer<BitmapDescriptor> completer = Completer<BitmapDescriptor>();

    final ImageConfiguration configuration =  ImageConfiguration();
    final ImageProvider<Object> provider = CachedNetworkImageProvider(imageURL, maxHeight: 50 , maxWidth: 50);

    // Add a post-frame callback to capture the image when it's ready
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Resolve the image
      final ImageStreamListener listener = ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) async {
        // Convert the image to bytes
        final ByteData? data = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
        final Uint8List? bytes = data?.buffer.asUint8List();

        // Create a BitmapDescriptor from the bytes with a specific size
        final BitmapDescriptor bitmapDescriptor = BitmapDescriptor.fromBytes(bytes!, size: Size.square(size));

        // Complete the completer with the BitmapDescriptor
        completer.complete(bitmapDescriptor);
      });

      // Listen for the image resolution
      final ImageStream stream = provider.resolve(configuration);
      stream.addListener(listener);
    });

    return completer.future;
  }


  // Future<BitmapDescriptor> getMarkerIcon(String imageURL, double size, Color backgroundColor) async {
  //   final Completer<BitmapDescriptor> completer = Completer<BitmapDescriptor>();
  //
  //   final ImageConfiguration configuration = ImageConfiguration();
  //   final ImageProvider<Object> provider = CachedNetworkImageProvider(imageURL);
  //
  //   // Add a post-frame callback to capture the image when it's ready
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     // Resolve the image
  //     final ImageStreamListener listener = ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) async {
  //       // Convert the image to bytes
  //       final ByteData? data = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
  //       final Uint8List? bytes = data?.buffer.asUint8List();
  //
  //       // Create a circular marker with a background
  //       final pictureRecorder = PictureRecorder();
  //       final canvas = Canvas(pictureRecorder);
  //       final markerPaint = Paint()..color = backgroundColor;
  //
  //       canvas.drawCircle(Offset(size / 2.0, size / 2.0), size / 2.0, markerPaint);
  //       canvas.drawCircle(Offset(size / 2.0, size / 2.0), size / 2.0 - 2, markerPaint);
  //
  //       final codec = await ui.instantiateImageCodec(Uint8List.fromList(bytes!));
  //       final frameInfo = await codec.getNextFrame();
  //       canvas.drawImage(frameInfo.image, Offset(0.0, 0.0), Paint());
  //
  //       final picture = pictureRecorder.endRecording();
  //       final img = await picture.toImage(size.toInt(), size.toInt());
  //       final imgByteData = await img.toByteData(format: ui.ImageByteFormat.png);
  //       final Uint8List markerBytes = imgByteData!.buffer.asUint8List();
  //
  //       // Create a BitmapDescriptor from the bytes with a specific size
  //       final BitmapDescriptor bitmapDescriptor = BitmapDescriptor.fromBytes(markerBytes, size: Size.square(size));
  //
  //       // Complete the completer with the BitmapDescriptor
  //       completer.complete(bitmapDescriptor);
  //     });
  //
  //     // Listen for the image resolution
  //     final ImageStream stream = provider.resolve(configuration);
  //     stream.addListener(listener);
  //   });
  //
  //   return completer.future;
  // }


  // Future<BitmapDescriptor> getMarkerIcon(String imageURL, double size, Color backgroundColor) async {
  //   final Completer<BitmapDescriptor> completer = Completer<BitmapDescriptor>();
  //
  //   try {
  //     final ImageConfiguration configuration = ImageConfiguration();
  //     final ImageProvider<Object> provider = CachedNetworkImageProvider(imageURL);
  //
  //     WidgetsBinding.instance?.addPostFrameCallback((_) async {
  //       try {
  //         final ImageStreamListener listener = ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) async {
  //           try {
  //             final ByteData? data = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
  //             final Uint8List? bytes = data?.buffer.asUint8List();
  //
  //             final recorder = ui.PictureRecorder();
  //             final canvas = Canvas(recorder);
  //             final markerPaint = Paint()..color = backgroundColor;
  //
  //             // Draw a circle as the background
  //             canvas.drawCircle(Offset(size / 2.0, size / 2.0), size / 2.0, markerPaint);
  //
  //             // Decode the image from bytes
  //             final ui.Image image = await decodeImageFromList(bytes!)!;
  //
  //             // Draw the image as a circular mask
  //             final RRect imageRect = RRect.fromRectAndRadius(Rect.fromLTWH(0.0, 0.0, size, size), Radius.circular(size / 2.0));
  //             final paint = Paint()..shader = ui.ImageShader(
  //               image,
  //               TileMode.clamp, TileMode.clamp, Matrix4.identity().storage,
  //             );
  //             canvas.drawRRect(imageRect, paint);
  //
  //             // Convert the PictureRecorder to an Image
  //             final picture = recorder.endRecording();
  //             final img = await picture.toImage(size.toInt(), size.toInt());
  //
  //             // Convert the Image to bytes
  //             final ByteData? imgByteData = await img.toByteData(format: ui.ImageByteFormat.png);
  //             final Uint8List markerBytes = imgByteData!.buffer.asUint8List();
  //
  //             // Create a BitmapDescriptor from the bytes with a specific size
  //             final BitmapDescriptor bitmapDescriptor = BitmapDescriptor.fromBytes(markerBytes, size: Size.square(size));
  //
  //             completer.complete(bitmapDescriptor);
  //           } catch (e) {
  //             print('Error processing image: $e');
  //             completer.completeError(e);
  //           }
  //         });
  //
  //         final ImageStream stream = provider.resolve(configuration);
  //         stream.addListener(listener);
  //       } catch (e) {
  //         print('Error loading image: $e');
  //         completer.completeError(e);
  //       }
  //     });
  //   } catch (e) {
  //     print('Error initializing marker: $e');
  //     completer.completeError(e);
  //   }
  //
  //   return completer.future;
  // }

}
