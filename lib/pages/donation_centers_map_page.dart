import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class DonationCenter {
  final String name;
  final String details;
  final double latitude;
  final double longitude;

  DonationCenter({
    required this.name,
    required this.details,
    required this.latitude,
    required this.longitude,
  });
}

final List<DonationCenter> donationCenters = [
  DonationCenter(
    name: 'North Texas Food Bank',
    details: 'Food bank',
    latitude: 33.00709754281487,
    longitude: -96.7596757126027,
  ),
  DonationCenter(
    name: 'Seven Loaves Food Pantry',
    details: 'Food bank',
    latitude: 33.0207798397071,
    longitude: -96.82101812205197,
  ),
  DonationCenter(
    name: 'Comet Cupboard',
    details: 'Food bank',
    latitude: 32.9887147021269,
    longitude: -96.74714223104269,
  ),
  DonationCenter(
    name: 'City House',
    details: 'Homeless shelter',
    latitude: 33.0309696986485,
    longitude: -96.70361793104271,
  ),
  DonationCenter(
    name: 'Agape Resource & Assistance Center, Inc.',
    details: 'Non-profit organization',
    latitude: 33.022734716836396,
    longitude: -96.70111579929966,
  ),
  // Add more centers here
];

class DonationCentersMapPage extends StatefulWidget {
  const DonationCentersMapPage({Key? key}) : super(key: key);

  @override
  createState() => _DonationCentersMapPageState();
}

class _DonationCentersMapPageState extends State<DonationCentersMapPage> {
  final LatLng _initialCameraPosition = const LatLng(
      33.00709754281487, -96.7596757126027); // Example initial position
  late GoogleMapController _controller;

  @override
  void initState() {
    super.initState();
    _requestPermissions(); // Request permissions on widget initialization
  }

  Future<void> _requestPermissions() async {
    final status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      // Permissions are granted, you might want to update the state to reflect the permission status
    } else {
      // Permissions are denied, handle accordingly
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Location permission is required to use the map feature')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = donationCenters
        .map((center) => Marker(
              markerId: MarkerId(center.name),
              position: LatLng(center.latitude, center.longitude),
              infoWindow: InfoWindow(
                title: center.name,
                snippet: center.details,
                onTap: () => _launchMapsUrl(center.latitude, center.longitude),
              ),
            ))
        .toSet();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Donation Centers'),
      ),
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: _initialCameraPosition, zoom: 12),
        markers: markers,
        onMapCreated: (controller) => _controller = controller,
        myLocationButtonEnabled:
            true, // Optionally enable the location button if permissions are granted
        myLocationEnabled:
            true, // Show the user's current location if permissions are granted
      ),
    );
  }

  void _launchMapsUrl(double lat, double lng) async {
    final url = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng');
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
