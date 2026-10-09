import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapShopsPage extends ConsumerStatefulWidget {
  const MapShopsPage({super.key});

  @override
  ConsumerState createState() => _MapShopsPageState();
}

class _MapShopsPageState extends ConsumerState<MapShopsPage> {
  Position? _position;

  @override
  void initState() {
    super.initState();
    Geolocator.checkPermission().then((permission) {
      if (permission == LocationPermission.denied) {
        Geolocator.requestPermission().then((permission) {
          if (permission == LocationPermission.whileInUse ||
              permission == LocationPermission.always) {
            Geolocator.getCurrentPosition().then((position) {
              setState(() {
                _position = position;
              });
            });
          }
        });
      } else if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Geolocator.getCurrentPosition().then((position) {
          setState(() {
            _position = position;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mapController = MapController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Magasins'),
      ),
      //floatingActionButton: Column(
      //  mainAxisAlignment: MainAxisAlignment.end,
      //  children: [
      //    FloatingActionButton(
      //      child: Icon(Icons.zoom_in),
      //      onPressed: () => mapController.move(
      //        mapController.camera.center,
      //        mapController.camera.zoom + 1,
      //      ),
      //    ),
      //    FloatingActionButton(
      //      child: Icon(Icons.zoom_out),
      //      onPressed: () => mapController.move(
      //        mapController.camera.center,
      //        mapController.camera.zoom - 1,
      //      ),
      //    ),
      //  ],
      //),
      body: FlutterMap(
        //mapController: mapController,
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.flutter_shop',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(47.4735, -0.5521),
                child: Icon(Icons.shopping_bag_outlined),
              ),
              Marker(
                point: LatLng(48.8600, 2.3577),
                child: Icon(Icons.shopping_bag_outlined),
              ),
              Marker(
                point: LatLng(45.7640, 4.8357),
                child: Icon(Icons.shopping_bag_outlined),
              ), // Lyon
              Marker(
                point: LatLng(43.2965, 5.3698),
                child: Icon(Icons.shopping_bag_outlined),
              ), // Marseille
              Marker(
                point: LatLng(43.6047, 1.4442),
                child: Icon(Icons.shopping_bag_outlined),
              ), // Toulouse
              Marker(
                point: LatLng(43.7102, 7.2620),
                child: Icon(Icons.shopping_bag_outlined),
              ), // Nice
              Marker(
                point: LatLng(44.8378, -0.5792),
                child: Icon(Icons.shopping_bag_outlined),
              ),
              if (_position != null)
                Marker(
                  point: LatLng(_position!.latitude, _position!.longitude),
                  child: Icon(Icons.gps_fixed),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
